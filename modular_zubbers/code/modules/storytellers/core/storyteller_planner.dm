#define ENTRY_EVENT "event"
#define ENTRY_FIRE_TIME "fire_time"
#define ENTRY_CATEGORY "category"
#define ENTRY_STATUS "status"
#define STORY_MOOD_AGGR_SHIFT_FACTOR 0.3

/datum/storyteller_planner
	var/datum/storyteller/owner
	/// Timeline plan: Assoc list of "[world.time + offset]" -> list(event_instance, category, status="pending|firing|completed")
	VAR_PRIVATE/list/timeline = list()
	/// Recalc frequency
	var/recalc_interval = STORY_RECALC_INTERVAL

	var/planning_cooldown = 30 SECONDS

	COOLDOWN_DECLARE(event_planning_cooldown)

	COOLDOWN_DECLARE(recalculate_cooldown)


/datum/storyteller_planner/New(datum/storyteller/_owner)
	..()
	owner = _owner



/// Main update_plan: Central control for event execution and timeline advancement in event chain.
/// Called every think tick; scans upcoming for fire-ready events, executes (run_event_as_storyteller()), updates status,
/// reschedules fails, cleans timeline. Returns list of fired events for think() processing (adaptation/tags).
/// Inspired by RimWorld's cycle firing with adaptive rescheduling.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!timeline)
		build_timeline(ctl, inputs, bal)

	var/list/fired_events = list()
	var/current_time = world.time

	for(var/offset_str in get_upcoming_events())
		var/offset = text2num(offset_str)
		var/list/entry = get_entry_at(offset)
		var/datum/round_event_control/evt = entry[ENTRY_EVENT]

		if(current_time < offset)
			continue

		var/status = entry[ENTRY_STATUS] || STORY_GOAL_PENDING
		if(status != STORY_GOAL_PENDING)
			continue

		if(!evt.can_fire_now(inputs, ctl))
			timeline -= offset_str
			try_plan_event(evt, get_next_event_delay(evt, inputs, ctl))
			continue

		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		/// Calculate threat points: scale by difficulty, population_factor, and threat_points
		var/threat_points_for_event = ctl.threat_points * ctl.difficulty_multiplier * clamp(ctl.population_factor, 0.3, 1.0) * 100
		if(evt.run_event_as_storyteller(inputs, ctl, round(threat_points_for_event)))
			fired_events += evt
			entry[ENTRY_STATUS] = STORY_GOAL_COMPLETED
			message_admins("[span_notice("Storyteller fired event: ")] [evt.name || evt.id]. with threat points: [threat_points_for_event]")
			ctl.post_event(evt)
		else
			entry[ENTRY_STATUS] = STORY_GOAL_PENDING
			timeline -= offset_str
			var/replan_delay = get_next_event_delay(evt, inputs, ctl)
			try_plan_event(evt, replan_delay)
			message_admins("[span_warning("Storyteller event failed to fire: ")] [evt.name || evt.id] — rescheduling.")


	// First, clean up completed/failed events from timeline
	for(var/offset_str in timeline)
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			timeline -= offset_str

	var/pending_count = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	// Ensure we always have at least STORY_INITIAL_GOALS_COUNT pending events
	// This prevents situations where storyteller doesn't plan any events
	if(pending_count < STORY_INITIAL_GOALS_COUNT)
		var/added = 0
		while(pending_count < STORY_INITIAL_GOALS_COUNT && added < 5)  // Limit attempts to prevent infinite loops
			if(add_next_event(ctl, inputs, bal))
				pending_count++
				added++
			else
				break  // Failed to add event, exit loop
		if(added > 0)
			COOLDOWN_START(src, event_planning_cooldown, planning_cooldown)
	else if(pending_count <= 0 && COOLDOWN_FINISHED(src, event_planning_cooldown))
		if(add_next_event(ctl, inputs, bal))
			COOLDOWN_START(src, event_planning_cooldown, planning_cooldown)

	if(COOLDOWN_FINISHED(src, recalculate_cooldown))
		COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
		recalculate_plan(ctl, inputs, bal, FALSE)

	return fired_events



/datum/storyteller_planner/proc/add_next_event(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/category = select_event_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)

	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		derived_tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		derived_tags |= STORY_TAG_DEESCALATION

	var/datum/round_event_control/new_event_control = build_event(ctl, inputs, bal, derived_tags, category)
	if(!new_event_control)
		return FALSE

	var/next_delay = get_next_event_delay(new_event_control, inputs, ctl)
	var/last_time = get_last_reference_time(ctl)
	var/fire_offset = last_time + next_delay
	if(try_plan_event(new_event_control, fire_offset, TRUE))
		log_storyteller_planner("[ctl.name] added next event to chain: [new_event_control.name || new_event_control.id] at offset [fire_offset] (relative delay: [next_delay]).")
		return TRUE
	return FALSE




