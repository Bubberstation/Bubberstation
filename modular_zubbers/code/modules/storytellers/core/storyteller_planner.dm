#define ENTRY_EVENT "event"
#define ENTRY_FIRE_TIME "fire_time"
#define ENTRY_PLANNED_TIME "planned_time"
#define ENTRY_CATEGORY "category"
#define ENTRY_STATUS "status"
#define STORY_MOOD_AGGR_SHIFT_FACTOR 0.3

#define MIN_MAJOR_EVENT_INTERVAL (10 MINUTES)  		  // Minimum time between major events
#define MAX_RECENT_FIRED_HISTORY 5             		  // Max recent fired events to store
#define EVENT_CLUSTER_AVOIDANCE_BUFFER (150 SECONDS)  // Buffer to avoid clustering events too closely
#define MAX_PLAN_ATTEMPTS 100                  		  // Max attempts to find a free slot during planning

/datum/storyteller_planner
	VAR_PRIVATE/datum/storyteller/owner
	/// Timeline plan: Assoc list of "[world.time + offset]" -> list(event_instance, category, status="pending|firing|completed")
	VAR_PRIVATE/list/timeline = list()
	/// Recent fired events history: list of last MAX_RECENT_FIRED_HISTORY fired entries (for storyteller memory)
	VAR_PRIVATE/list/recent_fired = list()
	/// Recalc frequency
	VAR_PRIVATE/recalc_interval = STORY_RECALC_INTERVAL

	VAR_PRIVATE/planning_cooldown = 5 MINUTES

	VAR_PRIVATE/last_major_event

	VAR_PRIVATE/major_event_cooldown

	COOLDOWN_DECLARE(event_planning_cooldown)

	COOLDOWN_DECLARE(recalculate_cooldown)


/datum/storyteller_planner/New(datum/storyteller/_owner)
	..()
	owner = _owner


/// Main update_plan: Scans timeline for ready events, marks them for firing, cleans up, and returns list of ready events.
/// Does NOT execute events—returns them for the storyteller to handle. Maintains recent fired history (last 5).
/// Handles recalculation and adding new events if needed. Inspired by adaptive scheduling with anti-clustering.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!timeline)
		build_timeline(ctl, inputs, bal)

	var/list/ready_events = list()  // Events ready to fire (returned to storyteller)
	var/current_time = world.time

	// Scan and process upcoming events
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
			var/replan_delay = get_next_event_delay(evt, ctl)
			var/last_time = get_last_reference_time(ctl)
			try_plan_event(evt, last_time + replan_delay, FALSE)  // Allow insertion/shifting
			continue

		// Prevent multiple antagonist events in one cycle
		var/should_continue = TRUE
		for(var/datum/round_event_control/ready in ready_events)
			if((ready.story_category & STORY_GOAL_ANTAGONIST) && (evt.story_category & STORY_GOAL_ANTAGONIST))
				should_continue = FALSE
				break
		if(!should_continue)
			continue

		// Mark as firing and add to ready list (do not execute here)
		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		ready_events += evt

	// Clean up completed/failed events from timeline
	for(var/offset_str in timeline.Copy())  // Copy to avoid runtime during iteration
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED, STORY_GOAL_FIRING))
			timeline -= offset_str

	// Count pending events
	var/pending_count = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	// Add next event if low on pending and cooldown finished
	if(pending_count <= STORY_INITIAL_GOALS_COUNT && COOLDOWN_FINISHED(src, event_planning_cooldown))
		if(add_next_event(ctl, inputs, bal))
			COOLDOWN_START(src, event_planning_cooldown, planning_cooldown)

	// Recalculate if cooldown finished
	if(COOLDOWN_FINISHED(src, recalculate_cooldown))
		COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
		recalculate_plan(ctl, inputs, bal, FALSE)

	sort_events()
	return ready_events  // Return ready events for storyteller to fire


