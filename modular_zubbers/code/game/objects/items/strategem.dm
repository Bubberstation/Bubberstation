//Yes, I'm for real

/obj/item/choice_beacon/strategem_utility
	name = "Signal Radio (Support)"
	desc = "Requesting Strategem"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")

/obj/item/choice_beacon/strategem_utility/generate_display_names()
	var/static/list/selectable_strategem = list(
		"Heavy Disabler Nest" = /obj/machinery/deployable_turret/disabler,
		"Orbital Paddy Drop" = /obj/vehicle/sealed/mecha/ripley/paddy/preset,
		"Modsuit" = /obj/item/mod/control/pre_equipped/security
	)

	return selectable_strategem

/obj/item/choice_beacon/strategem_offensive
	name = "Signal Radio(Offensive)"
	desc = "Requesting Strategem"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, Eagle-13 on the way")

/obj/item/choice_beacon/strategem_offensive/generate_display_names()
	var/static/list/selectable_strategem = list(
		"500 Kilogram Stinbang Strike" = /obj/machinery/deployable_turret/disabler,
		"Orbital Lube Bombardment" = /obj/vehicle/sealed/mecha/ripley/paddy/preset,
		"Homing Creampie Strike" = /obj/item/mod/control/pre_equipped/security
	)

	return selectable_strategem

// Stuff Here

/obj/machinery/deployable_turret/disabler
	name = "Disabler Machinegun"
	projectile_type = /obj/projectile/beam/disabler/weak
	anchored = TRUE
	number_of_shots = 3
	cooldown_duration = 1 SECONDS
	spawned_on_undeploy = /obj/item/deployable_turret_folded/disabler
	can_be_undeployed = TRUE
	max_integrity = 450

/obj/item/deployable_turret_folded/disabler
	name = "folded disabler machine gun"
	desc = "A folded and unloaded heavy machine gun, ready to be deployed and used."
	icon = 'icons/obj/weapons/turrets.dmi'
	icon_state = "folded_hmg"
	inhand_icon_state = "folded_hmg"
	max_integrity = 450
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/deployable_turret_folded/disabler/Initialize(mapload)
	AddComponent(/datum/component/deployable, 5 SECONDS, /obj/machinery/deployable_turret/disabler)
