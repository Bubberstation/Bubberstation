// Minor Antagonists
/datum/round_event_control/antagonist/from_living/traitor
	id = "storyteller_traitor"
	name = "Traitor"
	description = "A crew member is converted to a traitor."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_TARGETS_INDIVIDUALS,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_SOCIAL,
	)

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/traitor
	antag_name = "Traitor"
	role_flag = ROLE_TRAITOR
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	min_players = 15

/datum/round_event_control/antagonist/from_living/bloodsucker
	id = "storyteller_bloodsucker"
	name = "Bloodsuckers"
	description = "A crew member is converted to a bloodsucker."
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_TARGETS_INDIVIDUALS,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_SOCIAL,
	)

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/bloodsucker
	antag_name = "Bloodsucker"
	role_flag = ROLE_BLOODSUCKER
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	min_players = 15

/datum/round_event_control/antagonist/from_living/heretic
	id = "storyteller_heretic"
	name = "Heretic"
	description = "A crew member is converted to a heretic."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_TARGETS_INDIVIDUALS,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_COMBAT,
	)

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/heretic
	antag_name = "Heretic"
	role_flag = ROLE_HERETIC
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 2
	min_candidates = 1
	min_players = 15

/datum/round_event_control/antagonist/from_living/changeling
	id = "storyteller_changeling"
	name = "Changeling"
	description = "A crew member is converted to a changeling."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_TARGETS_INDIVIDUALS,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_COMBAT,
	)
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/changeling
	antag_name = "Changeling"
	role_flag = ROLE_CHANGELING
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 2
	min_candidates = 1
	min_players = 15

/datum/round_event_control/antagonist/from_living/obsessed
	id = "storyteller_obsessed"
	name = "Obsessed"
	description = "A crew member becomes obsessed."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_TARGETS_INDIVIDUALS,
		STORY_TAG_MIDROUND,
		STORY_TAG_SOCIAL,
	)
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/obsessed
	antag_name = "Obsessed"
	role_flag = ROLE_OBSESSED
	max_candidates = 1
	min_candidates = 1
	min_players = 5

/datum/round_event_control/antagonist/from_ghosts/nightmare
	id = "storyteller_nightmare"
	name = "Nightmare"
	description = "A nightmare is spawned in maintenance."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_COMBAT,
		STORY_TAG_MIDROUND,
	)

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/nightmare
	antag_name = "Nightmare"
	role_flag = ROLE_NIGHTMARE
	max_candidates = 1
	min_candidates = 1
	min_players = 10
	signup_atom_appearance = /obj/item/flashlight/lantern

/datum/round_event_control/antagonist/from_ghosts/nightmare/create_ruleset_body()
	var/mob/living/carbon/human/candidate = new(find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE))
	candidate.set_species(/datum/species/shadow/nightmare)
	playsound(candidate, 'sound/effects/magic/ethereal_exit.ogg', 50, TRUE, -1)
	return candidate

/datum/round_event_control/antagonist/from_ghosts/slaughter_demon
	id = "storyteller_slaughter_demon"
	name = "Slaughter Demon"
	description = "A slaughter demon is spawned in space."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_COMBAT,
		STORY_TAG_MIDROUND,
	)

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/slaughter
	antag_name = "Slaughter Demon"
	role_flag = ROLE_ALIEN
	max_candidates = 1
	min_candidates = 1
	min_players = 15
	signup_atom_appearance = /mob/living/basic/demon/slaughter

/datum/round_event_control/antagonist/from_ghosts/slaughter_demon/create_ruleset_body()
	var/turf/spawnloc = find_space_spawn()
	var/mob/living/basic/demon/slaughter/demon = new(spawnloc)
	new /obj/effect/dummy/phased_mob/blood(spawnloc, demon)
	return demon

/datum/round_event_control/antagonist/from_ghosts/morph
	id = "storyteller_morph"
	name = "Morph"
	description = "A morph is spawned in maintenance."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_SOCIAL,
		STORY_TAG_MIDROUND,
	)
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/morph
	antag_name = "Morph"
	role_flag = ROLE_MORPH
	max_candidates = 1
	min_candidates = 1
	min_players = 10
	signup_atom_appearance = /mob/living/basic/morph

/datum/round_event_control/antagonist/from_ghosts/morph/create_ruleset_body()
	return new /mob/living/basic/morph(find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = FALSE))

/datum/round_event_control/antagonist/from_living/blood_brother
	id = "storyteller_blood_brother"
	name = "Blood Brothers"
	description = "A pair of crew members form a blood brother team."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_SOCIAL,
		STORY_TAG_COMBAT,
		STORY_TAG_MIDROUND,
	)
	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/brother
	antag_name = "Blood Brother"
	role_flag = ROLE_BROTHER
	blacklisted_roles = ROLE_BLACKLIST_SECLIKE
	max_candidates = 2
	min_candidates = 2
	min_players = 10

/datum/round_event_control/antagonist/from_living/spies
	id = "storyteller_spies"
	name = "Spies"
	description = "Crew members are assigned as spies."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_ENTITIES,
		STORY_TAG_COMBAT,
		STORY_TAG_MIDROUND,
	)
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
	min_players = 10
