/datum/action/item_action/berserk_mode/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!lavaland_equipment_pressure_check(get_turf(owner)))
		if(feedback)
			to_chat(owner, span_warning("You can't use this in a pressurised environment!"))
		return FALSE
	return TRUE
