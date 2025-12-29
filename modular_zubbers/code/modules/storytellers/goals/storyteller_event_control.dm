/datum/round_event_control
	// Universal id of this event
	var/id
	// A storyteller category of this event
	var/story_category =  STORY_GOAL_NEVER
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
	if(!can_spawn_event(inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT)))
		return FALSE
	if(!valid_for_map())
		return FALSE
	if(storyteller.get_effective_threat() < requierd_threat_level)
		return FALSE
	if(storyteller.round_progression < required_round_progress)
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
	candidates = poll_candidates_for_antag(inputs, storyteller, candidates)
	after_delay(inputs, storyteller)

/datum/round_event_control/antagonist/proc/after_delay(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(admin_cancel_callback)
		admin_cancel_callback.Invoke(inputs, storyteller)
		qdel(admin_cancel_callback)
		admin_cancel_callback = null
	if(length(candidates) < min_candidates)
		candidate_selected = FALSE
	else
		candidate_selected = TRUE
	delayed = FALSE

/datum/round_event_control/antagonist/proc/admin_cancel_event(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!candidate_selected)
		return
	// Notify with cancel link
	var/admin_msg = span_danger("[storyteller.name] is spawning [length(candidates)] [antag_name](s). <a href='?src=[REF(src)];cancel_antag=1'>CANCEL</a>")
	message_admins(admin_msg)

/datum/round_event_control/antagonist/Topic(href, href_list)
	if(href_list["cancel_antag"])
		canceled = TRUE
		message_admins("Admin canceled [antag_name] spawn by [SSstorytellers?.active.name || "storyteller"].")
		return TRUE

/datum/round_event_control/antagonist/proc/poll_candidates_for_antag(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/current_candidates)
	var/list/all_candidates = get_potential_candidates(inputs, storyteller)
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
					if(ghost in all_candidates)
						selected += ghost
			else
				if(ghost_votes in all_candidates)
					selected += ghost_votes


	if(crew_candidates && length(selected) < min_candidates)
		var/list/crew_list = all_candidates.Copy() - selected
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
			if(length(yes_crew))
				for(var/mob/living/L in yes_crew)
					if(!(L in selected))
						selected += L
						log_storyteller("[key_name(L)] accepted [storyteller.name]'s call to become [antag_name].")
		else
			selected += yes_crew // The chosen one

	var/list/final_candidates = list()
	while(length(final_candidates) < min_candidates && length(selected))
		var/mob/picked = pick_n_take(selected)
		if(picked && can_be_candidate(picked, inputs, storyteller) && !(picked in final_candidates))
			final_candidates += picked

	if(length(final_candidates) > max_candidates)
		final_candidates.Cut(max_candidates + 1, length(final_candidates) - max_candidates)
	if(!islist(final_candidates))
		return list(final_candidates)
	return final_candidates


/datum/round_event_control/antagonist/proc/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/human

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
		return

	if(canceled)
		deadchat_broadcast("[storyteller.name]'s [antag_name] event was canceled", message_type=DEADCHAT_ANNOUNCEMENT)
		message_admins("[storyteller.name]'s [antag_name] event canceled by admin.")
		return


	for(var/mob/candidate as anything in candidates)
		if(!candidate || !can_be_candidate(candidate, inputs, storyteller))
			continue
		var/datum/mind/antag_mind = candidate.mind || new /datum/mind(candidate.key)
		if(!antag_mind.current)
			antag_mind.current = candidate
		antag_mind.active = TRUE
		// Objectives
		if(isobserver(candidate))
			var/mob/living/new_mob = create_ruleset_body()
			if(new_mob)
				candidate = new_mob
				antag_mind.transfer_to(candidate)
		antag_mind.add_antag_datum(antag_datum_type)
		if(length(antag_objectives))
			generate_objectives(antag_mind, inputs, storyteller)

		spawned_antags += antag_mind
		log_game("[key_name(candidate)] became [antag_name] via [storyteller.name]")


	if(post_spawn_callback)
		call(src, post_spawn_callback)(inputs, storyteller, spawned_antags)
	after_antagonist_spawn(inputs, storyteller, spawned_antags)


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
	var/msg = span_notice("[key_name(clicker)] has used the [name] ability to apply their character preferences to their current mob. [ADMIN_VERBOSEJMP(clicker)]")
	message_admins(msg)
	Remove(clicker)

