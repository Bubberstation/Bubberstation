/datum/round_event_control
	// Universal id of this event
	var/id
	// A storyteller category of this event
	var/story_category = STORY_GOAL_NEVER
	// Is control of this event was overrided by storyteller
	var/storyteller_override = FALSE
	// A universal tags that helps storyteller to predict event behevour
	var/list/tags = NONE
	// A storyteller weight override for event selection
	var/story_weight = STORY_GOAL_BASE_WEIGHT  // Low weight by default
	// A storyteller priority override for event selection
	var/story_prioty = STORY_GOAL_BASE_PRIORITY
	// Minimum threat level required to select this goal
	var/requierd_threat_level = STORY_GOAL_NO_THREAT
	// Minimum round progress (from 0..1) required to select this goal
	var/required_round_progress = STORY_ROUND_PROGRESSION_START

	VAR_FINAL/additional_arguments = list()
	// Should this event be allowed to select by storyteller
	var/enabled = TRUE

// Is this event avaible for selection on storyteller
/datum/round_event_control/proc/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!can_spawn_event(inputs.player_count(), allow_magic = FALSE))
		return FALSE
	if(occurrences >= max_occurrences)
		return FALSE
	if(get_story_weight(inputs, storyteller) <= 0)
		return FALSE
	if(wizardevent != SSevents.wizardmode)
		return FALSE
	if(inputs.player_count() < min_players)
		return FALSE
	if(holidayID && !check_holidays(holidayID))
		return FALSE
	if(!valid_for_map())
		return FALSE
	if((storyteller.get_effective_threat() < requierd_threat_level) && !has_tag(STORY_TAG_ROUNDSTART))
		return FALSE
	if(storyteller.round_progression < required_round_progress && !has_tag(STORY_TAG_ROUNDSTART))
		return FALSE
	return TRUE

// Return weight of this event for storyteller
/datum/round_event_control/proc/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_weight

