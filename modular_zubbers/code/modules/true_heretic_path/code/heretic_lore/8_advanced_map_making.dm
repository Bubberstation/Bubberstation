/datum/heretic_knowledge/advanced_map_making
	name = "Advanced Map Making"
	desc = "Allows you to transmute a map and a bluespace crystal into a blank map. Using the map in a location will instantly save that location to the map, without the need of performing a ritual in that area."
	gain_text = "The manipulation of maps is a vital step in following the Path of Exile."
	next_knowledge = list(
		/datum/heretic_knowledge/exile_sight,
		/datum/heretic_knowledge/ultimate/exile_final,
		/datum/heretic_knowledge/spell/apetra_vulnera
	)
	required_atoms = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/heretic_map = 1
	)
	result_atoms = list(/obj/item/heretic_map)

	cost = 2
	depth = 10
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_maps.dmi'
	research_tree_icon_state = "map"

