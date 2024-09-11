/datum/heretic_knowledge/resistance_helmet
	name = "Gold Leather Rim Cap"
	desc = "Allows you to transmute a sheet of leather, a gold ingot, and a chaotic orb into a magical helmet that grants resistances \
	to all armor types except for melee and bullet attacks. This protects every limb."
	gain_text = "When you have more, protect yourself so that you can continue to have more."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/stack/sheet/leather = 1,
		/obj/item/stack/sheet/mineral/gold = 1,
		/obj/item/heretic_currency/chaotic = 1
	)
	result_atoms = list(/obj/item/clothing/head/helmet/heretic_resistance)

	cost = 1
	depth = 3
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "rim"
