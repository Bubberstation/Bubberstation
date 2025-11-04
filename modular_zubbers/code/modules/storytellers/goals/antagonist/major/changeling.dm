/datum/round_event_control/antagonist/from_living/round_start_changeling
	id = "storyteller_round_start_changeling"
	name = "Assign Changeling Role"
	description = "Select a crew member to assign round start changeling."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_AFFECTS_SECURITY | STORY_TAG_ENTITIES

	min_players = 15
	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST * 0.8
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

	antag_datum_type = /datum/antagonist/changeling
	antag_name = "Changeling"
	role_flag = ROLE_CHANGELING
	max_candidates = 1
