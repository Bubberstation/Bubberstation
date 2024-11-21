/mob/living/carbon/proc/get_size_examine_info(mob/living/user)
	. = list()

	var/t_He = p_they()

	//Approximate character height based on current sprite scale
	var/dispSize = round(12*get_size(src)) // gets the character's sprite size percent and converts it to the nearest half foot
	if(dispSize % 2) // returns 1 or 0. 1 meaning the height is not exact and the code below will execute, 0 meaning the height is exact and the else will trigger.
		dispSize = dispSize - 1 //makes it even
		dispSize = dispSize / 2 //rounds it out
		. += "[t_He] appear\s to be around [dispSize] and a half feet tall."
	else
		dispSize = dispSize / 2
		. += "[t_He] appear\s to be around [dispSize] feet tall."
