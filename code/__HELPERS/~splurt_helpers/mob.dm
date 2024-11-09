/proc/random_unique_arachnid_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(pick(GLOB.arachnid_first)) + " " + capitalize(pick(GLOB.arachnid_last))

		if(!findname(.))
			break

/proc/arachnid_name()
	return "[pick(GLOB.arachnid_first)] [pick(GLOB.arachnid_last)]"

/proc/resolve_intent_name(intent)
	switch(intent)
		if(INTENT_HELP)
			return "help"
		if(INTENT_DISARM)
			return "disarm"
		if(INTENT_GRAB)
			return "grab"
		if(INTENT_HARM)
			return "harm"

/mob/living/proc/is_body_part_exposed(body_part, list/items)
	if(!items)
		items = get_equipped_items()
	for(var/A in items)
		var/obj/item/I = A
		if(istype(I) && (I.body_parts_covered & body_part))
			return FALSE
	return TRUE

/mob/living/carbon/proc/get_blood_prefix()
	// Check for hemophage
	if(ishemophage(src))
		return "Hemo"

	// Check for Synthetic
	else if(issynthetic(src))
		return "Oil"

	// Check for Teshari
	else if(isteshari(src))
		return "Ammonia"

	// Check for Shadekin
	else if(isshadekin(src))
		return "Shade"

	// Check for round-start Slime
	else if(isroundstartslime(src))
		return "Slime"

	// Check for Snail
	else if(issnail(src))
		return "Lube"

	// Check for Skrell
	else if(is_species(src,/datum/species/skrell))
		return "Copper"

	// Check for Xenomorph Hybrid
	else if(isxenohybrid(src))
		return "Acid"

	// Check for Ethreal
	else if(isethereal(src))
		return "Electro"

	// Check for Podperson
	else if(ispodperson(src))
		return "Hydro"

	// Check for Plasmaman
	else if(isplasmaman(src))
		return "Plasma"
