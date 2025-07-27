
/datum/round_event_control/antagonist/solo/malf
	name = "Malfunctioning AI Midround"

	base_antags = 1
	maximum_antags = 1
	maximum_antags_global = 1

	min_players = 20
	roundstart = FALSE
	alert_observers = TRUE

	antag_datum = /datum/antagonist/malf_ai
	antag_flag = ROLE_MALF
	weight = 1
	tags = list(TAG_CREW_ANTAG, TAG_COMBAT, TAG_DESTRUCTIVE, TAG_CHAOTIC)
	restricted_roles = list("Cyborg")

/datum/round_event_control/antagonist/solo/malf/can_spawn_event(players_amt, allow_magic, popchecks)
	return ..() && !HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI)

/datum/round_event_control/antagonist/solo/malf/get_candidates()
	var/list/candidates = ..()
	for(var/mob/candidate in candidates)
		if(!istype(candidate.mind.assigned_role, /datum/job/ai))
			candidates -= candidate

	return candidates

/datum/round_event_control/antagonist/solo/malf/roundstart
	name = "Malfunctioning AI"

	roundstart = TRUE
	typepath = /datum/round_event/antagonist/solo/malf_ai/roundstart
	weight = 6

// God has abandoned us
/datum/round_event_control/antagonist/solo/malf/roundstart/get_candidates()
	var/list/candidates = SSgamemode.get_candidates(antag_flag, pick_roundstart_players = TRUE, restricted_roles = restricted_roles)
	var/list/valid_candidates = list()
	for(var/mob/candidate as anything in candidates)
		// Malf AI can only go to people who want to be AI
		if(!candidate.client?.prefs?.job_preferences[/datum/job/ai::title])
			continue
		// And only to people who can actually be AI this round
		if(SSjob.check_job_eligibility(candidate, SSjob.get_job(JOB_AI), "[name] Candidacy") != JOB_AVAILABLE)
			continue
		// (Something else forced us to play a job that isn't AI)
		var/forced_job = LAZYACCESS(SSjob.forced_occupations, candidate)
		if(forced_job && forced_job != /datum/job/ai)
			continue
		// (Something else forced us NOT to play AI)
		if(/datum/job/ai::title in LAZYACCESS(SSjob.prevented_occupations, candidate.mind))
			continue
		valid_candidates += candidate
	return valid_candidates

/datum/round_event_control/antagonist/solo/malf/roundstart/can_spawn_event(popchecks, allow_magic)
	. = ..()
	if(!.)
		return .

	var/datum/job/ai_job = SSjob.get_job_type(/datum/job/ai)
	if(!(ai_job.total_positions - ai_job.current_positions && ai_job.spawn_positions))
		return FALSE
	else
		return TRUE

/datum/round_event/antagonist/solo/malf_ai/roundstart/setup()
	. = ..()
	for(var/datum/mind/new_malf in setup_minds)
		GLOB.pre_setup_antags += new_malf
		LAZYSET(SSjob.forced_occupations, new_malf.current, /datum/job/ai)
