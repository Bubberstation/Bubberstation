/datum/heretic_knowledge/access_belt
	name = "Skullhunter"

	desc = "Allows you to transmute a silver ID card, a storage belt, and 5 divination orbs into the legendary belt Skullhunter. \
	Skullhunter is a special belt that steals one random access from a dead being's id card that you hit with your heretical blade and applies it to your worn id. \
	Only one data of access can be stolen per ID per belt."

	gain_text = "The desired object of every exile; a belt that fits."

	next_knowledge = list(

	)

	required_atoms = list(
		/obj/item/storage/belt = 1,
		/obj/item/heretic_currency/divination = 5,
		/obj/item/card/id/advanced/silver = 1
	)

	result_atoms = list(/obj/item/storage/belt/skullhunter)

	cost = 1
	depth = 4
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "skullhunter"
