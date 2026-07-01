/datum/round_event_control/antagonist/solo/devil
	name = "Devils"
	roundstart = TRUE

	antag_flag = ROLE_DEVIL
	antag_datum = /datum/antagonist/devil
	weight = 7 // Just for testing, then bump it down to 5.
	min_players = 30

	maximum_antags_global = 1

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

	protected_roles = list(
		JOB_CAPTAIN,
		JOB_BLUESHIELD,
		JOB_BRIDGE_ASSISTANT,

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

		// Direct Devil counters
		JOB_LAWYER,
		JOB_CHAPLAIN,
		)

/datum/round_event_control/antagonist/solo/devil/midround
	name = "Midround Devil"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/devil/event
	name = "Event Generated Devil"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
