/mob/living/update_transform(resize)
	appearance_flags |= PIXEL_SCALE
	if(fuzzy)
		appearance_flags &= ~PIXEL_SCALE
	. = ..()
