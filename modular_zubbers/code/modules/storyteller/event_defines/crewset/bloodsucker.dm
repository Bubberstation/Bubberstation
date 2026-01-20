/datum/round_event_control/antagonist/solo/bloodsucker
	name = "Bloodsuckers"
	roundstart = TRUE

	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	weight = 5
	min_players = 30

	maximum_antags_global = 3
	restricted_species = list(SPECIES_PROTEAN)
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)
	var/thrall_flag = ROLE_GHOUL
	var/list/thrall_candidates = list()

/datum/round_event_control/antagonist/solo/bloodsucker/get_candidates()
	. = ..()
	thrall_candidates = SSgamemode.get_candidates(thrall_flag, pick_roundstart_players = !round_started, restricted_roles = restricted_roles, restricted_species = restricted_species)

// each bloodsucker gets a thrall
/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)
	. = ..()
	for(var/datum/mind/candidate in setup_minds)
		var/mob/candidate = pick_n_take(thrall_candidates)
		setup_thrall(candidate)
	thrall_candidates.Cut()

/datum/round_event/antagonist/proc/setup_thrall(mob/candidate)
	candidate_roles_setup(candidate, thrall_flag)
	candidate.mind?.add_antag_datum(/datum/antagonist/ghoul/roundstart)

/datum/round_event_control/antagonist/solo/bloodsucker/midround
	name = "Vampiric Accident"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/bloodsucker/event
	name = "Event Generated Bloodsucker"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
