/datum/heretic_knowledge/flask_purchase
	name = "Auto-Alchemical Creation"
	desc = "Allows you to transmute a large beaker, a stomach, and a diamond into a magical flask \
	that refills with with one of the selected reagents: \
	Vitrium Froth, Saturn-X, Blastoff, or Determination."
	gain_text = "Creating more from nothing is every Exile's dream."
	next_knowledge = list(
		/datum/heretic_knowledge/belt_purchase,
		/datum/heretic_knowledge/fisher,
		/datum/heretic_knowledge/chaotic_flask_purchase,
	)
	required_atoms = list(
		/obj/item/reagent_containers/cup/beaker/large = 1,
		/obj/item/organ/internal/stomach = 1,
		/obj/item/stack/sheet/mineral/diamond = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/endless_flask)

	cost = 1
	depth = 6
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "flask"


/datum/heretic_knowledge/flask_purchase/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/item_to_create
	if(locate(/obj/item/food/burger) in loc)
		item_to_create = /obj/item/reagent_containers/cup/endless_flask/burger
	else
		item_to_create = pick(/obj/item/reagent_containers/cup/endless_flask/vitfro,/obj/item/reagent_containers/cup/endless_flask/saturnx,/obj/item/reagent_containers/cup/endless_flask/blastoff,/obj/item/reagent_containers/cup/endless_flask/determination)
	item_to_create = new item_to_create(loc)
	ADD_TRAIT(item_to_create, TRAIT_CONTRABAND, INNATE_TRAIT)
	return TRUE
