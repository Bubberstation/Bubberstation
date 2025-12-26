/datum/round_event_control/antagonist/solo/heretic
	name = "Heretics"
	roundstart = TRUE

	antag_flag = ROLE_HERETIC
	antag_datum = /datum/antagonist/heretic
	weight = 5
	min_players = 30

	maximum_antags_global = 2

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/heretic/New()
	protected_roles |= JOB_CHAPLAIN // Would be silly to get chaplain heretics
	. = ..()

/datum/round_event_control/antagonist/solo/heretic/midround
	name = "Midround Heretics"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/heretic/can_spawn_event(players_amt, allow_magic = FALSE)
	. = ..()
	if(!.) //if we can't spawn it normally, then don't bother checking below
		return .
	var/datum/job/chaplain_job = SSjob.get_job(JOB_CHAPLAIN)
	if(chaplain_job.current_positions <= 0) //Current positions is the amount of people in this job.
		return FALSE