// Returns priority of this event for sroyteller. Priority is important for events with same weight
/datum/round_event_control/proc/get_story_priority(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_prioty

// Can storyteller fire this event just right now
/datum/round_event_control/proc/can_fire_now(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE

/datum/round_event_control/proc/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	return

// Run after storyteller plan this event
/datum/round_event_control/proc/on_planned(fire_time)
	return

/datum/round_event_control/proc/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	pre_storyteller_run(inputs, storyteller, threat_points)

	var/used_threath_points = FALSE
	if(typepath) // For events that spawn a round_event datum
		var/datum/round_event/round_event = new typepath(TRUE, src)
		if(SEND_SIGNAL(SSdcs, COMSIG_GLOB_STORYTELLER_RUN_EVENT, round_event) && CANCEL_STORYTELLER_EVENT)
			return FALSE
		round_event.current_players = inputs.player_count()
		round_event.__register()
		if(is_storyteller_event(round_event))
			round_event.__setup_for_storyteller(threat_points, additional_arguments, inputs, storyteller)
			used_threath_points = TRUE
		else
			round_event.setup()
		SSblackbox.record_feedback("tally", "event_ran", 1, "[round_event]")
		testing("[time2text(world.time, "hh:mm:ss", 0)] [round_event.type]")

	occurrences += 1
	triggering = TRUE
	storyteller_override = TRUE

	log_storyteller("[storyteller.name] run event [name]")
	deadchat_broadcast("[storyteller.name] has just fired <b>[name]</b> event [used_threath_points ? "with <b>[threat_points]</b> threat points" : "" ]", message_type=DEADCHAT_ANNOUNCEMENT)
	message_admins("[span_notice("[storyteller.name] fired event:")] [name || id], with [threat_points] threat points")
	return TRUE

/// Check how well event tags match desired tags (works with both bitfield and text tags)
/datum/round_event_control/proc/check_tags(list/story_tags)
	if(!story_tags || !length(story_tags))
		return STORY_TAGS_DIFFERENT
	if(!tags)
		return STORY_TAGS_DIFFERENT

	var/total_tags = length(story_tags)
	var/right_tags = 0

	for(var/tag in story_tags)
		if(has_tag(tag))
			right_tags += 1

	if(right_tags == total_tags)
		return STORY_TAGS_MATCH
	else if(right_tags >= total_tags / 2)
		return STORY_TAGS_MOST_MATCH
	else if(right_tags > 0)
		return STORY_TAGS_SOME_MATCH
	else
		return STORY_TAGS_DIFFERENT

/// Universal tag check - works with both bitfield and text tags
/datum/round_event_control/proc/has_tag(tag)
	if(!tags)
		return FALSE

	// Text tags (new system)
	if(istype(tags, /list))
		return (tag in tags)

	// Bitfield tags (old system)
	if(isnum(tags) && isnum(tag))
		return (tags & tag) != 0

	return FALSE

/// Check if event has any of the provided tags
/datum/round_event_control/proc/has_any_tag(list/tag_list)
	if(!tags || !tag_list || !length(tag_list))
		return FALSE

	for(var/tag in tag_list)
		if(has_tag(tag))
			return TRUE

	return FALSE

/// Check if event has all of the provided tags
/datum/round_event_control/proc/has_all_tags(list/tag_list)
	if(!tags || !tag_list || !length(tag_list))
		return FALSE

	for(var/tag in tag_list)
		if(!has_tag(tag))
			return FALSE

	return TRUE

/datum/round_event_control/proc/get_readable_tags()
	var/list/readable_tags = list()
	for(var/tag in tags)
		var/tag_name = replacetext(tag, "_", " ")
		tag_name = replacetext(tag_name, "STORY", "")
		var/list/words = splittext(tag_name, " ")
		var/final_tag = ""
		for(var/word in words)
			word = LOWER_TEXT(word)
			final_tag += word + " "
		readable_tags += final_tag
	return readable_tags


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
	// Preferred jobs (only these allowed; e.g., list(JOB_CAPTAIN))
	var/preferred_roles = list()
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
	var/can_load_character = FALSE

/datum/round_event_control/antagonist/New()
	. = ..()
	if(max_candidates < min_candidates)
		max_candidates = min_candidates

// Availability with antag checks
/datum/round_event_control/antagonist/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
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
		for(var/mob/dead/observer/ghost_player in GLOB.player_list)
			if(can_be_candidate(ghost_player, inputs, storyteller))
				candidates_list += ghost_player
	return candidates_list

// Candidate eligibility
/datum/round_event_control/antagonist/proc/can_be_candidate(mob/candidate, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!istype(candidate) || !candidate.client || !candidate.key)
		return FALSE
	if(canceled)
		return FALSE
	if(is_banned_from(candidate, role_flag))
		return FALSE
	if(!(role_flag in candidate.client.prefs.be_special))
		return FALSE

	if(isliving(candidate))
		var/mob/living/L = candidate
		if(L.stat == DEAD || L.mind?.has_antag_datum(antag_datum_type))
			return FALSE
		var/datum/job/job = L.mind?.assigned_role
		if(job && (job.type in restricted_roles))
			return FALSE
		if(length(preferred_roles) && !(job?.type in preferred_roles))
			return FALSE

	else if(isobserver(candidate))
		return TRUE
	return TRUE

// Story weight with impact
/datum/round_event_control/antagonist/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/base_weight = ..()
	var/potential_impact = estimate_antag_impact(inputs, storyteller)
	return base_weight * story_weight_multiplier * potential_impact

// Impact estimate
/datum/round_event_control/antagonist/proc/estimate_antag_impact(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/crew_count = inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT) || 0
	return min(crew_count / 20, 2.0)

/datum/round_event_control/antagonist/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	. = ..()
	delayed = TRUE
	candidates = list()
	var/admin_msg = span_danger("[storyteller.name] is spawning [antag_name] event in [admin_cancel_delay / 10] seconds. <a href='byond://?src[REF(src)];cancel_antag=1'>CANCEL</a>")
	message_admins(admin_msg)
	candidates = poll_candidates_for_antag(inputs, storyteller, candidates)
	// Set up admin cancel callback if needed
	if(admin_cancel_delay > 0)
		admin_cancel_callback = CALLBACK(src, PROC_REF(admin_cancel_event), inputs, storyteller)
		addtimer(admin_cancel_callback, admin_cancel_delay)
	after_delay(inputs, storyteller)

/datum/round_event_control/antagonist/proc/after_delay(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	// Clean up admin cancel callback
	if(admin_cancel_callback)
		deltimer(admin_cancel_callback)
		admin_cancel_callback = null

	// Validate candidates
	var/list/valid_candidates = list()
	for(var/mob/candidate in candidates)
		if(candidate && !QDELETED(candidate) && can_be_candidate(candidate, inputs, storyteller))
			valid_candidates += candidate

	candidates = valid_candidates
	candidate_selected = (length(candidates) >= min_candidates)
	delayed = FALSE

/datum/round_event_control/antagonist/proc/admin_cancel_event(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!candidate_selected)
		return

/datum/round_event_control/antagonist/Topic(href, href_list)
	if(href_list["cancel_antag"])
		canceled = TRUE
		message_admins("[key_name_admin(usr)] canceled [antag_name] spawn by [SSstorytellers?.active.name || "storyteller"].")
		return TRUE

/datum/round_event_control/antagonist/proc/poll_candidates_for_antag(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/current_candidates)
	var/list/all_candidates = get_potential_candidates(inputs, storyteller)
	if(!length(all_candidates))
		return list()

	var/list/selected = list()

	// Ghost signup
	if(announce_to_ghosts && ghost_candidates)
		var/ghost_votes = SSpolling.poll_ghost_candidates(
			question = "[storyteller.name] summons a [antag_name]! Volunteer?",
			role = role_flag,
			check_jobban = TRUE,
			role_name_text = antag_name,
			amount_to_pick = max_candidates,
			poll_time = admin_cancel_delay,
			alert_pic = signup_atom_appearance
		)

		if(ghost_votes)
			if(islist(ghost_votes))
				for(var/mob/ghost as anything in ghost_votes)
					if(ghost && (ghost in all_candidates) && can_be_candidate(ghost, inputs, storyteller))
						selected += ghost
			else if(ghost_votes && istype(ghost_votes, /mob))
				var/mob/ghost = ghost_votes
				if((ghost in all_candidates) && can_be_candidate(ghost, inputs, storyteller))
					selected += ghost

	// Crew signup if we need more candidates
	if(crew_candidates && length(selected) < min_candidates)
		var/list/crew_list = list()
		for(var/mob/candidate in all_candidates)
			if(isliving(candidate) && !(candidate in selected))
				crew_list += candidate

		if(length(crew_list))
			var/question = "[storyteller.name] calls to your hidden depths. Become a [antag_name] and twist the tale?"
			var/list/goal_list = list("Yes", "No")
			var/list/crew_votes = SSstorytellers.ask_crew_for_goals(
				question_text = question,
				goal_list = goal_list,
				poll_time = admin_cancel_delay,
				group = crew_list,
				ignore_category = role_flag,
				alert_pic = signup_atom_appearance
			)
			var/yes_crew = crew_votes["Yes"]
			if(islist(yes_crew))
				for(var/mob/living/L in yes_crew)
					if(L && !(L in selected) && can_be_candidate(L, inputs, storyteller))
						selected += L
						log_storyteller("[key_name(L)] accepted [storyteller.name]'s call to become [antag_name].")
			else if(yes_crew && istype(yes_crew, /mob/living))
				var/mob/living/L = yes_crew
				if(!(L in selected) && can_be_candidate(L, inputs, storyteller))
					selected += L
					log_storyteller("[key_name(L)] accepted [storyteller.name]'s call to become [antag_name].")

	// Select final candidates up to max_candidates
	var/list/final_candidates = list()
	var/list/selected_copy = selected.Copy()
	while(length(final_candidates) < max_candidates && length(selected_copy))
		var/mob/picked = pick_n_take(selected_copy)
		if(picked && can_be_candidate(picked, inputs, storyteller) && !(picked in final_candidates))
			final_candidates += picked

	// Ensure we have at least min_candidates if possible
	if(length(final_candidates) < min_candidates && length(selected_copy))
		while(length(final_candidates) < min_candidates && length(selected_copy))
			var/mob/picked = pick_n_take(selected_copy)
			if(picked && can_be_candidate(picked, inputs, storyteller) && !(picked in final_candidates))
				final_candidates += picked

	return final_candidates


/datum/round_event_control/antagonist/proc/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	// Default implementation - create human at safe spawn location
	var/turf/spawn_turf = get_safe_random_station_turf()
	if(!spawn_turf)
		return null
	return new /mob/living/carbon/human(spawn_turf)

/datum/round_event_control/antagonist/valid_for_map()
	return TRUE

/datum/round_event_control/antagonist/proc/generate_objectives(datum/mind/candidate, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(islist(antag_objectives))
		for(var/objective_type in antag_objectives)
			var/datum/objective/objective = new objective_type(candidate)
			candidate.objectives += objective
	else if(antag_objectives)
		call(candidate, antag_objectives)(inputs, storyteller)

// Run: spawn with checks
/datum/round_event_control/antagonist/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	. = ..()
	run_antagonist_event(inputs, storyteller, threat_points)
	return

/datum/round_event_control/antagonist/proc/run_antagonist_event(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	if(!candidate_selected || !length(candidates))
		deadchat_broadcast("[storyteller.name]'s [antag_name] event failed to spawn: no candidates selected", message_type=DEADCHAT_ANNOUNCEMENT)
		message_admins("[storyteller.name]'s [antag_name] event failed to spawn: no valid candidates.")
		return FALSE

	if(canceled)
		deadchat_broadcast("[storyteller.name]'s [antag_name] event was canceled", message_type=DEADCHAT_ANNOUNCEMENT)
		message_admins("[storyteller.name]'s [antag_name] event canceled by admin.")
		canceled = FALSE
		return FALSE

	if(!antag_datum_type)
		stack_trace("[antag_name] event has no antag_datum_type set!")
		message_admins("[storyteller.name]'s [antag_name] event failed: no antag_datum_type configured.")
		return FALSE

	var/spawned_count = 0
	for(var/mob/candidate as anything in candidates)
		if(!candidate || QDELETED(candidate))
			continue
		if(!can_be_candidate(candidate, inputs, storyteller))
			continue

		var/datum/mind/antag_mind = candidate.mind
		if(!antag_mind)
			if(!candidate.key)
				continue
			antag_mind = new /datum/mind(candidate.key)
			antag_mind.current = candidate

		if(!antag_mind.current)
			antag_mind.current = candidate

		antag_mind.active = TRUE

		// Handle observer candidates - create body
		var/mob/living/final_mob = candidate
		if(isobserver(candidate))
			var/mob/living/new_mob = create_ruleset_body(inputs, storyteller)
			if(!new_mob || QDELETED(new_mob))
				log_storyteller("[antag_name] event failed to create body for [key_name(candidate)]")
				continue
			final_mob = new_mob
			antag_mind.transfer_to(final_mob)

		// Add antag datum
		if(!antag_mind.add_antag_datum(antag_datum_type))
			log_storyteller("[antag_name] event failed to add antag datum to [key_name(final_mob)]")
			continue

		// Generate objectives if configured
		if(antag_objectives)
			generate_objectives(antag_mind, inputs, storyteller)

		spawned_antags += antag_mind
		spawned_count++
		log_game("[key_name(final_mob)] became [antag_name] via [storyteller.name]")
		message_admins("[key_name(final_mob)] became [antag_name] via [storyteller.name], [ADMIN_VERBOSEJMP(final_mob)]")


	if(spawned_count == 0)
		deadchat_broadcast("[storyteller.name]'s [antag_name] event failed: no valid candidates spawned", message_type=DEADCHAT_ANNOUNCEMENT)
		message_admins("[storyteller.name]'s [antag_name] event failed: no valid candidates spawned.")
		return FALSE

	// Post-spawn callbacks
	if(post_spawn_callback)
		call(src, post_spawn_callback)(inputs, storyteller, spawned_antags)
	after_antagonist_spawn(inputs, storyteller, spawned_antags)

	return TRUE


/datum/round_event_control/antagonist/proc/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	if(can_load_character)
		for(var/datum/mind/antag_mind in spawned_antags)
			if(antag_mind.current)
				var/datum/action/storyteller_loadprefs/ability = new()
				ability.Grant(antag_mind.current)
	return


/datum/round_event_control/antagonist/from_ghosts
	crew_candidates = FALSE
	ghost_candidates = TRUE
	can_load_character = TRUE
	signup_atom_appearance = /obj/item/paper

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
	if(candidate.is_antag())
		return FALSE
	return TRUE

/datum/action/storyteller_loadprefs
	name = "Load current character"
	desc = "Loads your current preferences on current mob"
	background_icon_state = "bg_agent"
	button_icon_state = "ghost"
	show_to_observers = FALSE

	var/confirm_time = 30 SECONDS

/datum/action/storyteller_loadprefs/Grant(mob/grant_to)
	. = ..()
	to_chat(grant_to, span_notice("Use the [name] action to load your current character preferences."))
	addtimer(CALLBACK(src, PROC_REF(Remove), grant_to), confirm_time)

/datum/action/storyteller_loadprefs/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!clicker.client)
		return
	var/client/client = clicker.client
	if(!ishuman(clicker))
		return
	var/ask = tgui_alert(clicker, "Are you sure you want to load your current character preferences?", "Load current character", list("Yes", "Nevermind"))
	if(ask != "Yes")
		return
	client?.prefs?.apply_prefs_to(clicker)
	SSquirks.OverrideQuirks(clicker, client)
	var/name_ask = tgui_alert(clicker, "Would you like to generate a random name for your character?", "Generate random name", list("Yes", "No"))
	if(name_ask == "Yes")
		clicker.generate_random_mob_name()
	var/msg = span_notice("[key_name(clicker)] has used the [name] ability to apply their character preferences to their current mob. [ADMIN_VERBOSEJMP(clicker)]")
	message_admins(msg)
	Remove(clicker)

