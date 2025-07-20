// pAI
/mob/living/silicon/pai
    	/// Whetever this pAI has leashing enabled
	var/holo_leash = FALSE
/mob/living/silicon/pai/get_status_tab_items()
	. = ..()
	if(!holo_leash)
		. += "Mobile Emitter: enabled"
	else
		. += "Mobile Emitter: disabled"
