/datum/heretic_knowledge/fisher
	name = "Hidden Fishing"
	desc = "Allows you to transmute a fish into ancient and powerful fishing knowledge."
	gain_text = "Wait, fishing? What is the purpose of this? There is literally no benefit to knowing this. I'm becoming insane."
	next_knowledge = list(
		/datum/heretic_knowledge/limited_amount/insanity_blade,
		/datum/heretic_knowledge/limited_amount/portal_protection,
		/datum/heretic_knowledge/limited_amount/hardcore,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/unfathomable_curio,
		/datum/heretic_knowledge/painting,
	)
	required_atoms = list(
		/obj/item/fish
	)
	result_atoms = list()

	cost = 0
	depth = 8
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "bait"

/datum/heretic_knowledge/fisher/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
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

/datum/heretic_knowledge/fisher/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	user.remove_traits(
		list(
			TRAIT_REVEAL_FISH,
			TRAIT_EXAMINE_FISHING_SPOT,
			TRAIT_EXAMINE_FISH,
			TRAIT_EXAMINE_DEEPER_FISH,
			TRAIT_FISHING_SPOT,

		),
		EXILE_FISHING_TRAIT
	)
