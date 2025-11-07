// Code from storyteller_planner.dm
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
			var/replan_delay = get_next_event_delay(evt, inputs, ctl)
			var/last_time = get_last_reference_time(ctl)
			try_plan_event(evt, last_time + replan_delay, TRUE)
			continue

		var/should_continue = TRUE
		for(var/datum/round_event_control/fired in fired_events) // Prevent multiple antagonist events in one think cycle
			if((fired.story_category & STORY_GOAL_ANTAGONIST) && (evt.story_category & STORY_GOAL_ANTAGONIST))
				should_continue = FALSE
				break
		if(!should_continue)
			continue

		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		var/threat_points_for_event = ctl.get_event_threat_points(evt.story_category)
		if(evt.run_event_as_storyteller(inputs, ctl, round(threat_points_for_event)))
			fired_events += evt
			entry[ENTRY_STATUS] = STORY_GOAL_COMPLETED
			ctl.post_event(evt)
		else
			entry[ENTRY_STATUS] = STORY_GOAL_PENDING
			timeline -= offset_str
			var/replan_delay = get_next_event_delay(evt, inputs, ctl)
			try_plan_event(evt, replan_delay)
			message_admins("[span_warning("[ctl.name] failed to fire: ")] [evt.name || evt.id] — rescheduling.")


	// First, clean up completed/failed events from timeline
	for(var/offset_str in timeline)
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			timeline -= offset_str

	var/pending_count = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	if(pending_count <= STORY_INITIAL_GOALS_COUNT && COOLDOWN_FINISHED(src, event_planning_cooldown))
		if(add_next_event(ctl, inputs, bal))
			COOLDOWN_START(src, event_planning_cooldown, planning_cooldown)

	if(COOLDOWN_FINISHED(src, recalculate_cooldown))
		COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
		recalculate_plan(ctl, inputs, bal, FALSE)

	sort_events()
	return fired_events



