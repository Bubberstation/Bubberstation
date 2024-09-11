/datum/heretic_knowledge/fire_resist_ring
	name = "Gold Ring of Fire Resistance"
	desc = "Allows you to transmute a fire suit and a chaotic orb into a ring of fire resistance, \
	which as the name implies, gives significant fire resistance (but not immunity!) when worn. \
	This ring protects every limb."
	gain_text = "Only you can prevent eldritch fires."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/clothing/suit/utility/fire = 1,
		/obj/item/heretic_currency/chaotic = 1
	)
	result_atoms = list(/obj/item/clothing/gloves/ring/fire_resistance)

	cost = 1
	depth = 3
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "fire_resist"
