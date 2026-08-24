
/obj/item/security_voucher
	name = "security voucher"
	desc = "A token to redeem a piece of equipment."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "security_voucher_primary"
	w_class = WEIGHT_CLASS_TINY

/obj/item/security_voucher/examine(mob/user)
	. = ..()

	. += span_notice("You can redeem it at a [EXAMINE_HINT("security equipment vendor")] or [EXAMINE_HINT("any lathe")].")

/obj/item/security_voucher/primary
	name = "security primary voucher"
	icon_state = "security_voucher_primary"

/obj/item/security_voucher/utility
	name = "security utility voucher"
	icon_state = "security_voucher_utility"

#define HOS_PRIMARY_MARKINGS " This one's markings indicate that it was issued to the Head of Security."

/proc/retarget_hos_primary_objectives(obj/item/weapon_path, objective_name)
	for(var/datum/objective/objective as anything in GLOB.objectives)
		if(!istype(objective, /datum/objective/steal))
			continue
		var/datum/objective/steal/steal_objective = objective
		if(!istype(steal_objective.targetinfo, /datum/objective_item/steal/hoslaser))
			continue

		steal_objective.steal_target = weapon_path
		steal_objective.explanation_text = "Steal [objective_name], the head of security's service weapon."

		for(var/datum/mind/owner as anything in steal_objective.get_owners())
			if(!owner.current)
				continue
			to_chat(owner.current, span_notice("Your objective has been updated: [steal_objective.explanation_text]"))
			for(var/datum/antagonist/antag as anything in owner.antag_datums)
				antag.update_static_data(owner.current)

/obj/item/gun/energy/e_gun/hos/hos_primary
	desc = parent_type::desc + HOS_PRIMARY_MARKINGS

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/hos_primary
	desc = parent_type::desc + HOS_PRIMARY_MARKINGS
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/projectile/bullet/security/smart
	name = "smart 9x19mm Murphy bullet"

/obj/projectile/bullet/security/smart/prehit_pierce(atom/target)
	if(isliving(target) && HAS_TRAIT(target, TRAIT_MINDSHIELD))
		return PROJECTILE_PIERCE_PHASE
	return ..()

/obj/item/ammo_casing/security/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from)
	if(istype(fired_from, /obj/item/gun/ballistic/automatic/pistol/sec_glock/smart))
		QDEL_NULL(loaded_projectile)
		loaded_projectile = new /obj/projectile/bullet/security/smart(src)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart
	name = "\improper Smart Pistol"
	desc = parent_type::desc + " This model is a new prototype that uses a compact IFF package to guide rounds past mindshield-implanted targets." + HOS_PRIMARY_MARKINGS
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "firefly"
	base_icon_state = "firefly"
	projectile_damage_multiplier = 0.9
	show_bolt_icon = FALSE
	mag_display = FALSE
	var/firefly_slide_animating = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE)

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/update_overlays()
	. = ..()
	if(magazine && !internal_magazine)
		. += "firefly_mag"
	var/datum/component/seclite_attachable/seclite = GetComponent(/datum/component/seclite_attachable)
	if(seclite?.light)
		var/light_state = seclite.light.light_on ? "on" : "off"
		. += "firefly-light_[light_state]"
	if(!firefly_slide_animating)
		. += bolt_locked ? "firefly_bolt_locked" : "firefly_bolt"

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/pbtarget = null, message = TRUE)
	. = ..()
	recoil_firefly_slide()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/proc/recoil_firefly_slide()
	firefly_slide_animating = TRUE
	update_appearance(UPDATE_OVERLAYS)
	var/atom/movable/flick_visual/slide = flick_overlay_view(mutable_appearance(icon, "firefly_bolt", layer + 0.1), 0.75)
	if(slide)
		animate(slide, pixel_w = -3, time = 0.375)
		animate(pixel_w = 0, time = 0.375)
	addtimer(CALLBACK(src, PROC_REF(reset_firefly_slide_recoil)), 0.75)

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/proc/reset_firefly_slide_recoil()
	firefly_slide_animating = FALSE
	update_appearance(UPDATE_OVERLAYS)

/obj/item/gun/ballistic/revolver/c38/the_law
	name = "\improper The Law"
	desc = "A custom modified .38 Special revolver, it seems far heavier than standard models." + HOS_PRIMARY_MARKINGS
	icon = 'modular_zubbers/icons/obj/weapons/hos_revolver.dmi'
	icon_state = "the_law"
	base_icon_state = "the_law"
	projectile_damage_multiplier = 1.1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/storage/belt/holster/detective/full/ert/the_law
	desc = parent_type::desc + HOS_PRIMARY_MARKINGS

/obj/item/storage/belt/holster/detective/full/ert/the_law/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c38 = 3,
		/obj/item/gun/ballistic/revolver/c38/the_law = 1,
	), src)