/// Recalculate the entire plan: Rebuild timeline from current state.
/// Clears invalid/unavailable events, ensures at least 3 pending events for continuous pacing.
/// Dynamically generates chain of events (no global/sub distinction), throttled by recalc_interval.
/// Triggers on major shifts (threat/adaptation) or emptiness; analyzes station for fresh tags.
/// Ensures storyteller's event chain branches adaptively toward threat escalation.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, force = FALSE)
	var/list/validation_result = validate_and_collect_entries(ctl, inputs, force)
	if(validation_result["pending_count"] == -1)
		adjust_timeline_based_on_mood(ctl)
		return timeline

	var/initial_pending = validation_result["pending_count"]
	rebuild_timeline_from_valid(ctl, validation_result["valid_entries"])
	add_missing_events(ctl, inputs, bal, validation_result["pending_count"], force)

	var/final_pending = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			final_pending++

	log_storyteller_planner("Storyteller recalculated plan: [final_pending] pending events in chain (added [final_pending - initial_pending], invalids cleared: [validation_result["invalid_events"]]).")
	return timeline



// Validate entries, collect valid ones, count pending/invalids, decide if rebuild needed
/datum/storyteller_planner/proc/validate_and_collect_entries(datum/storyteller/ctl, datum/storyteller_inputs/inputs, force = FALSE)
	var/pending_count = 0
	var/invalid_events = 0
	var/list/upcoming_offsets = get_upcoming_events(length(timeline))
	var/list/valid_entries = list()
	var/list/to_delete = list()

	for(var/offset_str in upcoming_offsets)
		var/list/entry = timeline[offset_str]
		var/datum/round_event_control/event_control = entry[ENTRY_EVENT]
		if(!event_control.is_avaible(inputs, ctl) && !SSstorytellers.hard_debug)
			invalid_events++
			to_delete += offset_str
			continue
		valid_entries += list(entry)
		if(entry[ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	for(var/delete_offset in to_delete)
		cancel_event(delete_offset)

	var/needs_rebuild = (invalid_events > 0 || ctl.has_population_spike(15) || ctl.has_tension_spike(15))
	if(!(needs_rebuild && length(timeline) < 3) && !force)
		return list("pending_count" = -1, "valid_entries" = null, "invalid_events" = 0)

	if(force)
		clear_timeline()
		pending_count = 0
		valid_entries = list()
		invalid_events += length(to_delete)  // Update if cleared

	return list("pending_count" = pending_count, "valid_entries" = valid_entries, "invalid_events" = invalid_events)


// Rebuild timeline from valid entries with adjusted offsets
/datum/storyteller_planner/proc/rebuild_timeline_from_valid(datum/storyteller/ctl, list/valid_entries)
	if(length(valid_entries) <= 0)
		return

	var/list/new_timeline = list()
	var/base_interval = ctl.get_event_interval()
	var/last_time = get_last_reference_time(ctl)
	var/current_offset = 0

	for(var/i = 1 to length(valid_entries))
		var/list/entry = valid_entries[i]
		// Calculate delay: base interval + volatility variance
		// Low population increases intervals more significantly
		var/volatility_mult = 1 + (ctl.mood.volatility * 0.1)
		var/pop_interval_mult = 1.5 - (ctl.population_factor - 0.3) * (1.5 - 1.0) / (1.0 - 0.3)
		pop_interval_mult = clamp(pop_interval_mult, 1.0, 1.5)

		current_offset += base_interval * volatility_mult * pop_interval_mult
		var/new_offset_num = last_time + current_offset
		var/new_offset_str = num2text(new_offset_num)
		entry[ENTRY_FIRE_TIME] = new_offset_num
		new_timeline[new_offset_str] = entry
	timeline = new_timeline



// Adjust existing timeline based on mood changes (pace/aggression)
// Compresses/expands intervals if pace high/low; slight shift based on aggression for escalation urgency
/datum/storyteller_planner/proc/adjust_timeline_based_on_mood(datum/storyteller/ctl)
	var/pace_mult = ctl.mood.pace  // >1 faster (compress), <1 slower (expand)
	var/aggr_shift = (ctl.mood.aggression - 1.0) * STORY_MOOD_AGGR_SHIFT_FACTOR
	var/current_time = world.time
	var/min_interval = ctl.min_event_interval

	var/list/sorted_offsets = sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc))
	for(var/offset_str in sorted_offsets)
		var/offset_num = text2num(offset_str)
		if(offset_num <= current_time)
			continue  // Skip past

		var/delta = offset_num - current_time
		var/new_delta = round(delta / pace_mult + aggr_shift * delta * 0.1)  // Scale by pace, slight shift by aggr
		new_delta = max(min_interval, new_delta)  // Enforce min interval

		var/new_offset_num = current_time + new_delta
		var/new_offset_str = num2text(new_offset_num)

		if(timeline[new_offset_str])  // Collision? Shift slightly
			new_offset_num += rand(10, 30) SECONDS
			new_offset_str = num2text(new_offset_num)

		reschedule_event(offset_num, new_offset_num)



