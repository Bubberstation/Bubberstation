/datum/heretic_knowledge/advanced_map_making
	name = "Map Making"
	desc = "Allows you to transmute a metamaterial beaker and a heart into a magical flask that refills with with one of the selected reagents: \
	Godblood, Stimulants, Saturn-X, Blastoff, or Determination."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/sheet/cardboard = 1,
		/obj/item/paper = 1,
		/obj/item/pen = 1,
	)
	result_atoms = list(/obj/item/heretic_map)
	cost = 1
	route = PATH_ASH
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8
