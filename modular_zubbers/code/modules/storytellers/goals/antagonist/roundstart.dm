#define ROLE_BLACKLIST_SECLIKE list( \
		JOB_CYBORG, \
		JOB_AI, \
		JOB_SECURITY_OFFICER, \
		JOB_WARDEN, \
		JOB_DETECTIVE, \
		JOB_HEAD_OF_SECURITY, \
		JOB_CAPTAIN, \
		JOB_CORRECTIONS_OFFICER, \
		JOB_NT_REP, \
		JOB_BLUESHIELD, \
		JOB_ORDERLY, \
		JOB_BOUNCER, \
		JOB_CUSTOMS_AGENT, \
		JOB_ENGINEERING_GUARD, \
		JOB_SCIENCE_GUARD, \
	)

#define ROLE_BLACKLIST_HEAD list( \
		JOB_CAPTAIN, \
		JOB_HEAD_OF_SECURITY, \
		JOB_RESEARCH_DIRECTOR, \
		JOB_CHIEF_ENGINEER, \
		JOB_CHIEF_MEDICAL_OFFICER, \
		JOB_HEAD_OF_PERSONNEL, \
	)

#define ROLE_BLACKLIST_SECHEAD list( \
		JOB_CAPTAIN, \
		JOB_HEAD_OF_SECURITY, \
		JOB_WARDEN, \
		JOB_DETECTIVE, \
		JOB_CHIEF_ENGINEER, \
		JOB_CHIEF_MEDICAL_OFFICER, \
		JOB_RESEARCH_DIRECTOR, \
		JOB_HEAD_OF_PERSONNEL, \
		JOB_CYBORG, \
		JOB_AI, \
		JOB_SECURITY_OFFICER, \
		JOB_WARDEN, \
		JOB_CORRECTIONS_OFFICER, \
		JOB_NT_REP, \
		JOB_BLUESHIELD, \
		JOB_ORDERLY, \
		JOB_BOUNCER, \
		JOB_CUSTOMS_AGENT, \
		JOB_ENGINEERING_GUARD, \
		JOB_SCIENCE_GUARD, \
	)

/datum/round_event_control/antagonist/from_living/roundstart_traitor
	id = "storyteller_roundstart_traitor"
	name = "Roundstart Traitor"
	description = "A crew member is assigned as a traitor at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_INDIVIDUALS | STORY_TAG_AFFECTS_SECURITY

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/traitor
	antag_name = "Traitor"
	role_flag = ROLE_TRAITOR
	blacklisted_roles = ROLE_BLACKLIST_SECLIKE
	candidates = 1
	min_candidates = 1
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 10

/datum/round_event_control/antagonist/from_living/roundstart_malf_ai
	id = "storyteller_roundstart_malf_ai"
	name = "Roundstart Malfunctioning AI"
	description = "The station AI becomes malfunctioning at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_TECHNOLOGY | STORY_TAG_WIDE_IMPACT

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	preferred_roles = list(/datum/job/ai)
	antag_datum_type = /datum/antagonist/malf_ai
	antag_name = "Malfunctioning AI"
	role_flag = ROLE_MALF
	max_candidates = 1
	min_candidates = 1
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 30

/datum/round_event_control/antagonist/from_living/roundstart_malf_ai/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE
	return !HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI)

/datum/round_event_control/antagonist/from_living/roundstart_blood_brother
	id = "storyteller_roundstart_blood_brother"
	name = "Roundstart Blood Brothers"
	description = "A pair of crew members form a blood brother team at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_INDIVIDUALS

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST  // Based on weight=5
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/brother
	antag_name = "Blood Brother"
	role_flag = ROLE_BROTHER
	blacklisted_roles = ROLE_BLACKLIST_SECLIKE
	max_candidates = 2
	min_candidates = 2
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 10

/datum/round_event_control/antagonist/from_living/roundstart_changeling
	id = "storyteller_roundstart_changeling"
	name = "Roundstart Changeling"
	description = "A crew member is assigned as a changeling at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/changeling
	antag_name = "Changeling"
	role_flag = ROLE_CHANGELING
	blacklisted_roles = ROLE_BLACKLIST_SECLIKE
	max_candidates = 1
	min_candidates = 1
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 15

/datum/round_event_control/antagonist/from_living/roundstart_heretic
	id = "storyteller_roundstart_heretic"
	name = "Roundstart Heretic"
	description = "A crew member is assigned as a heretic at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/heretic
	antag_name = "Heretic"
	role_flag = ROLE_HERETIC
	blacklisted_roles = ROLE_BLACKLIST_SECLIKE
	max_candidates = 1
	min_candidates = 1
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 20