// Add missing events to reach target count
/datum/storyteller_planner/proc/add_missing_events(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, pending_count, force)
	var/target_add = max(1, STORY_INITIAL_GOALS_COUNT - pending_count)
	var/start_delay = get_next_event_delay(null, inputs, ctl)  // Base delay for first new event
	var/event_interval = ctl.get_event_interval()
	var/last_time = get_last_reference_time(ctl)

	var/category = select_event_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)

	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		derived_tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		derived_tags |= STORY_TAG_DEESCALATION

	for(var/i = 1 to target_add)
		var/datum/round_event_control/new_event_control = build_event(ctl, inputs, bal, derived_tags, category)
		if(!new_event_control)
			continue

		// Calculate fire delay: base interval with volatility and population scaling
		var/volatility_mult = 1 + (ctl.mood.volatility * 0.05)
		var/pop_interval_mult = 1.5 - (ctl.population_factor - 0.3) * (1.5 - 1.0) / (1.0 - 0.3)
		pop_interval_mult = clamp(pop_interval_mult, 1.0, 1.5)
		var/fire_delay = start_delay + (event_interval * (i - 1)) * volatility_mult * pop_interval_mult
		var/fire_offset = last_time + fire_delay
		if(ctl.can_trigger_event_at(fire_offset))
			if(try_plan_event(new_event_control, fire_offset, TRUE))
				pending_count++

	// Fallback if still low (add random)
	var/attempts = 0
	while(pending_count < STORY_INITIAL_GOALS_COUNT && attempts < 5)
		var/datum/round_event_control/fallback = build_event(ctl, inputs, bal, 0, STORY_GOAL_RANDOM)
		if(fallback)
			var/fire_delay = event_interval * (pending_count + 1)
			var/fire_offset = last_time + fire_delay
			if(try_plan_event(fallback, fire_offset))
				pending_count++
			else
				attempts++
				continue
		else
			attempts++
			continue
		attempts++




// Build initial timeline on round start: Generates chain of events as adaptive threat sequence.
// Analyzes station (bal/inputs) for category/tags, biases by threat/adaptation for escalation start.
// schedules with dynamic offsets based on mood/pace.
// Ensures buffer for branching sub-threats, fallback to random for continuity.
/datum/storyteller_planner/proc/build_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, derived_tags)
	timeline = list()

	var/pending_count = 0
	var/target_count = STORY_INITIAL_GOALS_COUNT
	for(var/i = 1 to target_count)
		add_next_event(ctl, inputs, bal)
		pending_count += 1

	COOLDOWN_START(src, event_planning_cooldown, planning_cooldown)
	COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
	return timeline



/datum/storyteller_planner/proc/try_plan_event(datum/round_event_control/event_control, time, fixed_time = FALSE)
	if(!event_control)
		return FALSE
	if(!timeline)
		timeline = list()

	var/base_delay = time
	var/attempts = 0
	var/max_attempts = 60

	while(attempts < max_attempts)
		var/target_time = 0
		if(fixed_time)
			target_time = time
		else
			target_time = base_delay

		var/target_str = time_key(target_time)
		if(!timeline[target_str])
			timeline[target_str] = list(
				ENTRY_EVENT = event_control,
				ENTRY_FIRE_TIME = target_time,
				ENTRY_CATEGORY = event_control.story_category,
				ENTRY_STATUS = STORY_GOAL_PENDING
			)
			if(SSstorytellers.hard_debug && attempts > 0)
				message_admins("Storyteller planner: Resolved timeline collision after [attempts] attempts for event [event_control.id || event_control.name] at offset [base_delay].")
			return TRUE

		base_delay += 1 MINUTES
		attempts++
	stack_trace("Storyteller planner: Failed to find free timeline slot after [max_attempts] attempts for event [event_control.id || event_control.name].")
	return FALSE



/datum/storyteller_planner/proc/time_key(num)
	PRIVATE_PROC(TRUE)
	if(!isnum(num))
		return num
	return _num2text(num)

/datum/storyteller_planner/proc/get_entry_at(time)
	var/key = ""
	if(isnum(time))
		key = time_key(time)
	else
		key = time
	return timeline[key]

/datum/storyteller_planner/proc/set_entry_at(time, entry)
	if(!entry || !islist(entry)) return
	timeline[time_key(time)] = entry
	return TRUE


