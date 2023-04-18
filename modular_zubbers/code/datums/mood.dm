#define MOOD_CATEGORY_THIRST "thirst"
#define MOOD_CATEGORY_PISS "piss"

/datum/mood/proc/handle_thirst()
	if(HAS_TRAIT(mob_parent, TRAIT_NOTHIRST) || !iscarbon(mob_parent))
		clear_mood_event(MOOD_CATEGORY_THIRST)
		return FALSE

	var/mob/living/carbon/carbon_mob = mob_parent
	switch(carbon_mob.hydration)
		if(HYDRATION_LEVEL_FULL to INFINITY)
			add_mood_event(MOOD_CATEGORY_THIRST, /datum/mood_event/wellhydrated)
		if(HYDRATION_LEVEL_WELL_HYDRATED to HYDRATION_LEVEL_FULL)
			add_mood_event(MOOD_CATEGORY_THIRST, /datum/mood_event/hydrated)
		if(HYDRATION_LEVEL_THIRSTY to HYDRATION_LEVEL_WELL_HYDRATED)
			clear_mood_event(MOOD_CATEGORY_THIRST)
		if(HYDRATION_LEVEL_DEHYDRATED to HYDRATION_LEVEL_THIRSTY)
			add_mood_event(MOOD_CATEGORY_THIRST, /datum/mood_event/thirsty)
		if(0 to HYDRATION_LEVEL_DEHYDRATED)
			add_mood_event(MOOD_CATEGORY_THIRST, /datum/mood_event/dehydrated)

	switch(carbon_mob.urination)
		if(0 to URINATION_LEVEL_PISSY)
			clear_mood_event(MOOD_CATEGORY_PISS)
		if(URINATION_LEVEL_PISSY to URINATION_LEVEL_VERY_PISSY)
			add_mood_event(MOOD_CATEGORY_PISS, /datum/mood_event/piss)
		if(URINATION_LEVEL_VERY_PISSY to INFINITY)
			add_mood_event(MOOD_CATEGORY_PISS, /datum/mood_event/verypiss)

#undef MOOD_CATEGORY_PISS
#undef MOOD_CATEGORY_THIRST
