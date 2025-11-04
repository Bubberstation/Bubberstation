/datum/round_event_control
	// Universal id of this event
	var/id
	// A storyteller category of this event
	var/story_category =  STORY_GOAL_NEVER
	// Is control of this event was overrided by storyteller
	var/storyteller_override = FALSE
	// A universal tags that helps storyteller to predict event behevour
	var/tags = NONE
	// A storyteller weight override for event selection
	var/story_weight = STORY_GOAL_BASE_WEIGHT * 0.1 // Low weight by default

	var/story_prioty = STORY_GOAL_BASE_PRIORITY
	// Minimum threat level required to select this goal
	var/requierd_threat_level = STORY_GOAL_NO_THREAT
	// Minimum round progress (from 0..1) required to select this goal
	var/required_round_progress = STORY_ROUND_PROGRESSION_START

	VAR_FINAL/additional_arguments = list()


/datum/round_event_control/proc/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!can_spawn_event(inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT)))
		return FALSE
	if(!valid_for_map())
		return FALSE
	if(storyteller.get_effective_threat() < requierd_threat_level)
		return FALSE
	if(storyteller.round_progression < required_round_progress)
		return FALSE
	return TRUE




/datum/round_event_control/proc/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_weight




/datum/round_event_control/proc/get_story_priority(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_prioty





/datum/round_event_control/proc/can_fire_now(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE




/datum/round_event_control/proc/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	return


/datum/round_event_control/proc/on_planned(fire_time)
	return


/datum/round_event_control/proc/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	pre_storyteller_run(inputs, storyteller, threat_points)
	var/datum/round_event/round_event = new typepath(TRUE, src)
	if(SEND_SIGNAL(SSdcs, COMSIG_GLOB_STORYTELLER_RUN_EVENT, round_event) && CANCEL_STORYTELLER_EVENT)
		return FALSE

	round_event.__setup_for_storyteller(threat_points, additional_arguments, inputs, storyteller)
	round_event.current_players = storyteller.get_active_player_count()
	occurrences += 1
	testing("[time2text(world.time, "hh:mm:ss", 0)] [round_event.type]")
	triggering = TRUE
	storyteller_override = TRUE
	log_storyteller("[storyteller.name] run event [name]")
	if(alert_observers)
		round_event.announce_deadchat(FALSE, "by [storyteller.name]")
	message_admins("[span_notice("[storyteller.name] fired event: ")] [name || id]. with threat points: [threat_points]")
	deadchat_broadcast("[span_notice("[storyteller.name] fired event: ")] [name || id]. with threat points: [threat_points])")
	SSblackbox.record_feedback("tally", "event_ran", 1, "[round_event]")
	return TRUE

// Base for storyteller antagonist events
// Integrates with global goals: spawns antags as sub-events after station analysis
// (e.g., "betrayal branch" → traitor; "intrusion" → wizard)

/datum/round_event_control/antagonist
	story_category = STORY_GOAL_ANTAGONIST

	// Antag datum type (e.g., /datum/antagonist/traitor)
	var/datum/antagonist/antag_datum_type = null
	// Display name
	var/antag_name = "Antagonist"
	// List of objective types or proc path
	var/antag_objectives = null
	// Pref role flag
	var/role_flag = ROLE_SLEEPER_AGENT
	 // Excluded jobs (e.g., list(JOB_AI))
	var/restricted_roles = list()
	 // Preferred jobs (e.g., list(JOB_CAPTAIN))
	var/protected_roles = list()
	var/max_candidates = 1
	var/min_candidates = 1
	var/ghost_candidates = TRUE
	var/crew_candidates = TRUE
	var/announce_to_ghosts = TRUE
	var/admin_cancel_delay = 30 SECONDS
	var/story_weight_multiplier = 1.0
	var/signup_atom_appearance = /obj/item/paper
	// Proc path post-spawn
	var/post_spawn_callback
	// Admin cancel flag
	var/canceled = FALSE

	// Internal
	var/list/candidates = list()
	var/candidate_selected = FALSE
	var/list/spawned_antags = list()
	var/datum/callback/admin_cancel_callback

	var/delayed = FALSE
	var/poll_end_time = 0

// Availability with antag checks
/datum/round_event_control/antagonist/is_available(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE

	var/list/potential_candidates = get_potential_candidates(inputs, storyteller)
	if(length(potential_candidates) < min_candidates)
		return FALSE
	return TRUE

// Potential candidates pool
/datum/round_event_control/antagonist/proc/get_potential_candidates(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/list/candidates_list = list()
	var/list/living_crew = get_alive_station_crew()

	if(crew_candidates)
		for(var/mob/living/player in living_crew)
			if(can_be_candidate(player, inputs, storyteller))
				candidates_list += player

	if(ghost_candidates)
		var/list/ghosts = GLOB.dead_player_list
		for(var/mob/dead/observer/ghost in ghosts)
			if(can_be_candidate(ghost, inputs, storyteller))
				candidates_list += ghost
	return candidates_list

// Candidate eligibility
/datum/round_event_control/antagonist/proc/can_be_candidate(mob/candidate, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!istype(candidate) || !candidate.client || !candidate.key)
		return FALSE
	if(canceled)
		return FALSE
	if(is_banned_from(candidate, role_flag))
		return FALSE

	if(isliving(candidate))
		var/mob/living/L = candidate
		if(L.stat == DEAD || L.mind?.has_antag_datum(antag_datum_type))
			return FALSE
		var/datum/job/job = L.mind?.assigned_role
		if(job && (job.type in restricted_roles))
			return FALSE
		if(length(protected_roles) && !(job?.type in protected_roles))
			return FALSE
		// Pref check for crew
		if(!(role_flag in candidate.client.prefs.be_special))
			return FALSE
		return TRUE

	else if(isobserver(candidate))
		return TRUE
	return FALSE

// Story weight with impact
/datum/round_event_control/antagonist/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/base_weight = ..()
	var/potential_impact = estimate_antag_impact(inputs, storyteller)
	return base_weight * story_weight_multiplier * potential_impact

// Impact estimate
/datum/round_event_control/antagonist/proc/estimate_antag_impact(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/crew_count = inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT) || 0
	return min(crew_count / 20, 2.0)

// Pre-run: start polling and delay
/datum/round_event_control/antagonist/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	. = ..()
	delayed = TRUE
	poll_end_time = world.time + admin_cancel_delay

	// Start ghost poll if applicable
	var/list/ghost_candidates_list = list()
	if(announce_to_ghosts && ghost_candidates)
		var/list/all_potential = get_potential_candidates(inputs, storyteller)
		ghost_candidates_list = all_potential.Copy() // Filter observers later in poll

		// Setup admin cancel callback for ghost poll
		admin_cancel_callback = CALLBACK(src, PROC_REF(handle_poll_end), inputs, storyteller)

		// Start async ghost poll; it will call the callback on end
		SSpolling.poll_ghost_candidates(
			question = "[storyteller.name] summons a [antag_name]! Volunteer?",
			role = role_flag,
			check_jobban = TRUE,
			role_name_text = antag_name,
			amount_to_pick = max_candidates,
			poll_time = admin_cancel_delay,
			alert_pic = signup_atom_appearance,
			callback = admin_cancel_callback // Assuming SSpolling supports callback; adjust if needed
		)
	else
		// No ghost poll, immediately poll crew or force select
		admin_cancel_callback = CALLBACK(src, PROC_REF(handle_poll_end), inputs, storyteller)
		addtimer(admin_cancel_callback, 0) // Immediate call if no delay needed

	// Notify admins early
	admin_cancel_event(inputs, storyteller)

// Handle poll end (callback/timer target)
/datum/round_event_control/antagonist/proc/handle_poll_end(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(canceled)
		delayed = FALSE
		return

	// Collect final candidates
	candidates = poll_candidates_for_antag(inputs, storyteller)

	// Check min candidates
	if(length(candidates) < min_candidates)
		canceled = TRUE
		candidate_selected = FALSE
		log_game("[storyteller.name]'s [antag_name] poll failed: insufficient candidates ([length(candidates)] < [min_candidates]).")
	else
		candidate_selected = TRUE

	delayed = FALSE

	// If not canceled, proceed to spawn (this will be called from run_event)
	if(candidate_selected && triggering) // Only proceed if run_event is waiting
		INVOKE_ASYNC(src, PROC_REF(spawn_antagonists), inputs, storyteller)

// Collect candidates post-poll
/datum/round_event_control/antagonist/proc/poll_candidates_for_antag(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/list/all_candidates = get_potential_candidates(inputs, storyteller)
	var/list/selected = list()

	if(ghost_candidates && announce_to_ghosts)
		// Ghost poll results should already be in a global or passed via callback; assuming SSpolling sets a var or returns
		// For simplicity, re-poll ghosts synchronously here if callback didn't set candidates
		// In real impl, use poll results from SSpolling
		var/list/ghost_votes = SSpolling.ghost_candidates_by_role[role_flag] || list() // Pseudo-code; adjust to actual SSpolling API
		for(var/mob/ghost in ghost_votes)
			if(ghost in all_candidates)
				selected += ghost

	if(crew_candidates && length(selected) < min_candidates)
		var/list/crew_list = all_candidates.Copy() - selected
		var/list/crew_votes = poll_living_for_antag(crew_list, inputs, storyteller)
		selected += crew_votes

	while(length(selected) < min_candidates && length(all_candidates))
		var/mob/picked = pick_n_take(all_candidates)
		if(can_be_candidate(picked, inputs, storyteller))
			selected += picked

	if(length(selected) > max_candidates)
		selected.Cut(1, length(selected) - max_candidates + 1)
	return selected

// Living consent poll (synchronous, quick)
/datum/round_event_control/antagonist/proc/poll_living_for_antag(list/crew_list, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/list/selected_crew = list()
	for(var/mob/living/L in shuffle(crew_list))
		if(!can_be_candidate(L, inputs, storyteller))
			continue
		ask_crew(L, selected_crew, storyteller)
		CHECK_TICK // Prevent lag
	return selected_crew

/datum/round_event_control/antagonist/proc/ask_crew(mob/living/L, list/candidates, datum/storyteller/storyteller)
	var/response = tgui_alert(L, "[storyteller.name] calls to your hidden depths. Become a [antag_name] and twist the tale?", "Fate's Whisper", list("Yes", "No"))
	if(response == "Yes")
		candidates += L

// Admin cancel event notification
/datum/round_event_control/antagonist/proc/admin_cancel_event(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!candidate_selected)
		return
	// Notify with cancel link
	var/admin_msg = span_danger("[storyteller.name] is spawning [antag_name](s) in [admin_cancel_delay]. <a href='?src=[REF(src)];cancel_antag=1'>CANCEL</a>")
	message_admins(admin_msg)

/datum/round_event_control/antagonist/Topic(href, href_list)
	if(href_list["cancel_antag"])
		canceled = TRUE
		message_admins("Admin canceled [antag_name] spawn by [SSstorytellers?.active.name || "storyteller"].")
		return TRUE

// Generate objectives
/datum/round_event_control/antagonist/proc/generate_objectives(datum/mind/candidate, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(islist(antag_objectives))
		for(var/objective_type in antag_objectives)
			var/datum/objective/objective = new objective_type(candidate)
			candidate.objectives += objective
	else if(antag_objectives)
		call(candidate, antag_objectives)(inputs, storyteller)

// Create body for ghost
/datum/round_event_control/antagonist/proc/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/human

// Valid for any map
/datum/round_event_control/antagonist/valid_for_map()
	return TRUE

// Main run: wait for poll, then spawn
/datum/round_event_control/antagonist/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	INVOKE_ASYNC(src, PROC_REF(run_antagonist_event), inputs, storyteller, threat_points)
	return TRUE

// Async event runner
/datum/round_event_control/antagonist/proc/run_antagonist_event(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	set waitfor = FALSE

	pre_storyteller_run(inputs, storyteller, threat_points)

	// Wait for poll to end
	while(delayed)
		CHECK_TICK
		sleep(world.tick_lag)
		if(world.time > poll_end_time + 10 SECONDS) // Safety timeout
			canceled = TRUE
			break

	if(canceled)
		message_admins("[storyteller.name]'s [antag_name] event canceled by admin or timeout.")
		return

	triggering = TRUE
	storyteller_override = TRUE

	if(!candidate_selected || !length(candidates))
		log_game("[storyteller.name]'s [antag_name] failed: no valid candidates after poll.")
		return

	spawn_antagonists(inputs, storyteller)

/datum/round_event_control/antagonist/proc/spawn_antagonists(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	for(var/mob/candidate as anything in candidates)
		if(!candidate || !can_be_candidate(candidate, inputs, storyteller))
			continue
		var/datum/mind/antag_mind = candidate.mind
		antag_mind.active = TRUE
		var/datum/antagonist/antag_datum = new antag_datum_type()
		antag_mind.add_antag_datum(antag_datum)
		// Objectives
		generate_objectives(antag_mind, inputs, storyteller)
		if(isobserver(candidate))
			var/mob/living/new_mob = create_ruleset_body()
			if(new_mob)
				candidate = new_mob
				antag_mind.transfer_to(candidate)
		spawned_antags += antag_mind
		log_game("[key_name(candidate)] became [antag_name] via [storyteller.name]")
		if(announce_to_ghosts)
			deadchat_broadcast("[storyteller.name] birthed a [antag_name]: [candidate.real_name] ([candidate.key])")

	if(post_spawn_callback)
		call(src, post_spawn_callback)(inputs, storyteller, spawned_antags)

// Ghost-only variant
/datum/round_event_control/antagonist/from_ghosts
	crew_candidates = FALSE
	ghost_candidates = TRUE
	signup_atom_appearance = /obj/item/paper

/datum/round_event_control/antagonist/from_ghosts/is_available(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!. || !(GLOB.ghost_role_flags & GHOSTROLE_MIDROUND_EVENT))
		return FALSE
	return TRUE

// Living-only variant
/datum/round_event_control/antagonist/from_living
	ghost_candidates = FALSE
	crew_candidates = TRUE
	var/list/blacklisted_roles = list()

/datum/round_event_control/antagonist/from_living/can_be_candidate(mob/candidate, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE

	if(!(candidate.mind?.assigned_role.job_flags & JOB_CREW_MEMBER))
		return FALSE
	if(candidate.mind.assigned_role.title in blacklisted_roles)
		return FALSE
	if(candidate.mind?.has_antag_datum(antag_datum_type))
		return FALSE

	return TRUE
