/mob/living/carbon/disarm(mob/living/carbon/target)
	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == src.dir)
	. = ..()

