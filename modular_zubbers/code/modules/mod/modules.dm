/obj/item/mod/module/mind_swap
	name = "MOD Neural Transference module"
	desc = "Swaps the MOD wearer's and Assistant AI's neural pathways."
	removable = FALSE
	required_slots = list(ITEM_SLOT_FEET, ITEM_SLOT_GLOVES, ITEM_SLOT_OCLOTHING, ITEM_SLOT_HEAD)
	module_type = MODULE_ACTIVE
	//Who's in control of the wearer's body
	var/ai_control = FALSE
	//Ckey of the original AI
	var/ai_key
	//Ckey of the original wearer
	var/wearer_key
	cooldown_time = 30 SECONDS

/obj/item/mod/module/mind_swap/on_select()
	if(!mod.ai_assistant)
		balloon_alert(mod.wearer, "no AI present")
		return
	if(isnull(mod.wearer.client))
		balloon_alert(mod.ai_assistant, "host is unresponsive")
		return
	if(isnull(mod.ai_assistant.client))
		balloon_alert(mod.wearer, UNLINT("AI is unresponsive"))
		return
	return ..()

/obj/item/mod/module/mind_swap/on_activation()
	swap_minds()

/obj/item/mod/module/mind_swap/on_deactivation(display_message, deleting)
	swap_minds()

/obj/item/mod/module/mind_swap/on_part_activation()
	ai_key = mod.ai_assistant?.key
	wearer_key = mod.wearer.key
	ai_control = FALSE

/obj/item/mod/module/mind_swap/on_part_deactivation(deleting = FALSE)
	if(wearer_key != mod.wearer.key)
		swap_minds()

/obj/item/mod/module/mind_swap/proc/swap_minds()
	if(!mod.ai_assistant)
		mod.wearer.ghostize(FALSE)
		mod.ai_assistant.key = ai_key
		return
	mod.wearer.ghostize(FALSE)
	mod.ai_assistant.ghostize(FALSE)
	if(ai_control)
		mod.wearer.key = wearer_key
		mod.ai_assistant.key = ai_key
	else
		mod.wearer.key = ai_key
		mod.ai_assistant.key = wearer_key
	ai_control = !ai_control

/obj/item/mod/module/sec_auto_doc
	name = "MOD automatic paramedical module"
	desc = "A reverse-engineered medical assistance system prototype undergoing field testing. Using a built-in storage of chemical compounds and a miniature chemical mixer, it injects the wearer with emergency medication when they are hurt."
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(
		/obj/item/mod/module/adrenaline_boost,
		/obj/item/mod/module/sec_auto_doc,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/drill,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/constructor,
		/obj/item/mod/module/injector,
		/obj/item/mod/module/organizer,
		/obj/item/mod/module/thread_ripper,
		/obj/item/mod/module/surgical_processor,
		/obj/item/mod/module/ash_accretion,
	)
	complexity = 4
	removable = FALSE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// Reagent used as refill fuel.
	var/reagent_required = /datum/reagent/medicine/omnizine/protozine
	/// How much reagent a refill transfers, and the base cost of most treatments.
	var/reagent_required_amount = 20
	/// Maximum internal reagent storage.
	var/reagent_max_amount = 120
	/// Flat health threshold above which the module will not perform general healing.
	var/health_threshold = 65
	/// Cooldown between treatments.
	var/general_cooldown = 120 SECONDS
	COOLDOWN_DECLARE(heal_timer)
	COOLDOWN_DECLARE(blood_timer)

/obj/item/mod/module/sec_auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)
	reagents.add_reagent(reagent_required, reagent_max_amount)

/obj/item/mod/module/sec_auto_doc/on_active_process(seconds_per_tick)
	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "not enough chems!")
		deactivate()
		return FALSE

	var/oxyloss = mod.wearer.get_oxy_loss()
	var/bruteloss = mod.wearer.get_brute_loss()
	var/fireloss = mod.wearer.get_fire_loss()

	if(mod.wearer.get_blood_volume() < BLOOD_VOLUME_OKAY && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
		if(!COOLDOWN_FINISHED(src, blood_timer))
			return FALSE
		var/list/blood_data
		var/mob/living/carbon/human/human_wearer = mod.wearer
		if(istype(human_wearer))
			blood_data = list("viruses" = null, "blood_DNA" = null, "blood_type" = human_wearer.dna.blood_type, "resistances" = null, "trace_chem" = null)
		mod.wearer.reagents.add_reagent(/datum/reagent/blood, 25, blood_data)
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
		if(oxyloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/internals/internals_on.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Blood oxygen saturated."))
		if(bruteloss && reagents.total_volume >= reagent_required_amount * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Wound treatment administered."))
		if(fireloss && reagents.total_volume >= reagent_required_amount * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Ointment applied."))
		drain_power(use_energy_cost * 15 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS, TIMER_STOPPABLE|TIMER_DELETE_ME)
		COOLDOWN_START(src, heal_timer, general_cooldown)

/obj/item/mod/module/sec_auto_doc/emp_act(severity)
	. = ..()
	on_emp(src, severity, .)

/obj/item/mod/module/sec_auto_doc/proc/on_emp(datum/source, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	heal_aftereffects(mod.wearer, TRUE)

/obj/item/mod/module/sec_auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(user, "already full!")
		return FALSE
	if(!attacking_item.reagents?.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
	balloon_alert(user, "charge reloaded!")
	return TRUE

/obj/item/mod/module/sec_auto_doc/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_refill))
	RegisterSignal(mod, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp))

/obj/item/mod/module/sec_auto_doc/on_uninstall(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_EMP_ACT))

/obj/item/mod/module/sec_auto_doc/proc/try_refill(source, mob/user, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(charge_boost(attacking_item, user))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/obj/item/mod/module/sec_auto_doc/proc/heal_aftereffects(mob/affected_mob, forced = FALSE)
	if(!affected_mob)
		return
	var/fault_chance = (reagents.maximum_volume / (reagents.total_volume ? reagents.total_volume : 20)) * 5
	if(prob(fault_chance) || forced)
		reagents.trans_to(affected_mob, min(15, reagents.total_volume))
		balloon_alert(affected_mob, "protozine leak!")
		affected_mob.playsound_local(mod, 'sound/effects/spray3.ogg', 25, TRUE)
