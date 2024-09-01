/mob/living/carbon/human/species/shadekin
	race = /datum/species/shadekin


// This is expected to be called or used in situations where you already know the mob is dead
/mob/living/carbon/human/proc/get_dnr()
	return stat ? ((HAS_TRAIT(src, TRAIT_DNR) && !((src.mind?.get_ghost(FALSE, TRUE)) ? 1 : 0))) : 0

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(wear_neck && body_position == STANDING_UP && loc == NewLoc && has_gravity(loc))
		SEND_SIGNAL(wear_neck, COMSIG_NECK_STEP_ACTION)
