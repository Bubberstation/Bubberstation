
#define MAP_EDGE_PAD 5
#define STORY_METEORS_DEFAULT_WAVE_COST 1666

// Threat point costs for each meteor type, scaled to reflect danger (max per spawn ~10000 if many)
GLOBAL_LIST_INIT(meteors_cost, list(
	/obj/effect/meteor/dust = 25,
	/obj/effect/meteor/medium = 100,
	/obj/effect/meteor/big = 250,
	/obj/effect/meteor/flaming = 300,
	/obj/effect/meteor/irradiated = 200,
	/obj/effect/meteor/carp = 250,
	/obj/effect/meteor/bluespace = 350,
	/obj/effect/meteor/banana = 150,
	/obj/effect/meteor/emp = 300,
	/obj/effect/meteor/cluster = 450,
	/obj/effect/meteor/tunguska = 1000,
	/obj/effect/meteor/meaty = 500,
	/obj/effect/meteor/meaty/xeno = 2500,
	/obj/effect/meteor/sand = 50,
	/obj/effect/meteor/pumpkin = 5000
))


/datum/round_event_control/meteor_wave
	id = "storyteller_meteors"
	name = "Spawn meteors"
	description = "Spawn meteors heavy based on storyteller threat level."
	story_category = STORY_GOAL_BAD | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_WIDE_IMPACT,
		STORY_TAG_ENVIRONMENTAL,
		STORY_TAG_REQUIRES_ENGINEERING,
		STORY_TAG_EPIC,
		STORY_TAG_CHAOTIC,
	)
	typepath = /datum/round_event/storyteller_meteors

	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	map_flags = EVENT_SPACE_ONLY

/datum/round_event_control/meteor_wave/on_planned(fire_time)
	. = ..()
	priority_announce("It has been determined that a close proximity of [station_name()] to an asteroid field has been detected. \
						The potential consequences of an impact collision must be considered.", "Orbital Observation Center")


/datum/round_event/storyteller_meteors
	STORYTELLER_EVENT

	var/list/weighted_meteor_types = list()

	var/wave_budget = 0

	var/wave_cost = STORY_METEORS_DEFAULT_WAVE_COST

	var/wave_count = 1

	var/current_wave = 0

	var/wave_cooldown = 30 SECONDS

	var/target_crew = FALSE

	var/selected_area = null

	var/selected_crew = null

	COOLDOWN_DECLARE(meteor_wave_cooldown)

	announce_when = 1

	start_when = 20

/datum/round_event/storyteller_meteors/__setup_for_storyteller(threat_points, ...)
	. = ..()
	if(SSmapping.is_planetary())
		return __kill_for_storyteller()

	wave_count = clamp(round(threat_points / wave_cost), 1, 10)
	wave_budget = round(threat_points / wave_count)

	if(threat_points < STORY_THREAT_LOW)
		weighted_meteor_types = GLOB.meteors_normal.Copy()
		wave_cooldown = 120 SECONDS
		wave_budget *= 0.9
	else if(threat_points < STORY_THREAT_MODERATE)
		weighted_meteor_types = GLOB.meteors_threatening.Copy()
		wave_cooldown = 90 SECONDS
		wave_budget *= 1.1
	else if(threat_points < STORY_THREAT_HIGH)
		weighted_meteor_types = GLOB.meteors_catastrophic.Copy()
		wave_cooldown = 70 SECONDS
		wave_budget *= 1.4
	else if(threat_points < STORY_THREAT_EXTREME)
		weighted_meteor_types = GLOB.meteors_catastrophic.Copy()
		wave_cooldown = 60 SECONDS
		wave_budget *= 1.8
	else
		weighted_meteor_types = GLOB.meteors_catastrophic.Copy()
		wave_cooldown = 30 SECONDS
		wave_budget *= 2
	end_when = wave_cooldown * (wave_count / 10)

