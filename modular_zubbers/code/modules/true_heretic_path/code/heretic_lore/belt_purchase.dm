/datum/heretic_knowledge/belt_purchase
	name = "Wizardblood"
	desc = "Allows you to transmute an igniter, a wooden log, and a sheet of plasma into a low-charge wand that shoots lesser fireballs."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/storage/belt = 1,
		/obj/machinery/iv_drip = 1
	)
	result_atoms = list(/obj/item/storage/belt/wizardblood)
	cost = 1
	route = PATH_EXILE
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8