/datum/reagent/consumable/coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(isvulpkanin(affected_mob))
		affected_mob.adjust_tox_loss(3 * seconds_per_tick)
