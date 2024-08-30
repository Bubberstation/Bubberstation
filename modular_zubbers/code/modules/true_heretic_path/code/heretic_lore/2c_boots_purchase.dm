/datum/heretic_knowledge/boots_purchase
	name = "Boots of Speed"
	desc = "Allows you to transmute a pair of workboots, a green crayon and a sheet of paper into Boots of Speed. The boots do go fast."
	gain_text = "The paper wings makes it go faster."
	next_knowledge = list(

	)

	required_atoms = list(
		/obj/item/clothing/shoes/workboots = 1,
		/obj/item/toy/crayon/green = 1,
		/obj/item/paper = 1,
	)

	result_atoms = list(/obj/item/clothing/shoes/workboots/speed)

	cost = 1
	depth = 3
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "boots_of_speed"






