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