/// Recalculate the entire plan: Rebuild timeline from current state.
/// Clears invalid/unavailable events, ensures at least STORY_INITIAL_GOALS_COUNT pending events.
/// Generates adaptive chain with anti-clustering and major event spacing.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, force = FALSE)
	// Clean invalid events and count pending
	var/pending_count = 0
	var/list/upcoming_offsets = get_upcoming_events(length(timeline))
	var/list/to_delete = list()

	for(var/offset_str in upcoming_offsets)
		var/list/entry = timeline[offset_str]
		var/datum/round_event_control/event_control = entry[ENTRY_EVENT]
		if(!event_control.is_avaible(inputs, ctl) && !SSstorytellers.hard_debug)
			message_admins("[ctl.name] canceled event [event_control.name] since it no more avaible for firing")
			to_delete += offset_str
			continue
		if(entry[ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count += 1

	for(var/delete_offset in to_delete)
		cancel_event(delete_offset)

	// Full rebuild if needed
	var/needs_full_rebuild = force || ctl.has_population_spike(20)
	if(!needs_full_rebuild && pending_count)
		scale_timeline(ctl, inputs, bal)
		return timeline


	message_admins("[ctl.name] [force ? "was forced to" : ""] rebuild event time line [ctl.has_population_spike(20) ? "because of population spike" : ""]")
	clear_timeline(force)
	build_timeline(ctl, inputs, bal)


/datum/storyteller_planner/proc/scale_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, force = FALSE)
	var/list/upcoming_offsets = get_upcoming_events(length(timeline))
	var/scaled_average_time = ctl.get_event_interval()
	var/scaled_grace = ctl.get_scaled_grace()
	var/current_time = world.time

	for(var/offset_str in upcoming_offsets)
		var/list/entry = timeline[offset_str]
		if(!entry[ENTRY_EVENT])
			continue
		var/datum/round_event_control/evt = entry[ENTRY_EVENT]
		if(!evt)
			cancel_event(offset_str)
		var/planned_when = entry[ENTRY_PLANNED_TIME]
		var/required_offset = current_time + scaled_average_time
		if(evt.story_category & STORY_GOAL_MAJOR)
			required_offset += scaled_grace

		var/new_time = offset_str
		if(required_offset < offset_str)
			var/difference = required_offset - offset_str
			if(difference >= 5 MINUTES)
				difference = 5 MINUTES
			difference *= ctl.mood.get_event_frequency_multiplier()
			required_offset += difference
			new_time = planned_when + (required_offset - offset_str)
			reschedule_event(offset_str, new_time)
		current_time = new_time
	sort_events()
	return timeline


/// Build initial timeline: Generates adaptive sequence with anti-clustering and major spacing.
/datum/storyteller_planner/proc/build_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, derived_tags)
	timeline = list()

	var/target_count = STORY_INITIAL_GOALS_COUNT
	for(var/i = 1 to target_count)
		add_next_event(ctl, inputs, bal)

	COOLDOWN_START(src, event_planning_cooldown, planning_cooldown)
	COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
	return timeline


/// Adds the next event to the timeline with improved planning: selects category/event, calculates delay,
/// enforces major event spacing and anti-clustering during insertion.
/datum/storyteller_planner/proc/add_next_event(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/category = select_event_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)
	var/datum/round_event_control/new_event_control = build_event(ctl, inputs, bal, derived_tags, category)
	if(!new_event_control)
		return FALSE

	var/next_delay = get_next_event_delay(new_event_control, ctl)
	var/last_time = get_last_reference_time(ctl)
	var/fire_offset = last_time + next_delay

	// Enforce major event spacing if this is a major event
	if(new_event_control.story_category & STORY_GOAL_MAJOR)
		fire_offset = enforce_major_spacing(fire_offset)

	if(try_plan_event(new_event_control, fire_offset, FALSE))  // Allow insertion with anti-clustering
		new_event_control.on_planned(fire_offset)
		return TRUE
	return FALSE


/// Attempts to plan an event at the target time. If slot taken, tries to insert nearby with buffer.
/// If fixed_time=TRUE, fails if exact time unavailable. Enforces anti-clustering buffer.
/datum/storyteller_planner/proc/try_plan_event(datum/round_event_control/event_control, time, fixed_time = FALSE, silence = FALSE)
	if(!event_control)
		return FALSE
	if(!timeline)
		timeline = list()

	var/base_delay = time
	var/attempts = 0

	while(attempts < MAX_PLAN_ATTEMPTS)
		var/target_time = fixed_time ? time : base_delay
		var/target_str = time_key(target_time)
		// Check for clustering: ensure no event within EVENT_CLUSTER_AVOIDANCE_BUFFER
		if(!is_slot_available(target_time) && !silence)
			base_delay += EVENT_CLUSTER_AVOIDANCE_BUFFER + rand(10 SECONDS, 30 SECONDS)
			attempts++
			continue

		timeline[target_str] = list(
			ENTRY_EVENT = event_control,
			ENTRY_FIRE_TIME = target_time,
			ENTRY_CATEGORY = event_control.story_category,
			ENTRY_STATUS = STORY_GOAL_PENDING,
			ENTRY_PLANNED_TIME = world.time,
		)
		if(!silence)
			var/format_time = time2text(target_str, "hh:mm", NO_TIMEZONE)
			var/format_name = "[event_control.name || event_control.id] [event_control.story_category & STORY_GOAL_ANTAGONIST ? span_red("- Antagonist event") : ""]"
			message_admins("[owner.name] planned new event [format_name] at [format_time].")
		return TRUE
		base_delay += EVENT_CLUSTER_AVOIDANCE_BUFFER + rand(10 SECONDS, 30 SECONDS)
		attempts++

	stack_trace("[owner.name] Failed to find free slot after [MAX_PLAN_ATTEMPTS] attempts for event [event_control.id || event_control.name].")
	return FALSE


