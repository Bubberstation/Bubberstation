
/datum/round_event_control/antagonist/solo/malf
	name = "Malfunctioning AI"

	base_antags = 1
	maximum_antags = 1
	maximum_antags_global = 1

	min_players = 20

	antag_datum = /datum/antagonist/malf_ai
	antag_flag = ROLE_MALF
	weight = 1
	tags = list(TAG_CREW_ANTAG, TAG_COMBAT, TAG_DESTRUCTIVE, TAG_CHAOTIC)
	restricted_roles = list()

/datum/round_event_control/antagonist/solo/malf/get_candidates()
	return GLOB.ai_list

/datum/round_event_control/antagonist/solo/malf/roundstart
	roundstart = TRUE
	typepath = /datum/round_event/antagonist/solo/malf_ai/roundstart
	weight = 10

// God has abandoned us
/datum/round_event_control/antagonist/solo/malf/roundstart/get_candidates()
	var/list/candidates = SSgamemode.get_candidates(antag_flag, pick_roundstart_players = TRUE, restricted_roles = restricted_roles)
	. = list()
	var/datum/job/aijob = SSjob.GetJob(JOB_AI)
	for(var/mob/candidate as anything in candidates)
		if(SSjob.check_job_eligibility(candidate, aijob) == JOB_AVAILABLE)
			. += candidate
	return .

/datum/round_event_control/antagonist/solo/malf/roundstart/can_spawn_event(popchecks, allow_magic)
	. = ..()
	if(!.)
		return .

	var/datum/job/ai_job = SSjob.GetJobType(/datum/job/ai)
	if(!(ai_job.total_positions - ai_job.current_positions && ai_job.spawn_positions))
		return FALSE
	else
		return TRUE

/datum/round_event/antagonist/solo/malf_ai/roundstart/setup()
	. = ..()
	for(var/datum/mind/new_malf in setup_minds)
		GLOB.pre_setup_antags += new_malf
		LAZYADDASSOC(SSjob.dynamic_forced_occupations, new_malf.current, "AI")