/// Recalculate the entire plan: Rebuild timeline from current state.
/// Clears invalid/unavailable events, ensures at least STORY_INITIAL_GOALS_COUNT pending events for continuous pacing.
/// Dynamically generates chain of events (no global/sub distinction), throttled by recalc_interval.
/// Triggers on major shifts (threat/adaptation) or emptiness; analyzes station for fresh tags.
/// Ensures storyteller's event chain branches adaptively toward threat escalation.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, force = FALSE)
	// Clean invalid events and count pending
	var/pending_count = 0
	var/invalid_events = 0
	var/list/upcoming_offsets = get_upcoming_events(length(timeline))
	var/list/to_delete = list()

	for(var/offset_str in upcoming_offsets)
		var/list/entry = timeline[offset_str]
		var/datum/round_event_control/event_control = entry[ENTRY_EVENT]
		if(!event_control.is_avaible(inputs, ctl) && !SSstorytellers.hard_debug)
			invalid_events++
			to_delete += offset_str
			continue
		if(entry[ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	for(var/delete_offset in to_delete)
		cancel_event(delete_offset)

	// Decide on action: full rebuild if force, major changes, or too few events
	var/needs_full_rebuild = force || (invalid_events > 0) || ctl.has_population_spike(15) || ctl.has_tension_spike(15) || (pending_count < STORY_INITIAL_GOALS_COUNT)

	if(!needs_full_rebuild && pending_count >= STORY_INITIAL_GOALS_COUNT)
		adjust_timeline_based_on_mood(ctl)
		return timeline

	clear_timeline()
	build_timeline(ctl, inputs, bal)



// Adjust existing timeline based on mood changes (pace/aggression)
// Compresses/expands intervals if pace high/low; slight shift based on aggression for escalation urgency
/datum/storyteller_planner/proc/adjust_timeline_based_on_mood(datum/storyteller/ctl)
	var/pace_mult = ctl.mood.pace  // >1 faster (compress), <1 slower (expand)
	var/aggr_shift = (ctl.mood.aggression - 1.0) * STORY_MOOD_AGGR_SHIFT_FACTOR
	var/current_time = world.time
	var/min_interval = ctl.get_event_interval() * 0.5  // Prevent too tight scheduling

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



/datum/storyteller_planner/proc/add_next_event(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/category = select_event_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)
	var/datum/round_event_control/new_event_control = build_event(ctl, inputs, bal, derived_tags, category)
	if(!new_event_control)
		return FALSE

	var/next_delay = get_next_event_delay(new_event_control, inputs, ctl)
	var/last_time = get_last_reference_time(ctl)
	var/fire_offset = last_time + next_delay
	if(try_plan_event(new_event_control, fire_offset, TRUE))
		var/format_time = time2text(fire_offset, "hh:mm", NO_TIMEZONE)
		var/foramt_name = "[new_event_control.name || new_event_control.id] [new_event_control.story_category & STORY_GOAL_ANTAGONIST ? span_red("- Antagonist event") : ""]"

		message_admins("[ctl.name] planned new event [foramt_name] at [format_time].")
		new_event_control.on_planned(fire_offset)
		return TRUE
	return FALSE


/datum/storyteller_planner/proc/try_plan_event(datum/round_event_control/event_control, time, fixed_time = FALSE)
	if(!event_control)
		return FALSE
	if(!timeline)
		timeline = list()

	var/base_delay = time
	var/attempts = 0
	var/max_attempts = 60

	while(attempts < max_attempts)
		var/target_time = fixed_time ? time : base_delay
		if(event_control.story_category & STORY_GOAL_BAD && target_time < owner.last_event_time + owner.get_scaled_grace())
			target_time = owner.last_event_time + owner.get_scaled_grace()
			base_delay = target_time
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


		base_delay += 10 SECONDS
		attempts++

	stack_trace("Storyteller planner: Failed to find free timeline slot after [max_attempts] attempts for event [event_control.id || event_control.name].")
	return FALSE


/datum/storyteller_planner/proc/sort_events()
	if(!timeline || !length(timeline))
		return

	var/list/sorted_keys = sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc))
	var/list/sorted_timeline = list()
	for(var/offset_str in sorted_keys)
		sorted_timeline[offset_str] = timeline[offset_str]

	timeline = sorted_timeline


/datum/storyteller_planner/proc/is_event_in_timeline(datum/round_event_control/event_control)
	if(ispath(event_control))
		event_control = locate(event_control) in SSstorytellers.events_by_id

	for(var/offset_str in timeline)
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_EVENT] == event_control)
			return TRUE
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
	if(!timeline[old_str])
		return FALSE

	var/new_num = new_offset
	var/attempt = 0
	var/max_attempts = 30
	while(attempt < max_attempts)
		var/new_str = time_key(new_num)
		if(!timeline[new_str])
			timeline[new_str] = timeline[old_str]
			timeline[new_str][ENTRY_FIRE_TIME] = new_num
			timeline[new_str][ENTRY_STATUS] = STORY_GOAL_PENDING
			timeline -= old_str
			return TRUE
		new_num += rand(5, 20) SECONDS
		attempt++

	return FALSE



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
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		return text2num(offset_str)

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
	var/delay = ctl.get_event_interval()
	if(event_control)
		if(event_control.story_category & STORY_GOAL_GOOD)
			delay *= 0.75
		else if(event_control.story_category & STORY_GOAL_BAD)
			delay += ctl.get_scaled_grace()
		else if(event_control.story_category & STORY_GOAL_NEUTRAL)
			delay *= 0.9
		else if(event_control.story_category & STORY_GOAL_RANDOM)
			delay *= rand(0.8, 1.2)  // Randomize timing for random events

	return delay


/datum/storyteller_planner/proc/get_last_reference_time(datum/storyteller/ctl)
	if(length(timeline))
		return get_closest_offest()
	return min(world.time, ctl.last_event_time)

#undef ENTRY_EVENT
#undef ENTRY_FIRE_TIME
#undef ENTRY_CATEGORY
#undef ENTRY_STATUS
#undef STORY_MOOD_AGGR_SHIFT_FACTOR
