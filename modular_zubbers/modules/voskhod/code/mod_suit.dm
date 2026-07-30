/obj/item/clothing/head/helmet/space/voskhod
	name = "\proper Voskhod-P depowered combat helmet"
	desc = "A composite graphene-plasteel helmet with a ballistic nylon inner padding, complete with a deployable airtight polycarbonate visor and respirator system. <br>\
	This particular unit's rebreathers have been salvaged off; unable to resynthesize any more breathable air for the user."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/head.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	supports_variations_flags = NONE

/obj/item/clothing/suit/space/voskhod
	name = "\proper Voskhod-P depowered combat armor"
	desc = "A hybrid set of space-resistant armor built on a modified mass-produced Nomex-Aerogel flight suit, polyurea coated durathread-lined light plasteel plates hinder mobility as little as possible.\
	These 'paralyzed', marketable variations of the suit come with most of their main features removed: from the infamous wound-tending systems, to the less appreciated death alarms. It's more effective, lightweight plates have been removed with just armor-grade steels and ceramics, slowing the suits down signifigantly."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	supports_variations_flags = NONE //It's already huge enough to look like it can work with digis
	slowdown = 1

/datum/crafting_recipe/voskhod_to_mod
	name = "Depowered Voskhod-To-Refurbished Voskhod MOD Conversion"
	desc = "While this is usually done on a specialised automated workbench, you can tinker with the suit manually for a longer while to achieve the same result."
	result = /obj/effect/spawner/random/voskhod_refit
	reqs = list(
		/obj/item/clothing/suit/space/voskhod = 1,
		/obj/item/clothing/head/helmet/space/voskhod = 1,
		/obj/item/crafting_conversion_kit/voskhod_refit = 1,
		/obj/item/storage/backpack/industrial/cin_surplus = 1,
		/obj/item/mod/core = 1,
		/obj/item/stock_parts/power_store/cell/high = 1,
		/obj/item/stack/sheet/plasteel = 10,
		/obj/item/stack/cable_coil = 15,
		/obj/item/assembly/health = 1,
	)
	tool_behaviors = list(TOOL_WELDER, TOOL_MULTITOOL)
	time = 30 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/obj/effect/spawner/random/voskhod_refit
	name = "converted MODskhod spawner"
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "voskhod-chestplate-sealed"
	spawn_all_loot = TRUE
	spawn_loot_count = 1
	loot = list(/obj/item/mod/control/pre_equipped/voskhod)
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 10, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.95, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.45)

/obj/item/mod/module/auto_doc
	name = "MOD automatic paramedical module"
	desc = "The reverse-engineered and redesigned medical assistance system, previously used by the now decommissioned Voskhod combat armor. \
		The technology it uses is very similar to the one of the N-URSEI suites, yet miniaturised and lacking self-synthesis capabilities. \
		Using a built-in storage of chemical compounds and a miniature chemical mixer, it's capable of injecting its user with a plethora of drugs, \
		assisting them with their restoration. However, this system heavily relies on some rarely combat-available chemical compounds to prepare its injections, \
		mainly cryptobiolin , which appear in the user's bloodstream from time to time, and its trivial damage assessment systems are prone to kicking in only when you're moderately wounded."
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(
		/obj/item/mod/module/adrenaline_boost,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/ash_accretion,
	)
	complexity = 4
	removable = TRUE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// Reagent used as 'fuel'
	var/reagent_required = /datum/reagent/cryptobiolin
	/// How much of a reagent we need to refill a single boost.
	var/reagent_required_amount = 20
	/// Maximum amount of reagents this module can hold.
	var/reagent_max_amount = 120
	/// Flat health threshold above which the module won't heal.
	var/health_threshold = 80
	/// Cooldown betwen each treatment.
	var/general_cooldown = 25 SECONDS

	/// Timer for the healing cooldown.
	COOLDOWN_DECLARE(heal_timer)
	/// Timer for the stamina damage cooldown.
	COOLDOWN_DECLARE(stamina_timer)
	/// Timer for the blood-refilling cooldown.
	COOLDOWN_DECLARE(blood_timer)

