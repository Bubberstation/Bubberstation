/obj/machinery/door
	var/fatness_to_check = 0

	var/check_fatness = FALSE
	var/check_fatness_below = FALSE

/obj/machinery/door/proc/change_fatness_to_check(mob/user)
	var/fatness_type = input(usr,
		"What level of fatness do you wish to alert above/under at?",
		src, "None") as null|anything in list(
		"None", "Fat", "Fatter", "Very Fat", "Obese", "Morbidly Obese", "Extremely Obese", "Barely Mobile", "Immobile", "Blob")
	if(!fatness_type)
		return	FALSE

	var/fatness_amount = 0	
	switch(fatness_type)
		if("Fat")
			fatness_amount = FATNESS_LEVEL_FAT
		if("Fatter")
			fatness_amount = FATNESS_LEVEL_FATTER 
		if("Very Fat")
			fatness_amount = FATNESS_LEVEL_VERYFAT
		if("Obese")
			fatness_amount = FATNESS_LEVEL_OBESE
		if("Morbidly Obese")
			fatness_amount = FATNESS_LEVEL_MORBIDLY_OBESE
		if("Extremely Obese")
			fatness_amount = FATNESS_LEVEL_EXTREMELY_OBESE
		if("Barely Mobile")
			fatness_amount = FATNESS_LEVEL_BARELYMOBILE
		if("Immobile")
			fatness_amount = FATNESS_LEVEL_IMMOBILE
		if("Blob")
			fatness_amount = FATNESS_LEVEL_BLOB
		
	fatness_to_check = fatness_amount	
	return TRUE
