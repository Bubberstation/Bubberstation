/datum/heretic_knowledge/access_belt
	name = "Skullhunter"

	desc = "Allows you to transmute 5 heads, a silver ID card, and any belt containing storage into a Skullhunter, \
	a special belt that steals the id access of dead beings you attack with your heretical blade and applies it to your worn id."

	gain_text = "The desired object of every exile; a belt that fits."

	next_knowledge = list(
		/datum/heretic_knowledge/limited_amount/skullhunter_trading
	)

	required_atoms = list(
		/obj/item/storage/belt = 1,
		/obj/item/bodypart/head = 5,
		/obj/item/card/id/advanced/silver = 1,
	)

	result_atoms = list(/obj/item/storage/belt/skullhunter)

	cost = 3
	depth = 4
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "skullhunter"
