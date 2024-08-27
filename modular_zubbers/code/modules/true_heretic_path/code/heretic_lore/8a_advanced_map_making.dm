/datum/heretic_knowledge/advanced_map_making
	name = "Advanced Map Making"
	desc = "Allows you to transmute a map and a bluespace crystal into a blank map. Using the map in a location will save that location to the map, without the need of performing a ritual in that area."
	gain_text = "The manipulation of maps is a vital step in following the Path of Exile."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/heretic_map = 1
	)
	result_atoms = list(/obj/item/heretic_map)

	cost = 1
	depth = 10
	route = PATH_ASH

	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"

