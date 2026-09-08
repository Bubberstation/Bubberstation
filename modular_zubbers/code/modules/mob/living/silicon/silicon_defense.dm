/mob/living/silicon/grippedby(mob/living/carbon/user, instant = FALSE) //allows PAIs and small mob silicons to be agro grabbed
	if(mob_size < MOB_SIZE_HUMAN && user.grab_state < GRAB_AGGRESSIVE)
		return ..()
	return
