#define ENTRY_GOAL "goal"
#define ENTRY_FIRE_TIME "fire_time"
#define ENTRY_CATEGORY "category"
#define ENTRY_STATUS "status"

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
// No global/sub distinction — all goals uniform in chain; inspired by RimWorld's cycle firing with adaptive rescheduling.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	SHOULD_NOT_OVERRIDE(TRUE)

	// First, clean up completed/failed goals from timeline
	for(var/offset_str in timeline)
		var/list/entry = timeline[offset_str]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			var/datum/storyteller_goal/clean_goal = entry[ENTRY_GOAL]
			timeline -= offset_str
			if(clean_goal)
				qdel(clean_goal)

	var/list/fired_goals = list()
	var/current_time = world.time

	for(var/offset_str in get_upcoming_goals(10))
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
			try_plan_goal(goal, 5 MINUTES * (1 - goal.get_progress(inputs.vault, inputs, ctl)))  // Faster retry if high progress
			continue

		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		// We literally multiply by difficulty_multiplier, it's mean 5x difficulty = 5x points
		if(goal.complete(inputs.vault, inputs, ctl, round(ctl.threat_points * ctl.difficulty_multiplier * 100), inputs.station_value))
			fired_goals += goal
			entry[ENTRY_STATUS] = STORY_GOAL_COMPLETED
			message_admins("[span_notice("Storyteller fired goal: ")] [goal.name || goal.id].")
		else
			entry[ENTRY_STATUS] = STORY_GOAL_PENDING
			timeline -= offset_str
			var/replan_delay = 10 MINUTES * (1 - goal.get_progress(inputs.vault, inputs, ctl)) * ctl.mood.get_event_frequency_multiplier()
			try_plan_goal(goal, replan_delay)
			message_admins("[span_warning("Storyteller goal failed to fire: ")] [goal.name || goal.id] — rescheduling.")


	var/pending_count = 0
	for(var/offset_str in timeline)
		if(timeline[offset_str][ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	if(pending_count < 3 && COOLDOWN_FINISHED(src, goal_planing_cooldown))
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

	var/event_interval = ctl.get_event_interval()
	var/last_offset = get_closest_offest()

	var/fire_offset = last_offset + event_interval
	if(try_plan_goal(new_goal, fire_offset))
		log_storyteller_planner("Storyteller added next goal to chain: [new_goal.name || new_goal.id] at offset [fire_offset].")
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

	var/event_interval = ctl.get_event_interval()
	var/current_time = world.time
	var/base_offset = event_interval
	for(var/delete_offset in to_delete)
		timeline -= delete_offset

	if(length(valid_entries) > 0)
		var/list/new_timeline = list()
		var/accum_offset = base_offset
		for(var/i = 1 to length(valid_entries))
			var/list/entry = valid_entries[i]
			var/new_offset_num = current_time + accum_offset
			var/new_offset_str = num2text(new_offset_num)
			entry[ENTRY_FIRE_TIME] = new_offset_num
			new_timeline[new_offset_str] = entry
			accum_offset += event_interval
		timeline = new_timeline
		pending_count = length(valid_entries)

	var/needs_rebuild = (invalid_goals > 0)
	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 || ctl.adaptation_factor > 0.5)
		needs_rebuild = TRUE

	if(!(needs_rebuild && length(timeline) < 3) && !force)
		return timeline

	if(force)
		clear_timeline()
		pending_count = 0

	var/target_add = max(1, STORY_INITIAL_GOALS_COUNT - pending_count)
	var/start_offset = get_closest_offest()

	var/category = select_goal_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)

	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		derived_tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		derived_tags |= STORY_TAG_DEESCALATION

	for(var/i = 1 to target_add)
		var/datum/storyteller_goal/new_goal = build_goal(ctl, inputs, bal, derived_tags, category)
		if(!new_goal)
			continue

		var/fire_offset = start_offset + event_interval * (i - 1)
		if(ctl.can_trigger_event_at(world.time + fire_offset))
			if(try_plan_goal(new_goal, fire_offset, TRUE))
				pending_count++
			else
				qdel(new_goal)


	// Fallback if still low (add random)
	var/attempts = 0
	while(pending_count < 3)
		if(attempts > 3)
			break
		var/datum/storyteller_goal/fallback = build_goal(ctl, inputs, bal, 0, STORY_GOAL_RANDOM)
		if(fallback && try_plan_goal(fallback, start_offset + (event_interval * pending_count)))
			pending_count++
		attempts++

	log_storyteller_planner("Storyteller recalculated plan: [pending_count] pending events in chain (added [target_add], shifted [invalid_goals]), invalids cleared.")
	return timeline




