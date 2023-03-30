/mob/living/unpixel_shift()
	. = ..()
	if(is_tilted)
		transform = transform.Turn(-is_tilted)
		is_tilted = 0