// Get upcoming events: Returns list of string offsets (keys) for next N events (default 5).
// Used for preview/debugging in admin tools or logs.
/datum/storyteller_planner/proc/get_upcoming_events(limit = length(timeline))
	var/list/upcoming = list()
	var/count = 0
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		if(count >= limit)
			break
		upcoming += offset_str
		count++
	return upcoming

/datum/storyteller_planner/proc/get_closest_event()
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		var/entry = timeline[offset_str]
		return entry[ENTRY_EVENT]


/datum/storyteller_planner/proc/get_closest_entry()
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		return timeline[offset_str]
	return null


/datum/storyteller_planner/proc/reschedule_event(old_offset, new_offset)
	var/old_str = time_key(old_offset)
	var/new_str = time_key(new_offset)
	if(!timeline[old_str] || timeline[new_str])
		return FALSE
	timeline[new_str] = timeline[old_str]
	timeline[new_str][ENTRY_FIRE_TIME] = new_offset
	timeline[new_str][ENTRY_STATUS] = STORY_GOAL_PENDING
	timeline -= old_str
	return TRUE


/// Cancels an event from the timeline by removing it from the schedule
/// round_event_control is a singleton and should never be deleted
/datum/storyteller_planner/proc/cancel_event(offset)
	var/offset_str = time_key(offset)
	if(!timeline[offset_str])
		return FALSE
	// Only remove from timeline, do NOT delete round_event_control (it's a singleton!)
	timeline -= offset_str
	return TRUE


/datum/storyteller_planner/proc/get_events_in_time(time = 1 MINUTES)
	var/list/upcoming = list()
	var/current_time = world.time
	for(var/i = current_time to current_time + time)
		var/str_i = time_key(i)
		if(timeline[str_i])
			upcoming += timeline[str_i]
	return upcoming

/datum/storyteller_planner/proc/next_offest()
	return owner.get_event_interval() * (length(timeline) + 1)


/datum/storyteller_planner/proc/get_closest_offest()
	var/last_offset = 0
	if(length(timeline))
		var/max_key = 0
		for(var/key_str in timeline)
			var/k = text2num(key_str)
			if(k > max_key)
				max_key = k
		last_offset = max_key
	return last_offset


/datum/storyteller_planner/proc/clear_timeline()
	for(var/offset in get_upcoming_events(length(timeline)))
		cancel_event(offset)

/datum/storyteller_planner/proc/build_event(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, tag_filter = 0, category = STORY_GOAL_NEUTRAL)
	var/effective_threat = ctl.get_effective_threat() // was incorrectly get_effective_pace()
	tag_filter = tag_filter || derive_universal_tags(category, ctl, inputs, bal)
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(tag_filter & STORY_TAG_ESCALATION))
		tag_filter |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(tag_filter & STORY_TAG_DEESCALATION))
		tag_filter |= STORY_TAG_DEESCALATION

	var/list/candidates = SSstorytellers.filter_goals(category, tag_filter, null, FALSE)
	if(!candidates.len)
		candidates = SSstorytellers.filter_goals(STORY_GOAL_RANDOM)

	var/datum/round_event_control/event_control = ctl.mind.select_weighted_goal(ctl, inputs, bal, candidates, ctl.population_factor, tag_filter)
	return event_control

/datum/storyteller_planner/proc/derive_universal_tags(category, datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/tags = ctl.mind.tokenize(category, ctl, inputs, bal, ctl.mood)
	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_universal_tags"))
			if(tags & get_valid_bitflags("story_universal_tags")[tag_str])
				string_tags += tag_str + ", "
		message_admins("Storyteller [ctl.name] tokenize station snapshot with next tags: [string_tags]")
	return tags

/datum/storyteller_planner/proc/select_event_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	return ctl.mind.determine_category(ctl, bal)


/datum/storyteller_planner/proc/get_next_event_delay(datum/round_event_control/event_control, datum/storyteller_inputs/inputs, datum/storyteller/ctl)
	var/base_interval = ctl.get_event_interval()
	// Scale grace period by population_factor: low pop = longer minimum delay
	var/pop_grace_mult = 1.5 - (ctl.population_factor - 0.3) * (1.5 - 1.0) / (1.0 - 0.3)
	pop_grace_mult = clamp(pop_grace_mult, 1.0, 1.5)
	var/min_delay = ctl.grace_period * pop_grace_mult
	return max(min_delay, round(base_interval))


/datum/storyteller_planner/proc/get_last_reference_time(datum/storyteller/ctl)
	if(length(timeline))
		return get_closest_offest()
	return max(world.time, ctl.last_event_time)

#undef ENTRY_EVENT
#undef ENTRY_FIRE_TIME
#undef ENTRY_CATEGORY
#undef ENTRY_STATUS
#undef STORY_MOOD_AGGR_SHIFT_FACTOR