/obj/item/hos_primary_case
	name = "head of security's service weapon case"
	desc = "A secure gun case containing one of the Head of Security's service weapons."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "guncase"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/worn/cases.dmi'
	worn_icon_state = "darkcase"
	material_flags = NONE
	w_class = WEIGHT_CLASS_NORMAL
	/// Prevents double redemption if two interactions race each other.
	var/redeemed = FALSE

/obj/item/hos_primary_case/click_alt(mob/user)
	try_redeem(user)
	return CLICK_ACTION_SUCCESS

/obj/item/hos_primary_case/attack_self(mob/user)
	try_redeem(user)

/obj/item/hos_primary_case/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/energy/e_gun/hos)

/obj/item/hos_primary_case/proc/try_redeem(mob/user)
	if(redeemed || QDELETED(src))
		return
	if(!isliving(user))
		return
	var/mob/living/redeemer = user
	if(redeemer.incapacitated)
		return

	var/static/list/primary_options
	if(!primary_options)
		var/datum/radial_menu_choice/x01_option = new
		x01_option.image = image(icon = 'icons/obj/weapons/guns/energy.dmi', icon_state = "hoslaser")
		x01_option.info = span_boldnotice("The Head of Security's unique three-mode energy gun.")

		var/datum/radial_menu_choice/shotgun_option = new
		shotgun_option.image = image(icon = 'icons/obj/weapons/guns/ballistic.dmi', icon_state = "cshotgunc")
		shotgun_option.info = span_boldnotice("A miniaturized combat shotgun.")

		var/datum/radial_menu_choice/smart_pistol_option = new
		smart_pistol_option.image = image(icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi', icon_state = "firefly")
		smart_pistol_option.info = span_boldnotice("A Murphy-pattern pistol that fires past mindshield-implanted targets.")

		var/datum/radial_menu_choice/the_law_option = new
		the_law_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/hos_revolver.dmi', icon_state = "the_law")
		the_law_option.info = span_boldnotice("The Law, an modified Detective Special that hits harder than standard models.")

		primary_options = list(
			"X-01 MultiPhase Energy Gun" = x01_option,
			"Compact Shotgun" = shotgun_option,
			"Smart Pistol" = smart_pistol_option,
			"The Law" = the_law_option,
		)

	var/selection = show_radial_menu(redeemer, src, primary_options, custom_check = CALLBACK(src, PROC_REF(check_redeem_menu), redeemer), radius = 38, require_near = TRUE, tooltips = TRUE)
	if(!selection || redeemed || QDELETED(src))
		return

	var/spawn_path
	var/objective_path
	var/objective_name
	switch(selection)
		if("X-01 MultiPhase Energy Gun")
			spawn_path = /obj/item/gun/energy/e_gun/hos/hos_primary
			objective_name = "the X-01 MultiPhase Energy Gun"
		if("Compact Shotgun")
			spawn_path = /obj/item/gun/ballistic/shotgun/automatic/combat/compact/hos_primary
			objective_name = "the compact shotgun"
		if("Smart Pistol")
			spawn_path = /obj/item/gun/ballistic/automatic/pistol/sec_glock/smart
			objective_name = "the Smart Pistol"
		if("The Law")
			spawn_path = /obj/item/storage/belt/holster/detective/full/ert/the_law
			objective_path = /obj/item/gun/ballistic/revolver/c38/the_law
			objective_name = "\"The Law\""
		else
			return

	objective_path ||= spawn_path
	redeemed = TRUE
	var/obj/item/chosen_item = new spawn_path(drop_location())
	redeemer.put_in_hands(chosen_item)
	retarget_hos_primary_objectives(objective_path, objective_name)
	balloon_alert(redeemer, "selected [LOWER_TEXT(selection)]")
	qdel(src)

/obj/item/hos_primary_case/proc/check_redeem_menu(mob/living/redeemer)
	if(!istype(redeemer))
		return FALSE
	if(redeemer.incapacitated)
		return FALSE
	if(QDELETED(src) || redeemed)
		return FALSE
	if(!redeemer.Adjacent(src))
		return FALSE
	return TRUE

#undef HOS_PRIMARY_MARKINGS

/obj/machinery/vending/security/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/obj/machinery/rnd/production/techfab/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/obj/machinery/rnd/production/protolathe/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/datum/voucher_set/security
	blackbox_key = "security_voucher_redeemed"

/datum/voucher_set/security/primary

/datum/voucher_set/security/utility

/datum/voucher_set/security/primary/disabler
	name = "Disabler"
	description = "The standard issue energy gun of Nanotrasen security forces. Comes with it's own holster."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "disabler"
	set_items = list(
		/obj/item/storage/belt/holster/energy/disabler,
		)

/datum/voucher_set/security/primary/advanced_taser
	name = "Hybrid Taser"
	description = "A dual-mode taser designed to fire both short-range high-power electrodes and long-range disabler beams."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "advtaser"
	set_items = list(
		/obj/item/gun/energy/e_gun/advtaser,
		)

/datum/voucher_set/security/primary/disabler_smg
	name = "Pepperball AGH"
	description = "A slower firing handgun that fires 'pepperballs', which easily drop targets to the floor."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "peppergun"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/pepperball,
		/obj/item/ammo_box/magazine/pepperball
		)

