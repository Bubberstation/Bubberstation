/datum/mood_event/quenched
	description = "<span class='nicegreen'>I'm quenched!</span>\n"
	mood_change = 6

/datum/mood_event/thirsty
	description = "<span class='warning'>I'm getting a bit thirsty.</span>\n"
	mood_change = -8

/datum/mood_event/dehydrated
	description = "<span class='boldwarning'>I'm dehydrated!</span>\n"
	mood_change = -15

/datum/mood/proc/HandleThirst()
	if(HAS_TRAIT(mob_parent, TRAIT_NOTHIRST))
		return FALSE //no mood events for thirst
	if(mob_parent.water_level >= THIRST_LEVEL_THRESHOLD)
		mob_parent.set_thirst(clamp(mob_parent.water_level, 0, THIRST_LEVEL_THRESHOLD))
		mob_parent.water_level = 380
	switch(mob_parent.water_level)
		if(THIRST_LEVEL_QUENCHED to INFINITY)
			add_mood_event(MOOD_CATEGORY_WATER, /datum/mood_event/quenched)
		if(THIRST_LEVEL_THIRSTY to THIRST_LEVEL_QUENCHED)
			clear_mood_event(MOOD_CATEGORY_WATER)
		if(THIRST_LEVEL_PARCHED to THIRST_LEVEL_THIRSTY)
			add_mood_event(MOOD_CATEGORY_WATER, /datum/mood_event/thirsty)
		if(0 to THIRST_LEVEL_PARCHED)
			add_mood_event(MOOD_CATEGORY_WATER, /datum/mood_event/dehydrated)
	return TRUE
