//Can we use binary?
/mob/living/silicon/robot/binarycheck()
	var/area/our_area = get_area(src)
	if(our_area.area_flags & BINARY_JAMMING)
		return FALSE
	else if(!is_component_functioning("comms"))
		return FALSE
	return TRUE

//Can we transmit?
/obj/item/radio/borg/talk_into_impl(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	var/mob/living/silicon/robot/R = loc
	if(istype(R))
		if(!R.is_component_functioning("radio"))
			to_chat(R, span_warning("Your radio transmitter is not responding!"))
			return
	..()
