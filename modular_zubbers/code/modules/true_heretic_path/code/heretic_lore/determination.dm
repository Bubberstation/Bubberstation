/datum/heretic_knowledge/determination
	name = "Ring of Determination"
	desc = "Allows you to transmute a piece of body armor and a helmet into a powerful ring that passively gives the armor protection from melee attacks and bullet projectiles."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/clothing/suit/armor = 1,
		/obj/item/clothing/head/helmet = 1
	)
	result_atoms = list(/obj/item/clothing/gloves/ring/determination)
	cost = 1
	route = PATH_ASH
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8