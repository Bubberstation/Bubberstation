//Mostly copied from skyrat's genitals file.

/obj/item/organ/genital/penis/get_description_string(datum/sprite_accessory/genital/gas)

	var/returned_string = ""

	var/pname = LOWER_TEXT(genital_name) == "nondescript" ? "" : LOWER_TEXT(genital_name) + " "

	if(sheath != SHEATH_NONE && aroused != AROUSAL_FULL) //Hidden in sheath
		switch(sheath)
			if(SHEATH_NORMAL)
				returned_string = "You see a sheath."
			if(SHEATH_SLIT)
				returned_string = "You see a slit." ///Typo fix.
		if(aroused != AROUSAL_PARTIAL)
			return
		returned_string += " There's a [pname]penis poking out of it. "
	else
		returned_string += "You see a [pname]penis. "

	var/reported_girth = CEILING( girth / 3.1415, 0.25) //Circum to Diameter
	var/reported_length = genital_size

	if(aroused != AROUSAL_FULL)
		var/temperature_difference = owner.bodytemperature - owner.get_body_temp_normal()
		if(abs(temperature_difference) > 1)
			// https://www.desmos.com/calculator/ivauzad62s
			//I love penis math
			reported_length *= max(0.5, 1 - (-temperature_difference/50)**4)

	reported_length = CEILING(reported_length,0.5)

	returned_string = "You estimate it's about [genital_size] inches long, and about [girth] inches in diameter."

	switch(aroused)
		if(AROUSAL_NONE)
			returned_string += " It seems flaccid."
		if(AROUSAL_PARTIAL)
			returned_string += " It's partically erect."
		if(AROUSAL_FULL)
			returned_string += " It's fully erect."

	return returned_string
