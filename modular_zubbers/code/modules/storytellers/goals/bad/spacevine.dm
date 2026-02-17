/datum/round_event_control/spacevine
	story_category = STORY_GOAL_NEVER

/datum/round_event_control/storyteller_spacevine
	name = "Spacevine Infestation"
	id = "storyteller_spacevine"
	typepath = /datum/round_event/storyteller_spacevine
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_WIDE_IMPACT, STORY_TAG_CHAOTIC, STORY_TAG_ESCALATION)

	story_weight = STORY_GOAL_BIG_WEIGHT
	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID

/datum/round_event/storyteller_spacevine
	STORYTELLER_EVENT

	fakeable = FALSE
	var/turf/override_turf
	var/list/selected_mutations
	var/potency
	var/production

/datum/round_event/storyteller_spacevine/__setup_for_storyteller(threat_points, ...)
	. = ..()
	selected_mutations = list()
	if(threat_points >= 1000)
		selected_mutations += list(
			/datum/spacevine_mutation/light,
			/datum/spacevine_mutation/transparency,
		)
	if(threat_points >= 4000)
		selected_mutations += list(
			/datum/spacevine_mutation/toxicity,
			/datum/spacevine_mutation/fire_proof,
			/datum/spacevine_mutation/temp_stabilisation,
			/datum/spacevine_mutation/flowering,
		)
	if(threat_points >= 7000)
		selected_mutations += list(
			/datum/spacevine_mutation/aggressive_spread,
			/datum/spacevine_mutation/gas_eater/oxy_eater,
		)

	potency = max(50, min(rand(50, 100), round(threat_points / 80)))
	production = max(1, min(rand(1, 4), round(threat_points / 1500)))


/datum/round_event/storyteller_spacevine/__start_for_storyteller()
	var/list/final_turf_candidates = list()

	if(override_turf)
		final_turf_candidates += override_turf
	else
		var/obj/structure/spacevine/vine = new()
		var/list/floor_candidates = list()
		for(var/area/station/hallway/area in shuffle(GLOB.areas))
			for(var/turf/open/floor in area.get_turfs_from_all_zlevels())
				if(isopenspaceturf(floor))
					continue
				floor_candidates += floor


		var/turfs_to_test = 100
		var/list/sampled_floor_candidates = pick_n(floor_candidates, min(turfs_to_test, length(floor_candidates)))

		for(var/turf/open/floor as anything in sampled_floor_candidates)
			if(floor.Enter(vine))
				final_turf_candidates += floor
		qdel(vine)

	if(!length(final_turf_candidates))
		return

	var/turf/floor = pick(final_turf_candidates)
	new /datum/spacevine_controller(floor, selected_mutations, potency, production, src)
