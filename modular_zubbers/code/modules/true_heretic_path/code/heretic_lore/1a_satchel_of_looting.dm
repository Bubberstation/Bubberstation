/datum/heretic_knowledge/bag_purchase
	name = "Satchel of Looting"
	desc = "Allows you to transmute an igniter, a wooden log, and a sheet of plasma into a low-charge wand that shoots lesser fireballs."
	gain_text = "When you can never have more, find something that will allow you to have more."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/storage/backpack = 1,
		/obj/item/stack/ore/bluespace_crystal = 1
	)
	result_atoms = list(/obj/item/storage/backpack/satchel/leather/exile)
	cost = 1
	depth = 2
	route = PATH_EXILE
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"





