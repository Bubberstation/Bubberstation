/datum/heretic_knowledge/flask_purchase
	name = "Auto-Alchemical Creation"
	desc = "Allows you to transmute a metamaterial beaker and a heart into a magical flask that refills with with one of the selected reagents: \
	Godblood, Stimulants, Saturn-X, Blastoff, or Determination."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/reagent_containers/cup/beaker/meta = 1,
		/obj/item/organ/internal/heart = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/endless_flask)
	cost = 1
	route = PATH_ASH
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8

/datum/heretic_knowledge/flask_purchase/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/item_to_create = pick(subtypesof(/obj/item/reagent_containers/cup/endless_flask))
	item_to_create = new item_to_create(loc)
	ADD_TRAIT(item_to_create, TRAIT_CONTRABAND, INNATE_TRAIT)
	return TRUE
