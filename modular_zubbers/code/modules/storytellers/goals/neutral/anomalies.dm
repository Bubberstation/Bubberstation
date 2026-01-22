/datum/round_event_control/anomaly
	story_category = STORY_GOAL_NEVER

/datum/round_event_control/anomaly_storyteller
	name = "Anomaly Event"
	id = "anomaly_storyteller"
	typepath = /datum/round_event/anomaly_storyteller
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_WIDE_IMPACT, STORY_TAG_CHAOTIC)
	min_players = 8
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8
	required_round_progress = STORY_ROUND_PROGRESSION_MID

/datum/round_event/anomaly_storyteller
	STORYTELLER_EVENT

	var/static/anomaly_types = list(
		/obj/effect/anomaly/hallucination,
		/obj/effect/anomaly/bluespace,
		/obj/effect/anomaly/bioscrambler,
		/obj/effect/anomaly/dimensional,
		/obj/effect/anomaly/ectoplasm,
		/obj/effect/anomaly/flux,
		/obj/effect/anomaly/grav,
		/obj/effect/anomaly/pyro,
		/obj/effect/anomaly/bhole,
	)
	var/anomaly_count = 1
	var/max_anomalies = 3

	var/area/impact_area
	var/datum/anomaly_placer/placer = new()
	var/obj/effect/anomaly/anomaly_path = /obj/effect/anomaly/flux
	///The admin-chosen spawn location.
	var/turf/spawn_location

/datum/round_event/anomaly_storyteller/__setup_for_storyteller(threat_points, ...)
	. = ..()
	// Determine how many anomalies to spawn based on threat points
	anomaly_count = min(max_anomalies, round(threat_points / 3000))
	anomaly_count = max(1, max_anomalies)

	var/start_time = rand(10, 20)
	announce_when = start_time + rand(5, 15)
	start_when = start_time

	impact_area = placer.findValidArea()
	anomaly_path = pick(anomaly_types)

/datum/round_event/anomaly_storyteller/__start_for_storyteller()
	for(var/i = 1 to anomaly_count)
		spawn_anomaly()


/datum/round_event/anomaly_storyteller/proc/spawn_anomaly()
	var/turf/anomaly_turf

	if(spawn_location)
		anomaly_turf = spawn_location
	else
		anomaly_turf = placer.findValidTurf(impact_area)

	var/newAnomaly
	if(anomaly_turf)
		newAnomaly = new anomaly_path(anomaly_turf)
	if(newAnomaly)
		apply_anomaly_properties(newAnomaly)
		announce_to_ghosts(newAnomaly)


/datum/round_event/anomaly_storyteller/proc/apply_anomaly_properties(obj/effect/anomaly/new_anomaly)
	return
