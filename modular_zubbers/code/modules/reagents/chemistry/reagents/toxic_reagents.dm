//PISS
/datum/reagent/toxin/piss
	name = "Piss"
	color = COLOR_YELLOW
	taste_description = "expired beer"
	ph = 5
	toxpwr = 1 //not a toxin per-se but still toxic

/datum/reagent/toxin/piss/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(!(methods & INGEST))
		return

	if(HAS_TRAIT(exposed_mob, TRAIT_PISS_DRINKER))
		exposed_mob.add_mood_event("piss_drinker", /datum/mood_event/piss_enjoyer)
	else
		exposed_mob.adjust_disgust(10)

/datum/reagent/toxin/piss/on_mob_metabolize(mob/living/carbon/target)
	. = ..()
	target.adjust_hydration(-5)

/datum/reagent/toxin/piss/on_mob_life(mob/living/carbon/affected_mob, delta_time, times_fired)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_PISS_DRINKER))
		affected_mob.adjust_disgust(1)
	affected_mob.adjust_hydration(-3)
