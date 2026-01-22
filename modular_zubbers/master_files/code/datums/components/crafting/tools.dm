/datum/crafting_recipe/jaws_of_recovery
	name = "Jaws of Recovery"
	desc = "A surprisingly successfull attempt at replicating the genuine NT Jaws of Recovery™ - While you'd think you couldn't make anything but a crude copy, somehow attaching a handheld radio to the internal mechanism of the jaws boosts their performance."
	time = 10 SECONDS
	tool_behaviors = list(TOOL_WRENCH)
	result = /obj/item/crowbar/power/paramedic
	reqs = list(
		/obj/item/crowbar/power = 1,
		/obj/item/bonesetter = 1,
		/obj/item/stack/sticky_tape/surgical = 2,
		/obj/item/radio = 1,
	)
	category = CAT_TOOLS

/datum/crafting_recipe/jaws_of_recovery/New()
	..()
	blacklist |= typesof(/obj/item/radio/headset)
	blacklist |= typesof(/obj/item/radio/intercom)