// Build initial timeline on round start: Generates chain of 3+ events as adaptive threat sequence.
// Analyzes station (bal/inputs) for category/tags, biases by threat/adaptation for escalation start.
// No current_goal dependency; schedules with dynamic offsets based on mood/pace.
// Ensures buffer for branching sub-threats, fallback to random for continuity.
/datum/storyteller_planner/proc/build_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, derived_tags)
	timeline = list()


	var/category = select_goal_category(ctl, bal)
	var/tags = derived_tags || derive_universal_tags(category, ctl, inputs, bal)

	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		tags |= STORY_TAG_DEESCALATION

	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_universal_tags"))
			if(tags & get_valid_bitflags("story_universal_tags")[tag_str])
				string_tags += "[tag_str], "
		message_admins("Storyteller [ctl.name] built initial timeline with category: [bitfield_to_list(category)], tags: [string_tags]")

	var/pending_count = 0
	var/target_count = STORY_INITIAL_GOALS_COUNT
	var/start_offset = ctl.get_next_possible_event_time()
	var/multiply = 0
	for(var/i = 0 to target_count)
		var/datum/storyteller_goal/new_goal = build_goal(ctl, inputs, bal, tags, category)
		if(!new_goal)
			continue

		multiply += 1
		var/fire_offset = start_offset + (ctl.get_event_interval() * multiply)
		if(new_goal.tags & STORY_TAG_ESCALATION)
			fire_offset *= 0.8  // Accelerate 20% for high-threat branches
		else if(new_goal.tags & STORY_TAG_DEESCALATION)
			fire_offset *= 1.2  // Slow for adaptation phases

		if(!ctl.can_trigger_event_at(world.time + fire_offset))
			fire_offset += ctl.grace_period
			if(!ctl.can_trigger_event_at(world.time + fire_offset))
				qdel(new_goal)
				continue

		if(try_plan_goal(new_goal, fire_offset, TRUE))
			pending_count++
		else
			qdel(new_goal)


	var/attempts = 0
	while(pending_count < target_count)
		if(attempts > 3)
			break

		var/fallback_category = STORY_GOAL_RANDOM
		var/datum/storyteller_goal/fallback = build_goal(ctl, inputs, bal, 0, fallback_category)
		if(fallback && try_plan_goal(fallback, ctl.get_event_interval() * pending_count))
			pending_count++
		attempts++

	timeline = sortTim(timeline, /proc/cmp_text_asc)
	log_storyteller_planner("Storyteller built initial timeline: [pending_count] events chained, threat=[effective_threat].")


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
			target_time = fixed_time
		else
			target_time = world.time + base_delay

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
/datum/storyteller_planner/proc/get_upcoming_goals(limit = 5)
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
	var/old_str = "[old_offset]"
	var/new_str = "[new_offset]"
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
		var/str_i = "[i]"
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
	var/category = ctl.mind.determine_category(ctl, bal)

	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_goal_category"))
			if(category & get_valid_bitflags("story_goal_category")[tag_str])
				string_tags += tag_str + ", "
		message_admins("Storyteller [ctl.name] determinete goal category: [string_tags]")
	return category

#undef ENTRY_GOAL
#undef ENTRY_FIRE_TIME
#undef ENTRY_CATEGORY
#undef ENTRY_STATUS
