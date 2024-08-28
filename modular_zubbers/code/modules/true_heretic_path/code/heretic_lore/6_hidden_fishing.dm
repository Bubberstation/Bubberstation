/datum/heretic_knowledge/fisher
	name = "Hidden Fishing"
	desc = "Allows you to transmute a fish into ancient and powerful fishing knowledge."
	gain_text = "Wait, fishing? What is the purpose of this? There is literally no benefit to knowing this. I'm becoming insane."
	next_knowledge = list(
		/datum/heretic_knowledge/limited_amount/insanity_blade
	)
	required_atoms = list(
		/obj/item/fish
	)
	result_atoms = list(/obj/item/reagent_containers/cup/endless_flask)

	cost = 1
	depth = 8
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "bait"


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