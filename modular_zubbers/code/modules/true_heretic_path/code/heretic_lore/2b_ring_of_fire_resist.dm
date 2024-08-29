/datum/heretic_knowledge/fire_resist_ring
	name = "Gold Ring of Fire Resistance"
	desc = "Allows you to transmute a fire suit and a sheet of gold into a ring of fire resistance, which as the name implies, gives singificant fire resistance (but not immunity!) when worn. This protects every limb."
	gain_text = "When you have more, protect yourself so that others cannot have more."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/clothing/suit/utility/fire = 1,
		/obj/item/stack/sheet/mineral/gold = 1
	)
	result_atoms = list(/obj/item/clothing/gloves/ring/fire_resistance)

	cost = 1
	depth = 3
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "fire_resist"
