/// Prompts the user to select a level of weight.
/proc/choose_weight(input_text = "Choose a weight.", mob/user)
	var/chosen_weight = FALSE
	var/picked_weight_class = input(user,
		input_text,
		"Character Preference", "None") as null|anything in list(
			"None", "Fat", "Fatter", "Very Fat", "Obese", "Morbidly Obese", "Extremely Obese", "Barely Mobile", "Immobile", "Other")

	switch(picked_weight_class)
		if("Fat")
			chosen_weight = FATNESS_LEVEL_FATTER
		if("Fatter")
			chosen_weight = FATNESS_LEVEL_VERYFAT
		if("Very Fat")
			chosen_weight = FATNESS_LEVEL_OBESE
		if("Obese")
			chosen_weight = FATNESS_LEVEL_MORBIDLY_OBESE
		if("Morbidly Obese")
			chosen_weight = FATNESS_LEVEL_EXTREMELY_OBESE
		if("Extremely Obese")
			chosen_weight = FATNESS_LEVEL_BARELYMOBILE
		if("Barely Mobile")
			chosen_weight = FATNESS_LEVEL_IMMOBILE
		if("Immobile")
			chosen_weight = FATNESS_LEVEL_BLOB

	if(picked_weight_class != "Other")
		return chosen_weight

	var/custom_fatness = input(user, "What fatness level (BFI) would you like to use?", "Character Preference")  as null|num
	if(isnull(custom_fatness))
		custom_fatness = FALSE

	return custom_fatness
