#define ENTRY_GOAL "goal"
#define ENTRY_FIRE_TIME "fire_time"
#define ENTRY_CATEGORY "category"
#define ENTRY_STATUS "status"
#define STORY_MOOD_AGGR_SHIFT_FACTOR 0.3

/datum/storyteller_planner
	// Our owner
	var/datum/storyteller/owner
	/// Current global goal instance
	var/datum/storyteller_goal/current_goal
	/// List of active subgoals (instances or IDs)
	var/list/subgoals = list()
	/// Timeline plan: Assoc list of "[world.time + offset]" -> list(goal_instance, category, status="pending|firing|completed")
	VAR_PRIVATE/list/timeline = list()
	/// Recalc frequency
	var/recalc_interval = STORY_RECALC_INTERVAL

	var/planning_cooldown = 3 MINUTES

	COOLDOWN_DECLARE(goal_planing_cooldown)

	COOLDOWN_DECLARE(recalculate_cooldown)


/datum/storyteller_planner/New(datum/storyteller/_owner)
	..()
	owner = _owner



// Main update_plan: Central control for goal execution and timeline advancement in event chain.
// Called every think tick; scans upcoming for fire-ready goals, executes (complete()), updates status,
// reschedules fails, cleans timeline. Returns list of fired goals for think() processing (adaptation/tags).
// inspired by RimWorld's cycle firing with adaptive rescheduling.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!timeline)
		build_timeline(ctl, inputs, bal)

	var/list/fired_goals = list()
	var/current_time = world.time

	for(var/offset_str in get_upcoming_goals())
		var/offset = text2num(offset_str)
		var/list/entry = get_entry_at(offset)
		var/datum/storyteller_goal/goal = entry[ENTRY_GOAL]

		if(current_time < offset)
			continue

		var/status = entry[ENTRY_STATUS] || STORY_GOAL_PENDING
		if(status != STORY_GOAL_PENDING)
			continue

		if(!goal.can_fire_now(inputs.vault, inputs, ctl))
			timeline -= offset_str
			try_plan_goal(goal, get_next_goal_delay(goal, inputs, ctl))  // Use helper for relative delay calculation
			continue

		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		// We literally multiply by difficulty_multiplier, it's mean 5x difficulty = 5x points
		if(goal.complete(inputs.vault, inputs, ctl, round(ctl.threat_points * ctl.difficulty_multiplier * 100), inputs.station_value))
			fired_goals += goal
			entry[ENTRY_STATUS] = STORY_GOAL_COMPLETED
			message_admins("[span_notice("Storyteller fired goal: ")] [goal.name || goal.id].")
			ctl.post_goal(goal)
		else
			entry[ENTRY_STATUS] = STORY_GOAL_PENDING
			timeline -= offset_str
			var/replan_delay = get_next_goal_delay(goal, inputs, ctl)
			try_plan_goal(goal, replan_delay)
			message_admins("[span_warning("Storyteller goal failed to fire: ")] [goal.name || goal.id] — rescheduling.")


	// First, clean up completed/failed goals from timeline
	for(var/offset_str in timeline)
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			var/datum/storyteller_goal/clean_goal = entry[ENTRY_GOAL]
			timeline -= offset_str
			if(clean_goal)
				qdel(clean_goal)

	var/pending_count = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	if(pending_count <= 0 && COOLDOWN_FINISHED(src, goal_planing_cooldown))
		if(add_next_goal(ctl, inputs, bal))
			COOLDOWN_START(src, goal_planing_cooldown, planning_cooldown)

	if(COOLDOWN_FINISHED(src, recalculate_cooldown))
		COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
		recalculate_plan(ctl, inputs, bal, FALSE)

	return fired_goals



/datum/storyteller_planner/proc/add_next_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/category = select_goal_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)

	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		derived_tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		derived_tags |= STORY_TAG_DEESCALATION

	var/datum/storyteller_goal/new_goal = build_goal(ctl, inputs, bal, derived_tags, category)
	if(!new_goal)
		return FALSE

	var/next_delay = get_next_goal_delay(new_goal, inputs, ctl)
	var/last_time = get_last_reference_time(ctl)
	var/fire_offset = last_time + next_delay
	if(try_plan_goal(new_goal, fire_offset, TRUE))
		log_storyteller_planner("[ctl.name] added next goal to chain: [new_goal.name || new_goal.id] at offset [fire_offset] (relative delay: [next_delay]).")
		return TRUE
	else
		qdel(new_goal)
		return FALSE



