/datum/heretic_knowledge/bag_purchase
	name = "Rucksack of Looting"
	desc = "Allows you to transmute a satchel and a sheet of leather into a rucksack that can carry all your funny heretical orbs."
	gain_text = "When you can't have more, find something that will allow you to have more."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/storage/backpack/satchel = 1,
		/obj/item/stack/sheet/leather = 1
	)

	result_atoms = list(/obj/item/storage/bag/exile)

	cost = 1
	depth = 2

	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_bags.dmi'
	research_tree_icon_state = "rucksack"
