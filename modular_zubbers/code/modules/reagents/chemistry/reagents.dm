/datum/reagent
	var/hydration = 0 //does this hydrate your thirst?

/datum/reagent/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.adjust_hydration(hydration)
