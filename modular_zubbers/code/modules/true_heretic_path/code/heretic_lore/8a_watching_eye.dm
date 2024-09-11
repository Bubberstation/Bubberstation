/datum/heretic_knowledge/watching_eye
	name = "Watching Eye"

	desc = "Allows you to transmute a pair of eyes, a uranium sheet, and a divination orb into a watching eye; \
	a special jewel that deals toxin damage over time to non-heretics around it, as long as it is placed on a tile. \
	Use in hand to activate it. Picking it up deactivates it."

	gain_text = "After being in exile, you learn that you still must be watchful of others; even if you are alone."

	next_knowledge = list(

	)

	required_atoms = list(
		/obj/item/organ/internal/eyes = 1,
		/obj/item/stack/sheet/mineral/uranium = 1,
		/obj/item/heretic_currency/divination = 1
	)

	result_atoms = list(/obj/item/watching_eye)

	cost = 1
	depth = 9
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_misc.dmi'
	research_tree_icon_state = "watching_eye_open"
