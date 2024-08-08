/datum/disease
	/// Debug logs for disease transmission refactor, to verify after the fact the system is working as intended
	var/debug_id

/datum/disease/proc/log_virus_debug(text)
	if(!debug_id)
		debug_id = assign_random_name()
	log_game("VIRUS_DEBUG: [debug_id] [name != "No disease" ? "[name]" : "virus init"]: [text]")

/datum/disease/cold
	spreading_modifier = 4

/datum/disease/flu
	spreading_modifier = 3

/datum/disease/fluspanish
	spreading_modifier = 3

/datum/disease/magnitis
	spreading_modifier = 3

/datum/disease/pierrot_throat
	spreading_modifier = 2

/datum/disease/dna_retrovirus
	spreading_modifier = 3

/datum/disease/wizarditis
	spreading_modifier = 2

/datum/disease/cryptococcus
	spreading_modifier = 2

/datum/disease/beesease
	spreading_modifier = 3
