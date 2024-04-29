/mob/living/carbon/human/species/shadekin
	race = /datum/species/shadekin


// This is expected to be called or used in situations where you already know the mob is dead
/mob/living/carbon/human/proc/get_dnr()
	return stat ? ((HAS_TRAIT(src, TRAIT_DNR) && !((src.mind?.get_ghost(FALSE, TRUE)) ? 1 : 0))) : 0
