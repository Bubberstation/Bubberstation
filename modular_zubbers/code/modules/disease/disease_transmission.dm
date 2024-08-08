/datum/disease
	/// Debug logs for disease transmission refactor, to verify after the fact the system is working as intended
	var/debug_id

/datum/disease/proc/log_virus_debug(text)
	if(!debug_id)
		debug_id = assign_random_name()
	log_game("VIRUS_DEBUG: [debug_id] [name != "No disease" ? "[name]" : "virus init"]: [text]")
