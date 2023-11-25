/mob/living/carbon/human/Logout()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_SUICIDED))
		alpha = GHOST_ALPHA

	if(!(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH))))
		if(get_organ_by_type(/obj/item/organ/internal/brain))
			if(!key)
				alpha = GHOST_ALPHA

/mob/living/carbon/human/Login()
	. = ..()
	alpha = 255
