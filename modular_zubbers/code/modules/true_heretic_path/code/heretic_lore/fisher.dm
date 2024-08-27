/datum/heretic_knowledge/fisher
	name = "Hidden Fishing"
	desc = "Allows you to transmute a metamaterial beaker and a heart into a magical flask that refills with with one of the selected reagents: \
	Godblood, Stimulants, Saturn-X, Blastoff, or Determination."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/fish
	)
	result_atoms = list(/obj/item/reagent_containers/cup/endless_flask)
	cost = 1
	route = PATH_ASH
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8

/datum/heretic_knowledge/fisher/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	user.add_traits(
		list(
			TRAIT_REVEAL_FISH,
			TRAIT_EXAMINE_FISHING_SPOT,
			TRAIT_EXAMINE_FISH,
			TRAIT_EXAMINE_DEEPER_FISH,
			TRAIT_FISHING_SPOT,

		),
		EXILE_FISHING_TRAIT
	)