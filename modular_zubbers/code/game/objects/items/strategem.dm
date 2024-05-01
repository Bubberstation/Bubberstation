//Yes, I'm for real

/obj/item/choice_beacon/strategem_utility
	name = "Signal Radio"
	desc = "Requesting Strategem"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")

/obj/item/choice_beacon/strategem_utility/generate_display_names()
	var/static/list/selectable_strategem = list(
		"Heavy Disabler Nest" = /obj/machinery/deployable_turret/disabler,
		"Mecha Support" = /obj/vehicle/sealed/mecha/ripley/paddy/preset,
		"Modsuit" = /obj/item/mod/control/pre_equipped/security
	)

	return selectable_strategem

/obj/item/choice_beacon/strategem_offensive
	name = "Signal Radio"
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


