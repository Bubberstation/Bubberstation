/datum/action/cooldown/spell/pointed/unsettle
	stun_time = 3 SECONDS


/mob/living/basic/voidwalker/check_wall_validity(turf/closed/wall/wall_to_check, silent = TRUE)
	return TRUE

//purplish tint night vision because the voidwalker is purple
/mob/living/basic/voidwalker
	lighting_cutoff_red = 30
	lighting_cutoff_green = 15
	lighting_cutoff_blue = 30
