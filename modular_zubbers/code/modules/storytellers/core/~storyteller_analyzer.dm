// Analyzer
// and weights for crew and antagonists. These metrics influence event planning,
// global goal selection, and balancing in the storyteller.
// Station value is a rough estimate of the station's overall "worth" based on atoms.
// Crew/antag weights help balance player vs. threat dynamics.
/datum/storyteller_analyzer
	// Our storyteller instance
	VAR_PRIVATE/datum/storyteller/owner
	/// Multiplier for the station value (can be adjusted by mood or other factors)
	var/multiplier = 1.0

	VAR_PRIVATE/list/check_list = list()

	var/analyzing = FALSE

	VAR_PRIVATE/cache_duration = 1 MINUTES

	COOLDOWN_DECLARE(inputs_cache_duration)

	COOLDOWN_DECLARE(station_integrity_duration)

	VAR_PRIVATE/datum/storyteller_inputs/actual_inputs

	VAR_PRIVATE/datum/station_state/actual_state

	VAR_PRIVATE/datum/station_state/cached_state

	VAR_PRIVATE/list/current_stack = list()

/datum/storyteller_analyzer/New(datum/storyteller/_owner)
	..()
	owner = _owner
	// Discover and register metric stages dynamically
	check_list = list()
	for(var/type in subtypesof(/datum/storyteller_metric))
		if(type == /datum/storyteller_metric)
			continue
		check_list += new type


	cached_state = new
	actual_state = new
	SSstorytellers.register_analyzer(src)

/datum/storyteller_analyzer/Destroy(force)
	SSstorytellers.unregister_analyzer(src)
	. = ..()


/datum/storyteller_analyzer/process(seconds_per_tick)
	if(COOLDOWN_FINISHED(src, inputs_cache_duration))
		INVOKE_ASYNC(src, PROC_REF(scan_station))


/datum/storyteller_analyzer/proc/get_inputs(scan_flags)
	SHOULD_NOT_OVERRIDE(TRUE)
	RETURN_TYPE(/datum/storyteller_inputs)
	return actual_inputs


/datum/storyteller_analyzer/proc/scan_station(scan_flags)
	set waitfor = FALSE

	if(analyzing)
		return


	current_stack = list()
	analyzing = TRUE
	SEND_SIGNAL(src, COMSIG_STORYTELLER_RUN_METRICS)

	var/start_time = world.time
	if(scan_flags & RESCAN_STATION_INTEGRITY)
		get_station_integrity(TRUE)

	COOLDOWN_START(src, inputs_cache_duration, cache_duration)
	var/datum/storyteller_inputs/inputs = new
	inputs.station_state = get_station_integrity()

	var/metrics_count = 0
	for(var/datum/storyteller_metric/check in check_list)
		if(!check.can_perform_now(src, owner, inputs, scan_flags))
			continue
		current_stack += check
		metrics_count++
		// Protect metric execution
		INVOKE_ASYNC(src, PROC_REF(__run_metric_safe), check, inputs, scan_flags)

	// Wait for async metrics to finish or timeout
	var/time_out = FALSE
	if(metrics_count <= 0)
		analyzing = FALSE
	var/timeout_at = world.time + (cache_duration * 2)
	while(analyzing && world.time < timeout_at)
		CHECK_TICK
		sleep(world.tick_lag)
	if(analyzing)
		// Timed out; stop now
		time_out = TRUE
		analyzing = FALSE
		log_storyteller_analyzer("Analyzer scan timed out; continuing with partial inputs")

	actual_inputs = inputs
	var/end_time = world.time - start_time
	current_stack = list()
	SEND_SIGNAL(src, COMSIG_STORYTELLER_FINISHED_ANALYZING, inputs, time_out, metrics_count)
	if(end_time > 5 SECONDS)
		message_admins("WARNING: [owner.name] finished to analyze the station in [end_time / 10] seconds, which is longer than expected.")

/datum/storyteller_analyzer/proc/__run_metric_safe(datum/storyteller_metric/check, datum/storyteller_inputs/inputs, scan_flags)
	INVOKE_ASYNC(check, TYPE_PROC_REF(/datum/storyteller_metric, perform), src, owner, inputs, scan_flags)



/datum/storyteller_analyzer/proc/try_stop_analyzing(datum/storyteller_metric/current)
	if(!can_finish_analyzing(current))
		return
	analyzing = FALSE


// Checks if the current scan stage is the last in the check_list
// Returns TRUE if it is the last stage (analysis can finish), FALSE otherwise
/datum/storyteller_analyzer/proc/can_finish_analyzing(datum/storyteller_metric/current)
	if(!(current in check_list))
		return FALSE

	var/datum/storyteller_metric/last_metric = current_stack[current_stack.len]
	if(current == last_metric)
		return TRUE

	return FALSE

/datum/storyteller_analyzer/proc/get_station_integrity(force = FALSE)
	set waitfor = FALSE

	if(!actual_state)
		actual_state = new
	if(!cached_state)
		cached_state = new

	cached_state.floor = actual_state.floor
	cached_state.wall = actual_state.wall
	cached_state.r_wall = actual_state.r_wall
	cached_state.window = actual_state.window
	cached_state.door = actual_state.door
	cached_state.grille = actual_state.grille
	cached_state.mach = actual_state.mach

	if(COOLDOWN_FINISHED(src, station_integrity_duration) || force)
		INVOKE_ASYNC(actual_state, TYPE_PROC_REF(/datum/station_state, count))
		COOLDOWN_START(src, station_integrity_duration, cache_duration * 10)
		return cached_state
	return actual_state


/datum/storyteller_analyzer/proc/calculate_threat_level(antag_weight, crew_weight)
	if(crew_weight == 0)
		return 100
	return min(100, (antag_weight / crew_weight) * 100)

/datum/storyteller_analyzer/proc/calculate_station_integrity()
	return 100

/datum/storyteller_analyzer/proc/calculate_crew_satisfaction()
	return 50