/datum/round_event/storyteller_meteors/__announce_for_storyteller()
	var/msg = ""
	var/wave_power = round((wave_budget / 1000))
	var/wave_power_msg = ""
	if(wave_power == 1)
		wave_power_msg = "heavy"
	else if(wave_power == 2)
		wave_power_msg = "critical"
	else if(wave_power >= 3)
		wave_power_msg = "catastrophic"

	if(wave_count == 1)
		msg = "We are observing a small wave of meteors crossing the station orbit."
	else if(wave_count <= 3)
		msg = "We have detected several meteor waves crossing the orbit of your station and estimate their strength to be [wave_power_msg]."
	else
		msg = "We have detected multiple waves of meteors rapidly approaching the station [station_name()], \
			according to our estimates, their strength is [wave_power_msg], prepare for impact!"

	priority_announce(msg, "Orbital Observation Center", ANNOUNCER_METEORS)

	if(wave_power >= 3)
		SSsecurity_level.set_level(SEC_LEVEL_ORANGE, FALSE)

/datum/round_event/storyteller_meteors/__start_for_storyteller()
	current_wave = 0
	meteor_wave()

/datum/round_event/storyteller_meteors/__storyteller_tick(seconds_per_tick)
	if(current_wave < wave_count && COOLDOWN_FINISHED(src, meteor_wave_cooldown))
		COOLDOWN_START(src, meteor_wave_cooldown, wave_cooldown)
		meteor_wave()

/datum/round_event/storyteller_meteors/__end_for_storyteller()
	. = ..()
	priority_announce("The station has passed the meteor field, return to normal operation.", "Orbital Observation Center")

// Returns random safe station area
/datum/round_event/storyteller_meteors/proc/pick_target_area(ignore_dorms = FALSE)
	var/list/to_select = list()
	for(var/area/station/station_area in GLOB.areas)
		if(ignore_dorms && GLOB.dorms_areas[station_area])
			continue
		if(is_safe_area(station_area))
			to_select += station_area
	if(!length(to_select))
		return null
	return pick(to_select)

// We try to evode players that's erp rn
/datum/round_event/storyteller_meteors/proc/pick_target_crew(ignore_dorms = FALSE)
	var/list/crew = get_alive_station_crew(ignore_dorms)
	if(!length(crew))
		return null
	return pick(crew)

/datum/round_event/storyteller_meteors/proc/meteor_wave()
	current_wave++
	var/turf/target_turf = null

	if(prob(50))
		selected_area = pick_target_area()
		if(selected_area)
			target_turf = pick(get_area_turfs(selected_area))
		target_crew = FALSE
	else
		selected_crew = pick_target_crew()
		if(selected_crew)
			target_turf = get_turf(selected_crew)
		target_crew = TRUE

	if(!target_turf)
		target_turf = get_random_station_turf()

	var/direction = pick(GLOB.cardinals)

	spawn_meteors_targeted(direction, target_turf)

	if(current_wave >= wave_count)
		__end_for_storyteller()

/datum/round_event/storyteller_meteors/proc/spawn_meteors_targeted(direction, turf/target)
	var/remaining_budget = wave_budget
	var/max_spawn_attempts = 100 // Safety to prevent infinite loops

	while(remaining_budget > 0 && max_spawn_attempts > 0)
		max_spawn_attempts--

		// Filter affordable meteor types
		var/list/affordable_weights = list()
		for(var/meteor_type in weighted_meteor_types)
			var/cost = GLOB.meteors_cost[meteor_type] || 0
			if(cost > 0 && cost <= remaining_budget)
				affordable_weights[meteor_type] = weighted_meteor_types[meteor_type]

		if(!length(affordable_weights))
			break // No more affordable meteors

		var/meteor_type = pick_weight(affordable_weights)
		var/cost = GLOB.meteors_cost[meteor_type]

		// Pick start turf
		var/turf/picked_start
		var/max_attempts = 10
		while(max_attempts > 0)
			var/start_side = direction // Use fixed direction for the wave
			var/start_z = target.z
			picked_start = spaceDebrisStartLoc(start_side, start_z)
			if(isspaceturf(picked_start))
				break
			max_attempts--
		if(!isspaceturf(picked_start))
			continue // Skip if no valid start

		new meteor_type(picked_start, target)
		remaining_budget -= cost

#undef MAP_EDGE_PAD
#undef STORY_METEORS_DEFAULT_WAVE_COST
