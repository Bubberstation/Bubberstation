/datum/objective/mutiny/check_completion()
	if(target.current && IS_REVOLUTIONARY(target.current))
		return TRUE
	. = ..()
