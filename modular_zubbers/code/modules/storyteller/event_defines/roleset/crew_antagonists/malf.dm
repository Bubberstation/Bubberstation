
/datum/round_event_control/antagonist/solo/malf
	name = "Malfunctioning AI"

	base_antags = 1
	maximum_antags = 1

	min_players = 0

	antag_datum = /datum/antagonist/malf_ai
	antag_flag = ROLE_MALF
	weight = 0
	tags = list(TAG_CREW_ANTAG, TAG_COMBAT, TAG_DESTRUCTIVE)
	restricted_roles = list()

/datum/round_event_control/antagonist/solo/malf/roundstart
	roundstart = TRUE
	typepath = /datum/round_event/antagonist/solo/malf_ai/roundstart
	weight = 5000

// God has abandoned us
/datum/round_event_control/antagonist/solo/malf/roundstart/get_candidates()
	var/list/candidates = ..()
	. = list()
	for(var/mob/candidate as anything in candidates)
		if(SSjob.check_job_eligibility(candidate, SSjob.GetJob(/datum/job/ai)) == JOB_AVAILABLE)
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

/*
/datum/round_event_control/antagonist/solo/malf/midround
	name = "Malfunctioning AI Midround"
	prompted_picking = TRUE
	roundstart = FALSE
	weight = 0

/datum/round_event_control/antagonist/solo/malf/get_candidates()
	. = ..()
	if(!.)
		return
	var/loop = .
	var/list/ai_in_round
	for(var/mob/living/silicon/ai/ai in loop)
		if(!isAI(ai))
			continue
		ai_in_round |= ai

	. = pick(ai_in_round)
*/
