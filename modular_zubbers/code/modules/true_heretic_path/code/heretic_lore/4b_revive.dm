/datum/heretic_knowledge/limited_amount/exile_revival

	name = "Washed Up Shores"
	desc = "Allows you to sacrifice a single heretical blade to instantly heal yourself of all damage and ailments. This ritual can be invoked only once!"
	gain_text = "A second chance at life."

	required_atoms = list(
		/obj/item/melee/sickly_blade = 1
	)

	result_atoms = list(
		/obj/item/knife = 1 //We need a result here so the limit feature actually works.
	)

	cost = 1
	depth = 5
	route = PATH_SIDE

	research_tree_icon_path = 'icons/obj/fluff/beach.dmi'
	research_tree_icon_state = "palm1b"

	limit = 1

/datum/heretic_knowledge/limited_amount/exile_revival/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	user.revive(
		HEAL_ALL,
		excess_healing = 100
	)