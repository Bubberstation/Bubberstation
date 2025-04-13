/datum/mood/proc/get_mood_colour()
	switch(mob_parent.mob_mood.sanity_level)
		if (SANITY_LEVEL_GREAT)
			. = "#2eeb9a"
		if (SANITY_LEVEL_NEUTRAL)
			. = "#86d656"
		if (SANITY_LEVEL_DISTURBED)
			. = "#4b96c4"
		if (SANITY_LEVEL_UNSTABLE)
			. = "#dfa65b"
		if (SANITY_LEVEL_CRAZY)
			. = "#f38943"
		if (SANITY_LEVEL_INSANE)
			. = "#f15d36"
	if(HAS_TRAIT(mob_parent, TRAIT_MOOD_NOEXAMINE))

		. = "#4b96c4"
		return
	return
