/datum/round_event_control/grid_check
	id = "grid_check"
	story_category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_WHOLE_STATION
	typepath = /datum/round_event/grid_check/storyteller


/datum/round_event/grid_check/storyteller
	STORYTELLER_EVENT

	var/shutdown_duration_min = 2 MINUTES
	var/shutdown_duration_max = 5 MINUTES
	var/lock_rebot_chance = 10
	var/list/station_apcs = list()
	var/list/locked_apcs = list()

	COOLDOWN_DECLARE(apc_shutdown_cooldown)


/datum/round_event/grid_check/storyteller/__setup_for_storyteller(threat_points, ...)
	. = ..()
	if(threat_points < STORY_THREAT_LOW)
		shutdown_duration_min = 60
		shutdown_duration_max = 180
	else if(threat_points < STORY_THREAT_MODERATE)
		shutdown_duration_min = 120
		shutdown_duration_max = 240
		lock_rebot_chance = 15
	else if(threat_points < STORY_THREAT_HIGH)
		shutdown_duration_min = 180
		shutdown_duration_max = 240
		lock_rebot_chance = 15
	else if(threat_points < STORY_THREAT_EXTREME)
		shutdown_duration_min = 180
		shutdown_duration_max = 300
		lock_rebot_chance = 25
	else
		shutdown_duration_min = 300
		shutdown_duration_max = 420
		lock_rebot_chance = 30

	for(var/obj/machinery/power/apc/APC in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/apc))
		if(APC.area && !APC.failure_timer)
			station_apcs += WEAKREF(APC)

	end_when = shutdown_duration_max / 10
	COOLDOWN_START(src, apc_shutdown_cooldown, 30 SECONDS)

/datum/round_event/grid_check/storyteller/__start_for_storyteller()
	COOLDOWN_START(src, apc_shutdown_cooldown, 30 SECONDS)

/datum/round_event/grid_check/storyteller/__announce_for_storyteller()
	priority_announce("A station-wide power grid check will commence soon. Expect temporary shutdowns of various systems.")

/datum/round_event/grid_check/storyteller/__storyteller_tick(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, apc_shutdown_cooldown))
		return
	COOLDOWN_START(src, apc_shutdown_cooldown, rand(15-30) SECONDS)

	station_apcs = shuffle(station_apcs)
	var/to_shutdown = list()
	var/shutdown_cpount = max(1, round(length(station_apcs) * 0.2))
	for(var/datum/weakref/ref in station_apcs)
		if(shutdown_cpount <= 0)
			break
		var/obj/machinery/power/apc/APC = ref.resolve()
		if(!APC || !APC.area || APC.failure_timer)
			continue
		to_shutdown += APC
		shutdown_cpount -= 1
		station_apcs -= ref

	for(var/obj/machinery/power/apc/APC in to_shutdown)
		var/shutdown_duration = clamp(rand(shutdown_duration_min, shutdown_duration_max), shutdown_duration_min, shutdown_duration_max - activeFor)
		APC.energy_fail(shutdown_duration)
		if(prob(30))
			APC.overload_lighting()

		if(prob(lock_rebot_chance) && !HAS_TRAIT(src, TRAIT_NO_REBOOT_EVENT))
			ADD_TRAIT(src, TRAIT_NO_REBOOT_EVENT, "grid_check_event")
			locked_apcs += WEAKREF(APC)

/datum/round_event/grid_check/storyteller/__end_for_storyteller()
	for(var/datum/weakref/ref in locked_apcs)
		var/obj/machinery/power/apc/APC = ref.resolve()
		if(!APC)
			continue
		if(!HAS_TRAIT(src, TRAIT_NO_REBOOT_EVENT))
			continue
		REMOVE_TRAIT(src, TRAIT_NO_REBOOT_EVENT, "grid_check_event")
		APC.update()
		APC.update_appearance()

