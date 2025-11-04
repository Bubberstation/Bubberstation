/datum/round_event_control/antagonist/from_living/round_start_traitor
	id = "storyteller_round_start_traitor"
	name = "Assign Traitor Role"
	description = "Select a crew member to assign round start traitor."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_AFFECTS_SECURITY

	min_players = 10
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	blacklisted_roles = list(
		JOB_CYBORG,
		JOB_AI,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_CAPTAIN,
		JOB_CORRECTIONS_OFFICER,
		JOB_NT_REP,
		JOB_BLUESHIELD,
		JOB_ORDERLY,
		JOB_BOUNCER,
		JOB_CUSTOMS_AGENT,
		JOB_ENGINEERING_GUARD,
		JOB_SCIENCE_GUARD,
	)

	antag_datum_type = /datum/antagonist/traitor
	antag_name = "Rounsatrt traitor"
	role_flag = ROLE_TRAITOR
	max_candidates = 1


/datum/round_event_control/antagonist/from_living/midround_traitor
	id = "storyteller_midround_traitor"
	name = "Assign Midround Traitor Role"
	description = "Select a crew member to assign midround traitor."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_AFFECTS_SECURITY

	min_players = 10
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	blacklisted_roles = list(
		JOB_CYBORG,
		JOB_AI,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_CAPTAIN,
		JOB_CORRECTIONS_OFFICER,
		JOB_NT_REP,
		JOB_BLUESHIELD,
		JOB_ORDERLY,
		JOB_BOUNCER,
		JOB_CUSTOMS_AGENT,
		JOB_ENGINEERING_GUARD,
		JOB_SCIENCE_GUARD,
	)

	antag_datum_type = /datum/antagonist/traitor
	antag_name = "Midround traitor"
	role_flag = ROLE_TRAITOR
	max_candidates = 1


/datum/round_event_control/antagonist/from_ghosts/lone_infiltrator
	id = "storyteller_lone_infiltrator"
	name = "Spawn Lone Infiltrator"
	description = "A lone syndicate infiltrator has been sent to sabotage the station from within."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_SECURITY

	min_players = 13
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/traitor/lone_infiltrator
	antag_name = "Lone Syndicate Infiltrator"
	role_flag = ROLE_SYNDICATE_INFILTRATOR
	max_candidates = 1


