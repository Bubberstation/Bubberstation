/datum/round_event_control/antagonist
	reoccurence_penalty_multiplier = 0
	track = EVENT_TRACK_CREWSET
	/// Protected roles from the antag roll. People will not get those roles if a config is enabled
	var/protected_roles = list(
		JOB_CAPTAIN,
		JOB_BLUESHIELD,

		// Heads of staff
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_RESEARCH_DIRECTOR,
		JOB_QUARTERMASTER,
		JOB_NT_REP,

		// Seccies
		JOB_DETECTIVE,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_CORRECTIONS_OFFICER,
		JOB_PRISONER,
		JOB_SECURITY_MEDIC,

		// Department Guards-Additional
		JOB_BOUNCER,
		JOB_ORDERLY,
		JOB_CUSTOMS_AGENT,
		JOB_ENGINEERING_GUARD,
		JOB_SCIENCE_GUARD,
		)

	/// Restricted roles from the antag roll
	var/restricted_roles = list(JOB_AI, JOB_CYBORG)

	/// How many baseline antags do we spawn
	var/base_antags = 1
	/// How many maximum antags can we spawn
	var/maximum_antags = 2
	/// Strict limit on how many antagonists of this type that should be in this round. 0 to ignore.
	var/maximum_antags_global = 0
	/// For this many players we'll add 1 up to the maximum antag amount
	var/denominator = 20
	/// The antag flag to be used
	var/antag_flag
	/// The antag datum to be applied
	var/antag_datum

	var/minimum_candidate_base = 1

	var/list/ruleset_lazy_templates

/datum/round_event_control/antagonist/New()
	. = ..()
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_roles |= protected_roles
	restricted_roles |= SSstation.antag_restricted_roles
	restricted_roles |= SSstation.antag_protected_roles
	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_roles |= JOB_ASSISTANT
	for(var/datum/job/iterating_job as anything in subtypesof(/datum/job))
		if(initial(iterating_job.restricted_antagonists))
			restricted_roles |= initial(iterating_job.title)

/datum/round_event_control/antagonist/can_spawn_event(popchecks = TRUE, allow_magic)
	. = ..()
	if(!.)
		return
	if(!roundstart && !SSgamemode.can_inject_antags())
		return FALSE
	var/list/candidates = get_candidates()
	if(candidates.len < get_minimum_candidates())
		return FALSE

/datum/round_event_control/antagonist/proc/get_minimum_candidates()
	return minimum_candidate_base

/datum/round_event_control/antagonist/proc/get_candidates()
	var/round_started = SSticker.HasRoundStarted()
	var/list/candidates = SSgamemode.get_candidates(antag_flag, pick_roundstart_players = !round_started, restricted_roles = restricted_roles)
	return candidates

/datum/round_event_control/antagonist/solo
	typepath = /datum/round_event/antagonist/solo

/datum/round_event_control/antagonist/proc/get_antag_amount()

	var/people = SSgamemode.get_correct_popcount()
	var/amount = base_antags + FLOOR(people / denominator, 1)

	if(antag_datum && maximum_antags_global > 0)
		var/antag_slots_left = maximum_antags_global
		for(var/datum/antagonist/existing_antagonist as anything in GLOB.antagonists)
			if(QDELETED(existing_antagonist) || QDELETED(existing_antagonist.owner) || QDELETED(existing_antagonist.owner.current)) //This feels messy, but it just werks.
				continue
			if(!istype(existing_antagonist,antag_datum)) //Obviously ignore other antagonists.
				continue
			antag_slots_left-- //Slot is occupied.
			if(antag_slots_left <= 0) //No point in checking anymore.
				break
		amount = min(amount,antag_slots_left)

	return min(amount, maximum_antags)

/datum/round_event/antagonist
	fakeable = FALSE
	end_when = 60 //This is so prompted picking events have time to run //TODO: refactor events so they can be the masters of themselves, instead of relying on some weirdly timed vars
	// ALL of those variables are internal. Check the control event to change them
	/// The antag flag passed from control
	var/antag_flag
	/// The antag datum passed from control
	var/antag_datum
	/// The antag count passed from control
	var/antag_count
	/// The restricted roles (jobs) passed from control
	var/list/restricted_roles
	/// The minds we've setup in setup() and need to finalize in start()
	var/list/setup_minds = list()

/datum/round_event/antagonist/solo

/datum/round_event/antagonist/setup()
	load_vars(control)
	candidate_setup(control)
	template_setup(control)

/datum/round_event/antagonist/proc/load_vars(datum/round_event_control/antagonist/cast_control)
	// Set up all the different variables on the round_event. God isn't it ugly
	// Maybe move this to New() if possible? ~Waterpig
	antag_flag = cast_control.antag_flag
	antag_datum = cast_control.antag_datum
	antag_count = cast_control.get_antag_amount()
	restricted_roles = cast_control.restricted_roles

/datum/round_event/antagonist/proc/candidate_setup(datum/round_event_control/antagonist/cast_control)
	var/list/candidates = cast_control.get_candidates()
	for(var/i in 1 to antag_count)
		if(!candidates.len)
			break
		var/mob/candidate = pick_n_take(candidates)
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)

/datum/round_event/antagonist/proc/candidate_roles_setup(mob/candidate)
	SHOULD_CALL_PARENT(FALSE)

	candidate.mind.special_role = antag_flag
	candidate.mind.restricted_roles = restricted_roles

/datum/round_event/antagonist/proc/template_setup(datum/round_event_control/antagonist/cast_control)
	for(var/template in cast_control.ruleset_lazy_templates)
		SSmapping.lazy_load_template(template)

/datum/round_event/antagonist/solo/start()
	for(var/datum/mind/antag_mind as anything in setup_minds)
		add_datum_to_mind(antag_mind)

/datum/round_event/antagonist/proc/add_datum_to_mind(datum/mind/antag_mind)
	antag_mind.add_antag_datum(antag_datum)

/datum/round_event_control/antagonist/team
	typepath = /datum/round_event/antagonist/team
	minimum_candidate_base = 1

	var/antag_leader_datum

/datum/round_event_control/antagonist/team/New()
	. = ..()
	if(isnull(antag_leader_datum))
		antag_leader_datum = antag_datum

/datum/round_event/antagonist/team
	var/antag_leader_datum

/datum/round_event/antagonist/team/start()
	for(var/datum/mind/antag_mind as anything in setup_minds)
		add_datum_to_mind(antag_mind)

/datum/round_event/antagonist/team/load_vars(datum/round_event_control/antagonist/team/cast_control)
	. = ..()
	antag_leader_datum = cast_control.antag_leader_datum