/obj/item/mod/module/auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)

/obj/item/mod/module/auto_doc/on_active_process(seconds_per_tick)
	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "not enough chems!")
		deactivate()
		return FALSE

	var/new_oxyloss = mod.wearer.get_oxy_loss()
	var/new_bruteloss = mod.wearer.get_brute_loss()
	var/new_fireloss = mod.wearer.get_fire_loss()
	var/new_toxloss = mod.wearer.get_tox_loss()

	if(mod.wearer.get_blood_volume() < BLOOD_VOLUME_OKAY && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
		if(!COOLDOWN_FINISHED(src, blood_timer))
			return FALSE
		mod.wearer.reagents.add_reagent(/datum/reagent/blood, 25, list("viruses"=null,"blood_DNA"=null,"blood_type"=mod.wearer.dna.blood_type,"resistances"=null,"trace_chem"=null))
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/coagulant, 2.5 * seconds_per_tick)
		mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
		reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
		to_chat(mod.wearer, span_warning("Blood infused."))
		drain_power(use_energy_cost * 10 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS, TIMER_STOPPABLE|TIMER_DELETE_ME)
		COOLDOWN_START(src, blood_timer, general_cooldown)

	if(mod.wearer.health < health_threshold)
		if(!COOLDOWN_FINISHED(src, heal_timer))
			return FALSE
		if(new_oxyloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/internals/internals_on.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Blood oxygen saturated."))
		if(new_bruteloss && reagents.total_volume >= reagent_required_amount * 1 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 1 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Wound treatment administered."))
		if(new_fireloss && reagents.total_volume >= reagent_required_amount * 1 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 1 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Ointment applied."))
		if(new_toxloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Antitoxin administered."))
		drain_power(use_energy_cost * 15 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS)
		COOLDOWN_START(src, heal_timer, general_cooldown)

/obj/item/mod/module/auto_doc/emp_act(severity)
	. = ..()
	on_emp(src, severity, .)

/obj/item/mod/module/auto_doc/proc/on_emp(datum/source, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	heal_aftereffects(mod.wearer, TRUE)

/// Refills the module with needed chemicals, assuming the container isn't closed or the module isn't full.
/obj/item/mod/module/auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(mod.wearer, "already full!")
		return FALSE
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
	balloon_alert(mod.wearer, "charge reloaded!")
	return TRUE

/obj/item/mod/module/auto_doc/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_refill))
	RegisterSignal(mod, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp))

/obj/item/mod/module/auto_doc/on_uninstall(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION)
	UnregisterSignal(mod, COMSIG_ATOM_EMP_ACT)

/obj/item/mod/module/auto_doc/proc/try_refill(source, mob/user, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(charge_boost(attacking_item))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/// With a certain chance, triggers a spontaneous injection of cryptobiolin  into the user's bloodstream; suit design's rather ancient and prone to mishaps.
/obj/item/mod/module/auto_doc/proc/heal_aftereffects(mob/affected_mob, forced)
	if(!affected_mob)
		return
	var/fault_chance = (reagents.maximum_volume/(reagents.total_volume ? reagents.total_volume : 20))*5 // 5% at max cryptobiolin , 20% at low-to-none cryptobiolin
	if(prob(fault_chance) || forced == TRUE)
		reagents.trans_to(affected_mob, min(15,reagents.total_volume))
		balloon_alert(affected_mob, "reagent canister leak!")
		affected_mob.playsound_local(mod, 'sound/effects/spray3.ogg', 25, TRUE)

/obj/item/reagent_containers/cup/glass/waterbottle/large/cryptobiolin
	name = "bottle of 'Medical Reagents'"
	desc = "Nothing screams 'Budget cuts' like a plastic bottle of autodoc refills."
	list_reagents = list(/datum/reagent/cryptobiolin  = 100)