/datum/round_event_control/antagonist/from_ghosts/roundstart_wizard
	id = "storyteller_roundstart_wizard"
	name = "Roundstart Wizard"
	description = "A wizard is spawned outside the station at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/wizard
	antag_name = "Wizard"
	role_flag = ROLE_WIZARD
	max_candidates = 1
	min_candidates = 1
	ghost_candidates = TRUE
	crew_candidates = FALSE
	min_players = 25
	signup_atom_appearance = /obj/structure/sign/poster/contraband/space_cube  // Thematic


/datum/round_event_control/antagonist/from_ghosts/roundstart_wizard/create_ruleset_body()
	// Wizard spawns in lair, handled by antag datum
	return new /mob/living/carbon/human

/datum/round_event_control/antagonist/from_living/roundstart_blood_cult
	id = "storyteller_roundstart_blood_cult"
	name = "Roundstart Blood Cult"
	description = "A group of crew members form a blood cult at round start, with one leader."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES
	enabled = FALSE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST  // Based on high impact, weight varies by tier
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	blacklisted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_CHAPLAIN)
	antag_datum_type = /datum/antagonist/cult
	antag_name = "Cultist"
	role_flag = ROLE_CULTIST
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 4
	min_candidates = 2
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 30

/datum/round_event_control/antagonist/from_living/roundstart_blood_cult/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	var/datum/team/cult/main_cult = new /datum/team/cult()
	main_cult.setup_objectives()
	var/datum/mind/most_experienced = get_most_experienced(spawned_antags, ROLE_CULTIST)
	for(var/datum/mind/candidate in spawned_antags)
		var/datum/antagonist/cult/cultist = locate(/datum/antagonist/cult) in candidate.antag_datums
		if(!cultist)
			continue
		cultist.cult_team = main_cult
		cultist.give_equipment = TRUE
		if(candidate == most_experienced)
			cultist.make_cult_leader()

/datum/round_event_control/antagonist/from_living/roundstart_revolution
	id = "storyteller_roundstart_revolution"
	name = "Roundstart Revolution"
	description = "A dormant head revolutionary is assigned at round start, revealed after delay if heads are present."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_POLITICS | STORY_TAG_WIDE_IMPACT
	enabled = FALSE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/rev/head
	antag_name = "Head Revolutionary"
	role_flag = ROLE_REV_HEAD
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 30

/datum/round_event_control/antagonist/from_living/roundstart_revolution/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	for(var/datum/mind/candidate in spawned_antags)
		candidate.special_roles += "Dormant Head Revolutionary"
	addtimer(CALLBACK(src, PROC_REF(reveal_head), spawned_antags), 7 MINUTES)

/datum/round_event_control/antagonist/from_living/roundstart_revolution/proc/reveal_head(list/spawned_antags)
	var/heads_necessary = 2
	var/head_check = 0
	for(var/mob/player as anything in get_active_player_list(alive_check = TRUE, afk_check = TRUE))
		if(player.mind?.assigned_role.job_flags & JOB_HEAD_OF_STAFF)
			head_check++

	if(head_check < heads_necessary)
		message_admins("Roundstart Revolution canceled: Not enough heads of staff.")
		return

	for(var/datum/mind/candidate in spawned_antags)
		candidate.special_roles -= "Dormant Head Revolutionary"
		if(!can_be_headrev(candidate))
			message_admins("Roundstart Revolution: Ineligible headrev, attempting replacement.")
			find_another_headrev()
			return
		GLOB.revolution_handler ||= new()
		var/datum/antagonist/rev/head/new_head = new()
		new_head.give_flash = TRUE
		new_head.give_hud = TRUE
		new_head.remove_clumsy = TRUE
		candidate.add_antag_datum(new_head, GLOB.revolution_handler.revs)
		GLOB.revolution_handler.start_revolution()

/datum/round_event_control/antagonist/from_living/roundstart_revolution/proc/find_another_headrev()
	return

/datum/round_event_control/antagonist/from_living/roundstart_spies
	id = "storyteller_roundstart_spies"
	name = "Roundstart Spies"
	description = "Crew members are assigned as spies at round start."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_ROUNDSTART | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_INDIVIDUALS

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/spy
	antag_name = "Spy"
	role_flag = ROLE_SPY
	blacklisted_roles = ROLE_BLACKLIST_SECLIKE
	max_candidates = 2
	min_candidates = 1
	ghost_candidates = FALSE
	crew_candidates = TRUE
	min_players = 10

#undef ROLE_BLACKLIST_SECLIKE
#undef ROLE_BLACKLIST_HEAD
#undef ROLE_BLACKLIST_SECHEAD
