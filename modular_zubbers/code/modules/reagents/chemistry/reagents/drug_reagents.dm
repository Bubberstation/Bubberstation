/datum/reagent/drug/nicotine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.clear_mood_event("/datum/addiction/nicotine_addiction")

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.clear_mood_event("/datum/addiction/alcohol_addiction")
