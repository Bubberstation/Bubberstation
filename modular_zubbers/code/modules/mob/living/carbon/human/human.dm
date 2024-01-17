/mob/living/carbon/human/species/shadekin
	race = /datum/species/shadekin

/mob/living/carbon/human/proc/get_dnr()
	return (src.stat == DEAD && (HAS_TRAIT(src, TRAIT_DNR) || !((src.mind?.get_ghost(FALSE, TRUE)) ? 1 : 0)))
