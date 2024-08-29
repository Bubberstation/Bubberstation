/datum/heretic_knowledge/exile_sight
	name = "Exile's Vision"
	desc = "Allows you to see and hear through walls."
	gain_text = "When alone in Exile, you begin to search hard for people. Perhaps a little too hard."

	cost = 2
	depth = 9
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "eyes"


/datum/heretic_knowledge/exile_sight/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	user.add_traits(
		list(
			TRAIT_XRAY_VISION,
			TRAIT_XRAY_HEARING
		),
		EXILE_VISION_TRAIT
	)

/datum/heretic_knowledge/exile_sight/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	user.remove_traits(
		list(
			TRAIT_XRAY_VISION,
			TRAIT_XRAY_HEARING
		),
		EXILE_VISION_TRAIT
	)
