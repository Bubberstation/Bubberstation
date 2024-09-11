/datum/heretic_knowledge/limited_amount/insanity_blade
	name = "Elder's Insanity"
	desc = "Allows you to transform a cold iron blade, a small fish, and a sheet of plasma into the Elder's insanity sword; a powerful upgraded ritual knife that \
	deals more damage and causes sanity damage to targets, as well as yourself, on hit. \
	The blade also has a 25% chance to block attacks, but is much bulkier and cannot fit in bags. \
	Interesting enough, negative modifier values on the item are treated as positive modifier values. \
	This ritual can be performed only once, so don't lose it."
	gain_text = "Insanity is a man's best friend when they're alone."
	next_knowledge = list(
		/datum/heretic_knowledge/advanced_map_making,
		/datum/heretic_knowledge/watching_eye,
	)
	required_atoms = list(
		/obj/item/melee/sickly_blade/exile = 1,
		/obj/item/fish = 1,
		/obj/item/stack/sheet/mineral/plasma = 1
	)
	result_atoms = list(/obj/item/melee/sickly_blade/exile/upgrade)

	cost = 1
	depth = 9
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "sword"

	limit = 1
