//Yes, I'm for real

/obj/item/choice_beacon/strategem_utility
	name = "Signal Radio"
	desc = "Requesting Strategem"
	company_source = "NanoTrasen War Department"
	company_message = span_bold("Copy that, pod calibrated and launching!")

/obj/item/choice_beacon/strategem_utility/generate_display_names()
	var/static/list/selectable_strategem = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		"Energy Carbine" = /obj/item/gun/energy/e_gun/stun/blueshield,
		".585 SMG" = /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo //This can obviously be replaced out with any gun of your choice for future coder
	)

	return selectable_strategem



