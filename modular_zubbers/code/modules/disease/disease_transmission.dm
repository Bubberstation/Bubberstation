/datum/controller/subsystem/disease
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	flags = SS_BACKGROUND
	wait = 16 SECONDS
	/// List of event created diseases in all mobs
	var/list/event_diseases = list()
	var/cached_event_disease_count = 0
	var/previous_event_disease_count = 0
	var/next_cache_update = 0

/datum/controller/subsystem/disease/stat_entry(msg)
	msg = "P:[length(active_diseases)] EV:[cached_event_disease_count]"
	return ..()

/datum/controller/subsystem/disease/fire()
	update_event_disease_cache()

/datum/controller/subsystem/disease/proc/update_event_disease_cache()
	if(world.time >= next_cache_update)
		update_event_disease_metric()

	var/current_infections = 0
	for(var/datum/disease/active_infection as anything in event_diseases)
		if(isnull(active_infection.affected_mob) || active_infection.affected_mob?.stat == DEAD)
			continue // don't count dead people. they can't spread disease, right? right???...
		current_infections++

	cached_event_disease_count = current_infections
	SEND_SIGNAL(src, COMSIG_DISEASE_COUNT_UPDATE, cached_event_disease_count, previous_event_disease_count)

/datum/controller/subsystem/disease/proc/update_event_disease_metric()
	previous_event_disease_count = cached_event_disease_count
	next_cache_update = world.time + 4 MINUTES

/datum/disease
	/// Debug logs for disease transmission refactor, to verify after the fact the system is working as intended
	var/debug_id
	var/mobs_infected = 0
	var/event_disease = FALSE
	/// When this carrier was created
	var/start_time

/datum/disease/proc/log_virus_public(text)
	if(!event_disease)
		return
	var/log_message = "VIRUS_DEBUG: P:[length(SSdisease.event_diseases)] [debug_id ? debug_id : "VIRUS_INIT"] [name]: [text]"
	log_game(log_message)
	log_public_file(log_message)

/**
 *  Make virus visible to heath scanners
 */
/datum/disease/proc/make_visible()
	visibility_flags &= ~HIDDEN_SCANNER
	visibility_flags &= ~HIDDEN_MEDHUD
	if(!isnull(affected_mob))
		affected_mob.med_hud_set_status()

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
	bypasses_disease_recovery = TRUE

/datum/disease/fluspanish
	spreading_modifier = 3
	bypasses_disease_recovery = TRUE

/datum/disease/magnitis
	spreading_modifier = 3
	bypasses_disease_recovery = TRUE

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
	bypasses_disease_recovery = TRUE

/datum/disease/anxiety
	bypasses_disease_recovery = TRUE
