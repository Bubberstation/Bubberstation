/datum/heretic_knowledge/limited_amount/insanity_blade
	name = "Elder's Insanity"
	desc = "Opens up the Path of Exile to you. \
		Allows you to transmute a cold iron blade and a brain into The Elder's Insanity Sword, \
		which functions as a much more lethal ritual blade, at the cost of your sanity. \
		You can only create one elder insanity. Don't lose it... or do lose it."
	gain_text = "Still sane, Exile?"
	next_knowledge = list(/datum/heretic_knowledge/loot_grasp)
	required_atoms = list(
		/obj/item/melee/sickly_blade/exile = 1,
		/obj/item/organ/internal/brain = 1,
		/obj/item/stack/sheet/mineral/plasma = 1
	)
	result_atoms = list(/obj/item/melee/sickly_blade/exile/upgrade)
	route = PATH_EXILE
	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "dagger"
	limit = 1