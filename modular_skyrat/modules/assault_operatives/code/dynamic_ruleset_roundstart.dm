/*
*	ASSAULT OPERATIVES
*/

/datum/dynamic_ruleset/roundstart/assault_operatives
	name = "Assault Operatives"
	config_tag = "Roundstart Assault Operatives"
	pref_flag = ROLE_ASSAULT_OPERATIVE
	preview_antag_datum = /datum/antagonist/assault_operative
	minimum_required_age = 14
	blacklisted_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_SECURITY,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_CHIEF_ENGINEER,
	)
	weight = 3
	min_pop = 50
	ruleset_flags = RULESET_INVADER|RULESET_HIGH_IMPACT
	min_antag_cap = 5
	max_antag_cap = list("denominator" = 18, "offset" = 1)

/datum/dynamic_ruleset/roundstart/assault_operatives/prepare_for_role(datum/mind/candidate)
	LAZYSET(SSjob.forced_occupations, candidate, /datum/job/assault_operative)

/datum/dynamic_ruleset/roundstart/assault_operatives/create_execute_args()
	return list(
		new /datum/team/assault_operatives(),
	)

/datum/dynamic_ruleset/roundstart/assault_operatives/assign_role(datum/mind/candidate, datum/team/ops_team)
	candidate.add_antag_datum(/datum/antagonist/assault_operative, ops_team)

/datum/dynamic_ruleset/roundstart/assault_operatives/execute()
	. = ..()
	SSgoldeneye.required_keys = get_goldeneye_key_count()

/// Returns the required goldeneye keys for activation. This is to make sure we don't have an impossible to achieve goal. However, there has to be at least one key.
/datum/dynamic_ruleset/roundstart/assault_operatives/proc/get_goldeneye_key_count()
	return clamp(LAZYLEN(SSjob.get_all_heads()), 1, GOLDENEYE_REQUIRED_KEYS_MAXIMUM)
