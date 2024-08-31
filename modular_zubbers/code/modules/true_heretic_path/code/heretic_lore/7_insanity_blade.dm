/datum/heretic_knowledge/limited_amount/insanity_blade
	name = "Elder's Insanity"
	desc = "Allows you to transform a cold iron blade, a brain, and a sheet of plasma into the Elder's insanity sword, a powerful upgraded ritual knife that causes sanity damage to targets, as well as yourself, on hit. This can be performed only once, so don't lose it."
	gain_text = "Becoming insane by researching Fishing techniques has finally paid off. I think."
	next_knowledge = list(
		/datum/heretic_knowledge/advanced_map_making,
	)
	required_atoms = list(
		/obj/item/melee/sickly_blade/exile = 1,
		/obj/item/organ/internal/brain = 1,
		/obj/item/stack/sheet/mineral/plasma = 1
	)
	result_atoms = list(/obj/item/melee/sickly_blade/exile/upgrade)

	cost = 1
	depth = 9
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "sword"

	limit = 1
