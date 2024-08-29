/datum/heretic_knowledge/limited_amount/exile_revival

	name = "Washed Up Shores"
	desc = "Allows you to sacrifice a single heretical blade to instantly heal yourself of all damage and ailments. One use only."
	gain_text = "A second chance at life."

	required_atoms = list(
		/obj/item/melee/sickly_blade = 1
	)

	cost = 1
	depth = 5
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "revival"

	limit = 1

/datum/heretic_knowledge/limited_amount/exile_revival/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	user.revive(
		HEAL_ALL,
		excess_healing = 100
	)