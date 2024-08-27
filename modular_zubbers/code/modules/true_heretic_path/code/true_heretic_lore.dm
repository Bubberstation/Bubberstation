/datum/heretic_knowledge/limited_amount/starting/base_void
	name = "Glimmer of Winter"
	desc = "Opens up the Path of Exile to you. \
		Allows you to transmute a knife in sub-zero temperatures into a Void Blade. \
		You can only create five at a time."
	gain_text = "I feel a shimmer in the air, the air around me gets colder. \
		I start to realize the emptiness of existence. Something's watching me."
	next_knowledge = list(/datum/heretic_knowledge/void_grasp)
	required_atoms = list(/obj/item/knife = 1)
	result_atoms = list(/obj/item/melee/sickly_blade/void)
	route = PATH_EXILE
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "void_blade"