// Recalculate the entire plan: Rebuild timeline from current state.
// Clears invalid/unavailable goals, ensures at least 3 pending events for continuous pacing.
// Dynamically generates chain of events (no global/sub distinction), throttled by recalc_interval.
// Triggers on major shifts (threat/adaptation) or emptiness; analyzes station for fresh tags.
// Ensures storyteller's event chain branches adaptively toward threat escalation.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, force = FALSE)
	var/list/validation_result = validate_and_collect_entries(ctl, inputs, force)
	if(validation_result["pending_count"] == -1)
		adjust_timeline_based_on_mood(ctl)
		return timeline

	var/initial_pending = validation_result["pending_count"]
	rebuild_timeline_from_valid(ctl, validation_result["valid_entries"])
	add_missing_goals(ctl, inputs, bal, validation_result["pending_count"], force)

	var/final_pending = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			final_pending++

	log_storyteller_planner("Storyteller recalculated plan: [final_pending] pending events in chain (added [final_pending - initial_pending], invalids cleared: [validation_result["invalid_goals"]]).")
	return timeline



// Validate entries, collect valid ones, count pending/invalids, decide if rebuild needed
/datum/storyteller_planner/proc/validate_and_collect_entries(datum/storyteller/ctl, datum/storyteller_inputs/inputs, force = FALSE)
	var/pending_count = 0
	var/invalid_goals = 0
	var/list/upcoming_offsets = get_upcoming_goals(length(timeline))
	var/list/valid_entries = list()
	var/list/to_delete = list()

	for(var/offset_str in upcoming_offsets)
		var/list/entry = timeline[offset_str]
		var/datum/storyteller_goal/goal = entry[ENTRY_GOAL]
		if(!goal.is_available(inputs.vault, inputs, ctl) && !SSstorytellers.hard_debug)
			invalid_goals++
			to_delete += offset_str
			qdel(goal)
			continue
		valid_entries += list(entry)
		if(entry[ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	for(var/delete_offset in to_delete)
		cancel_goal(delete_offset)

	var/needs_rebuild = (invalid_goals > 0 || ctl.has_population_spike(15) || ctl.has_tension_spike(15))
	if(!(needs_rebuild && length(timeline) < 3) && !force)
		return list("pending_count" = -1, "valid_entries" = null, "invalid_goals" = 0)

	if(force)
		clear_timeline()
		pending_count = 0
		valid_entries = list()
		invalid_goals += length(to_delete)  // Update if cleared

	return list("pending_count" = pending_count, "valid_entries" = valid_entries, "invalid_goals" = invalid_goals)


// Rebuild timeline from valid entries with adjusted offsets
/datum/storyteller_planner/proc/rebuild_timeline_from_valid(datum/storyteller/ctl, list/valid_entries)
	if(length(valid_entries) <= 0)
		return

	var/list/new_timeline = list()
	var/event_interval = ctl.get_event_interval()
	var/accum_delay = event_interval
	var/last_time = get_last_reference_time(ctl)
	for(var/i = 1 to length(valid_entries))
		var/list/entry = valid_entries[i]
		var/new_offset_num = last_time + accum_delay
		var/new_offset_str = num2text(new_offset_num)
		entry[ENTRY_FIRE_TIME] = new_offset_num
		new_timeline[new_offset_str] = entry
		accum_delay += event_interval * (1 + (ctl.mood.volatility * 0.1))  // Improved: Add slight volatility variance to intervals
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

		reschedule_goal(offset_num, new_offset_num)



// Add missing goals to reach target count
/datum/storyteller_planner/proc/add_missing_goals(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, pending_count, force)
	var/target_add = max(1, STORY_INITIAL_GOALS_COUNT - pending_count)
	var/start_delay = get_next_goal_delay(null, inputs, ctl)  // Base delay for first new goal
	var/event_interval = ctl.get_event_interval()
	var/last_time = get_last_reference_time(ctl)

	var/category = select_goal_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)

	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		derived_tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		derived_tags |= STORY_TAG_DEESCALATION

	for(var/i = 1 to target_add)
		var/datum/storyteller_goal/new_goal = build_goal(ctl, inputs, bal, derived_tags, category)
		if(!new_goal)
			continue

		var/fire_delay = start_delay + (event_interval * (i - 1)) * (1 + (ctl.mood.volatility * 0.05))  // Improved: Add volatility to spread out intervals
		var/fire_offset = last_time + fire_delay
		if(ctl.can_trigger_event_at(fire_offset))
			if(try_plan_goal(new_goal, fire_offset, TRUE))
				pending_count++
			else
				qdel(new_goal)

	// Fallback if still low (add random)
	var/attempts = 0
	while(pending_count < 0)
		if(attempts > 3)
			break
		var/datum/storyteller_goal/fallback = build_goal(ctl, inputs, bal, 0, STORY_GOAL_RANDOM)
		if(fallback)
			var/fire_delay = event_interval * pending_count
			var/fire_offset = last_time + fire_delay
			if(try_plan_goal(fallback, fire_offset))
				pending_count++
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
		add_next_goal(ctl, inputs, bal)
		pending_count += 1

	COOLDOWN_START(src, goal_planing_cooldown, planning_cooldown)
	COOLDOWN_START(src, recalculate_cooldown, recalc_interval)
	return timeline



/datum/storyteller_planner/proc/try_plan_goal(datum/storyteller_goal/goal, time, fixed_time = FALSE)
	if(!goal)
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
				ENTRY_GOAL = goal,
				ENTRY_FIRE_TIME = target_time,
				ENTRY_CATEGORY = goal.category,
				ENTRY_STATUS = STORY_GOAL_PENDING
			)
			if(SSstorytellers.hard_debug && attempts > 0)
				message_admins("Storyteller planner: Resolved timeline collision after [attempts] attempts for goal [goal.id || goal.name] at offset [base_delay].")
			return TRUE

		base_delay += 1 MINUTES
		attempts++
	stack_trace("Storyteller planner: Failed to find free timeline slot after [max_attempts] attempts for goal [goal.id || goal.name].")
	qdel(goal)
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
/datum/storyteller_planner/proc/get_upcoming_goals(limit = length(timeline))
	var/list/upcoming = list()
	var/count = 0
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		if(count >= limit)
			break
		upcoming += offset_str
		count++
	return upcoming