/// Checks if a time slot is available, considering anti-clustering buffer around existing events.
/datum/storyteller_planner/proc/is_slot_available(target_time)
	var/buffer = EVENT_CLUSTER_AVOIDANCE_BUFFER
	for(var/offset_str in timeline)
		var/existing_time = text2num(offset_str)
		if(abs(target_time - existing_time) < buffer)
			return FALSE
	return TRUE


/// Enforces minimum interval between major events by shifting the proposed time if too close.
/datum/storyteller_planner/proc/enforce_major_spacing(proposed_time)
	var/last_major_time = get_last_major_event_time()
	if(last_major_time && (proposed_time - last_major_time) < MIN_MAJOR_EVENT_INTERVAL)
		proposed_time = last_major_time + MIN_MAJOR_EVENT_INTERVAL + rand(0, 2 MINUTES)  // Add slight randomness
	return proposed_time


/// Returns the fire time of the most recent major event in timeline or recent_fired.
/datum/storyteller_planner/proc/get_last_major_event_time()
	var/last_major = 0
	for(var/offset_str in timeline)
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_CATEGORY] & STORY_GOAL_MAJOR)
			last_major = max(last_major, text2num(offset_str))

	for(var/list/entry in recent_fired)
		if(entry[ENTRY_CATEGORY] & STORY_GOAL_MAJOR)
			last_major = max(last_major, entry[ENTRY_FIRE_TIME])

	return last_major


/// Sorts timeline keys in ascending order.
/datum/storyteller_planner/proc/sort_events()
	if(!timeline || !length(timeline))
		return

	var/list/sorted_keys = sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc))
	var/list/sorted_timeline = list()
	for(var/offset_str in sorted_keys)
		sorted_timeline[offset_str] = timeline[offset_str]

	timeline = sorted_timeline


/// Checks if an event is already in the timeline.
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


/// Returns list of upcoming offset strings (keys), limited to N.
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


/// Reschedules an event to a new offset, using try_plan_event for insertion.
/datum/storyteller_planner/proc/reschedule_event(old_offset, new_offset)
	var/old_str = time_key(old_offset)
	if(!timeline[old_str])
		return FALSE

	if(try_plan_event(timeline[old_str][ENTRY_EVENT], new_offset, FALSE, TRUE))
		cancel_event(old_offset)
		return TRUE
	return FALSE


/// Cancels an event by removing it from timeline.
/datum/storyteller_planner/proc/cancel_event(offset)
	var/offset_str = time_key(offset)
	if(!timeline[offset_str])
		return FALSE
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


/datum/storyteller_planner/proc/clear_timeline(clear_antagonist_events = FALSE)
	for(var/offset in get_upcoming_events(length(timeline)))
		var/list/entry = get_entry_at(offset)
		if(!entry || !entry[ENTRY_CATEGORY] || !entry[ENTRY_EVENT])
			timeline -= offset
		if((entry[ENTRY_CATEGORY] & STORY_GOAL_ANTAGONIST) && !clear_antagonist_events)
			continue
		cancel_event(offset)


/datum/storyteller_planner/proc/build_event(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, tag_filter = 0, category = STORY_GOAL_NEUTRAL)
	tag_filter = tag_filter || derive_universal_tags(category, ctl, inputs, bal)
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


/datum/storyteller_planner/proc/get_next_event_delay(datum/round_event_control/event_control, datum/storyteller/ctl)
	var/delay = ctl.get_event_interval()
	if(event_control)
		if(event_control.story_category & STORY_GOAL_GOOD)
			delay *= 0.75
		else if(event_control.story_category & STORY_GOAL_BAD)
			delay += ctl.get_scaled_grace()
		else if(event_control.story_category & STORY_GOAL_NEUTRAL)
			delay *= 0.9
		else if(event_control.story_category & STORY_GOAL_RANDOM)
			delay *= rand(0.8, 1.2)
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
#undef MIN_MAJOR_EVENT_INTERVAL
#undef MAX_RECENT_FIRED_HISTORY
#undef EVENT_CLUSTER_AVOIDANCE_BUFFER
#undef MAX_PLAN_ATTEMPTS
#undef ENTRY_PLANNED_TIME
