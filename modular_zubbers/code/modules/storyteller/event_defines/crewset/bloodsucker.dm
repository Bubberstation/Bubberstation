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
	typepath = /datum/round_event/antagonist/solo/bloodsucker
	var/list/thrall_candidates = list()
	var/thrall_flag = ROLE_GHOUL

/datum/round_event_control/antagonist/solo/bloodsucker/get_candidates()
	. = ..()
	var/round_started = SSticker.HasRoundStarted()
	thrall_candidates = SSgamemode.get_candidates(thrall_flag, pick_roundstart_players = !round_started, restricted_roles = restricted_roles, restricted_species = restricted_species)

/datum/round_event/antagonist/solo/bloodsucker
	var/list/setup_thralls = list()
	var/thrall_flag = /datum/round_event_control/antagonist/solo/bloodsucker::thrall_flag

/datum/round_event/antagonist/solo/bloodsucker/candidate_setup(datum/round_event_control/antagonist/cast_control)
	. = ..()
	var/datum/round_event_control/antagonist/solo/bloodsucker/cast = cast_control
	if(!istype(cast))
		CRASH("Cast control passed to bloodsucker candidate_setup is not of correct type!")
	var/list/thrall_candidates = cast.thrall_candidates
	for(var/datum/mind/bloodsucker_mind in setup_minds)
		var/mob/candidate = pick_n_take(thrall_candidates)
		setup_thralls += candidate.mind
		setup_thrall(candidate)

/datum/round_event/antagonist/solo/bloodsucker/proc/setup_thrall(mob/candidate)
	candidate_roles_setup(candidate, thrall_flag)


/datum/round_event/antagonist/solo/bloodsucker/on_start(datum/mind/antag_mind)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsucker_datum = antag_mind.has_antag_datum(antag_datum)
	if(!bloodsucker_datum)
		CRASH("[antag_mind.current] has no bloodsucker datum in on_start!")
	var/mob/thrall = pick_n_take(setup_thralls)
	var/datum/antagonist/ghoul/ghouldatum = new(thrall.mind)
	ghouldatum.master = bloodsucker_datum
	thrall.mind.add_antag_datum(ghouldatum)

/datum/round_event_control/antagonist/solo/bloodsucker/midround
	name = "Vampiric Accident"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/bloodsucker/event
	name = "Event Generated Bloodsucker"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1

