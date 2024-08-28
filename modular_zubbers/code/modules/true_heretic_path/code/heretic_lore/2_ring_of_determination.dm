/datum/heretic_knowledge/determination
	name = "Ring of Determination"
	desc = "Allows you to transmute a piece of body armor and a helmet into a powerful ring that passively gives the armor protection from melee and bullet based attacks."
	gain_text = "When you have more, protect yourself so that others cannot have more."
	next_knowledge = list(
		/datum/heretic_knowledge/wand_purchase,
		/datum/heretic_knowledge/blade_upgrade/exile,
	)
	required_atoms = list(
		/obj/item/clothing/suit/armor = 1,
		/obj/item/clothing/head/helmet = 1
	)
	result_atoms = list(/obj/item/clothing/gloves/ring/determination)

	cost = 1
	depth = 3
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "determination"
