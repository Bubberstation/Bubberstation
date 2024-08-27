/datum/heretic_knowledge/limited_amount/insanity_blade
	name = "Elder's Insanity"
	desc = "Opens up the Path of Exile to you. \
		Allows you to transmute a knife and a sheet of iron into an Cold Iron Dagger, \
		which is less obvious than most heretic blades. \
		You can only create one elder insanity. Don't lose it... or do lose it."
	gain_text = "The City Guard know their watch. If you ask them at night, they may tell you about the ashy lantern."
	next_knowledge = list(/datum/heretic_knowledge/loot_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/iron = 1
	)
	result_atoms = list(/obj/item/melee/sickly_blade/exile)
	route = PATH_EXILE
	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "dagger"
	limit = 1