/datum/voucher_set/security/primary/strobe_shield
	name = "Strobe Shield"
	description = "A shield with a built in, high intensity light capable of blinding and disorienting suspects. Takes regular handheld flashes as bulbs."
	icon = 'icons/obj/weapons/shields.dmi'
	icon_state = "flashshield"
	set_items = list(
		/obj/item/shield/riot/flash,
		)

/datum/voucher_set/security/primary/archery
	name = "Archery Kit"
	description = "A powerful bow, a training manual, and a quiver with non/less-than-lethal arrows. You will still need to order the fletching book from cargo if you want to make lethal arrows."
	icon = 'icons/obj/weapons/bows/bows.dmi'
	icon_state = "hardlightbow"
	set_items = list(
		/obj/item/gun/ballistic/bow/security,
		/obj/item/storage/bag/quiver/lesser/security,
		/obj/item/book/granter/crafting_recipe/fletching/nonlethal,
		/obj/item/hatchet,
	)

/obj/item/storage/bag/quiver/lesser/security
	name = "security quiver"
	desc = "A lightweight, low-capacity quiver capable of being folded into pockets, but nothing else."
	slot_flags = ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET|ITEM_SLOT_BELT

/obj/item/storage/bag/quiver/lesser/security/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_casing/arrow/blunt = 7,
		/obj/item/ammo_casing/arrow/taser = 3
	)

	generate_items_inside(items_inside, src)

/obj/item/book/granter/crafting_recipe/fletching/nonlethal
	name = "Aim for the knees, not the eyes!"
	desc = "A manual on how to construct sub-lethal bows & arrows, how best to use them... and how to construct violins?"
	crafting_recipe_types = list(
		/datum/crafting_recipe/shortbow,
		/datum/crafting_recipe/blunted_arrow,
		/datum/crafting_recipe/taser_arrow,
		/datum/crafting_recipe/violin,
	)
	uses = 1

/datum/voucher_set/security/primary/nt_usp
	name = "NT22-HCS 'Enforcer' Pistol"
	description = "A small pistol that uses hardlight technology to synthesize bullets. Due to its low power, it doesn't have much use besides tiring out criminals."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp_full"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/ntusp,
		/obj/item/ammo_box/magazine/recharge/ntusp,
		)

/datum/voucher_set/security/utility/sec_projector
	name = "Security Holobarrier Projector"
	description = "A holographic projector that creates holographic security barriers along with holographic handcuffs."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker_sec"
	set_items = list(
		/obj/item/holosign_creator/security,
		)

/datum/voucher_set/security/utility/lawbook
	name = "Weighted Space Law Book"
	description = "A special edition release of Nanotrasen Space Law. The decorative metal cover adds quite the amount of bulk... Be careful swinging it."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	set_items = list(
		/obj/item/book/manual/wiki/security_space_law/weighted,
		)

/datum/voucher_set/security/utility/donut_box
	name = "Box of Donuts"
	description = "Tantalizing..."
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox"
	set_items = list(
		/obj/item/storage/fancy/donut_box,
		/obj/item/reagent_containers/cup/glass/coffee,
		)

/datum/voucher_set/security/utility/barrier
	name = "Barrier Grenades"
	description = "Two barrier grenades."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "wallbang"
	set_items = list(
		/obj/item/grenade/barrier,
		/obj/item/grenade/barrier,
		)

/datum/voucher_set/security/utility/stingbang
	name = "Stingbang Grenades"
	description = "Two stingbang grenades."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "timeg_locked"
	set_items = list(
		/obj/item/grenade/stingbang,
		/obj/item/grenade/stingbang,
		)

/datum/voucher_set/security/utility/justice_helmet
	name = "Helmet of Justice"
	description = "Crime fears the helmet of justice."
	icon = 'icons/obj/clothing/head/helmet.dmi'
	icon_state = "justice"
	set_items = list(
		/obj/item/clothing/mask/gas/sechailer/swat,
		/obj/item/clothing/head/helmet/toggleable/justice,
		)

/datum/voucher_set/security/utility/pinpointer_pairs
	name = "Pinpointer Pair"
	description = "A pair of handheld tracking devices that lock onto the other half of the matching pair."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "pinpointer"
	set_items = list(
		/obj/item/storage/box/pinpointer_pairs,
		)

/datum/voucher_set/security/utility/laptop
	name = "Security Laptop"
	description = "A laptop pre-loaded with security software."
	icon = 'icons/obj/devices/modular_laptop.dmi'
	icon_state = "laptop-closed"
	set_items = list(
		/obj/item/modular_computer/laptop/preset/security,
	)

/obj/item/modular_computer/laptop/preset/security
	starting_programs = list(
		/datum/computer_file/program/chatclient,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/secureye,
	)
