/datum/disease
	/// Debug logs for disease transmission refactor, to verify after the fact the system is working as intended
	var/debug_id
	var/mobs_infected = 0

/datum/disease/proc/log_virus_debug(text)
	if(!debug_id)
		debug_id = assign_random_name()
	var/log_message = "VIRUS_DEBUG: [debug_id] [name != "No disease" ? "[name]" : "virus init"]: [text]"
	log_game(log_message)
	log_public_file(log_message)
	//to_chat(world, span_yellowteamradio("VIRUS_DEBUG: [debug_id] [name != "No disease" ? "[name]" : "virus init"]: [text]"))

/**
 * Check if the station manifest has at least a certain amount of this staff type
 *
 * Arguments:
 * * crew_threshold - amount of crew before it's no longer considered a skeleton crew
 *
*/
/datum/controller/subsystem/job/proc/is_skeleton_medical(crew_threshold)
	var/med_staff = 0
	for(var/datum/record/crew/target in GLOB.manifest.general)
		if(target.trim == JOB_CHIEF_MEDICAL_OFFICER)
			med_staff++

		if(target.trim == JOB_MEDICAL_DOCTOR)
			med_staff++

		if(target.trim == JOB_CHEMIST)
			med_staff++

	if(med_staff >= crew_threshold)
		return FALSE

	return TRUE


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
	bypasses_immunity = TRUE