/datum/storyteller_planner/proc/get_closest_goal()
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		var/entry = timeline[offset_str]
		return entry[ENTRY_GOAL]


/datum/storyteller_planner/proc/get_closest_entry()
	for(var/offset_str in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_text_asc)))
		return timeline[offset_str]
	return null


/datum/storyteller_planner/proc/reschedule_goal(old_offset, new_offset)
	var/old_str = time_key(old_offset)
	var/new_str = time_key(new_offset)
	if(!timeline[old_str] || timeline[new_str])
		return FALSE
	timeline[new_str] = timeline[old_str]
	timeline[new_str][ENTRY_FIRE_TIME] = new_offset
	timeline[new_str][ENTRY_STATUS] = STORY_GOAL_PENDING
	timeline -= old_str
	return TRUE

/datum/storyteller_planner/proc/cancel_goal(offset)
	var/offset_str = time_key(offset)
	if(!timeline[offset_str])
		return FALSE
	var/datum/storyteller_goal/goal = timeline[offset_str][ENTRY_GOAL]
	if(goal)
		qdel(goal)
	timeline -= offset_str
	return TRUE


/datum/storyteller_planner/proc/get_goals_in_time(time = 1 MINUTES)
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
	for(var/offset in get_upcoming_goals(length(timeline)))
		cancel_goal(offset)

/datum/storyteller_planner/proc/build_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, tag_filter = 0, category = STORY_GOAL_NEUTRAL)
	var/effective_threat = ctl.get_effective_threat() // was incorrectly get_effective_pace()
	tag_filter = tag_filter || derive_universal_tags(category, ctl, inputs, bal)
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(tag_filter & STORY_TAG_ESCALATION))
		tag_filter |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(tag_filter & STORY_TAG_DEESCALATION))
		tag_filter |= STORY_TAG_DEESCALATION

	var/list/candidates = SSstorytellers.filter_goals(category, tag_filter, null, FALSE)
	if(!candidates.len)
		candidates = SSstorytellers.filter_goals(STORY_GOAL_RANDOM)

	var/datum/storyteller_goal/goal = ctl.mind.select_weighted_goal(ctl, inputs, bal, candidates, ctl.population_factor, tag_filter)
	return goal

/datum/storyteller_planner/proc/derive_universal_tags(category, datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/tags = ctl.mind.tokenize(category, ctl, inputs, bal, ctl.mood)
	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_universal_tags"))
			if(tags & get_valid_bitflags("story_universal_tags")[tag_str])
				string_tags += tag_str + ", "
		message_admins("Storyteller [ctl.name] tokenize station snapshot with next tags: [string_tags]")
	return tags

/datum/storyteller_planner/proc/select_goal_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	return ctl.mind.determine_category(ctl, bal)


/datum/storyteller_planner/proc/get_next_goal_delay(datum/storyteller_goal/goal, datum/storyteller_inputs/inputs, datum/storyteller/ctl)
	var/base_interval = ctl.get_event_interval()
	var/progress_factor = goal ? (1 - goal.get_progress(inputs.vault, inputs, ctl)) : 1.0  // Faster if high progress
	return max(ctl.grace_period, round(base_interval * progress_factor))


/datum/storyteller_planner/proc/get_last_reference_time(datum/storyteller/ctl)
	if(length(timeline))
		return get_closest_offest()
	return max(world.time, ctl.last_event_time)

#undef ENTRY_GOAL
#undef ENTRY_FIRE_TIME
#undef ENTRY_CATEGORY
#undef ENTRY_STATUS
#undef STORY_MOOD_AGGR_SHIFT_FACTOR
