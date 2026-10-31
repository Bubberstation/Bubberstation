/mob/living/become_husk(source)
	. = ..()
	if(!.)
		return
	if(source == CHANGELING_DRAIN)
		src.AddComponent(/datum/component/changeling_zombie_infection)
