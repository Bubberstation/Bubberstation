/datum/heretic_knowledge/flask_purchase
	name = "Auto-Alchemical Creation"
	desc = "Allows you to transmute a metamaterial beaker and a heart into a magical flask that refills with with one of the selected reagents: \
	Godblood, Stimulants, Saturn-X, Blastoff, or Determination."
	gain_text = "If you cannot have more, find a way to make more for less."
	next_knowledge = list(
		/datum/heretic_knowledge/belt_purchase,
		/datum/heretic_knowledge/boots_purchase,
		/datum/heretic_knowledge/fisher,
	)
	required_atoms = list(
		/obj/item/reagent_containers/cup/beaker/meta = 1,
		/obj/item/organ/internal/heart = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/endless_flask)

	cost = 1
	depth = 6
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "flask"


/datum/heretic_knowledge/flask_purchase/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/item_to_create = pick(subtypesof(/obj/item/reagent_containers/cup/endless_flask))
	item_to_create = new item_to_create(loc)
	ADD_TRAIT(item_to_create, TRAIT_CONTRABAND, INNATE_TRAIT)
	return TRUE
