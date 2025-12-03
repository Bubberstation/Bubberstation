#define FIRE_PRIORITY_STORYTELLERS 101
#define STORYTELLER_JSON_PATH "config/storyteller/storytellers.json"
#define STORYTELLER_ICONS_PATH "config/storytellers_icons/"
#define STORYTELLER_EVENT_CONFIG_PATH "config/storyteller/events"
#define STORYTELLER_VOTE_CACHE "data/storyteller_vote_cache.json"

SUBSYSTEM_DEF(storytellers)
	name = "AI Storytellers"
	runlevels = RUNLEVEL_GAME

	wait = 10
	var/hard_debug = FALSE
	var/simulation = FALSE
	var/selected_id
	// Difficulty selected on vote
	var/selected_difficulty

	var/current_vote_duration = 60 SECONDS

	VAR_PRIVATE/list/storyteller_vote_cache

	var/last_selected_id = ""

	var/vote_active = FALSE
	/// Active storyteller instance
	var/datum/storyteller/active

	VAR_PRIVATE/list/active_events = list()

	VAR_PRIVATE/list/simulated_atoms = list()

	VAR_PRIVATE/list/processed_metrics = list()

	var/list/storyteller_vote_uis = list()

	var/list/events_by_category = list()
	/// Goal registry built from subtypes
	var/list/events_by_id = list()
	/// Root goals without a valid parent
	var/list/events_roots = list()
	/// Loaded storyteller data from JSON: id -> assoc list(name, desc, mood_type, base_think_delay, etc.)
	var/list/storyteller_data = list()

	/// Config-value: should storyteller overrides dynamic
	var/storyteller_replace_dynamic = TRUE
	/// Config-value: should storyteller helps to antagonist
	var/storyteller_helps_antags = FALSE
	/// Config-value: should storyteller speak with station
	var/storyteller_allows_speech = TRUE

	dependencies = list(
		/datum/controller/subsystem/events,
		/datum/controller/subsystem/processing/station,
		/datum/controller/subsystem/dynamic,
	)

/datum/controller/subsystem/storytellers/Initialize()
	// Load storyteller data from JSON
	load_storyteller_data()
	events_by_id = list()
	events_roots = list()
	events_by_category = list()
	collect_available_goals()
	load_event_config()
	load_vote_cahce()

	// Load config values (assuming global config loader; adjust if needed)
	storyteller_replace_dynamic = config.Get(/datum/config_entry/flag/storyteller_replace_dynamic) || TRUE
	storyteller_helps_antags = config.Get(/datum/config_entry/flag/storyteller_helps_antags) || FALSE
	storyteller_allows_speech = config.Get(/datum/config_entry/flag/storyteller_allows_speech) || TRUE

	RegisterSignal(SSdcs, COMSIG_GLOB_CLIENT_CONNECT, PROC_REF(on_login))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/storytellers/Destroy()
	. = ..()
	qdel(active)
	QDEL_LIST(simulated_atoms)
	QDEL_LIST(active_events)
	QDEL_LIST(processed_metrics)
	QDEL_LIST(storyteller_vote_uis)
	QDEL_LIST(events_by_id)


/// Initializes the active storyteller from selected_id (JSON profile), applying parsed data for adaptive behavior.
/// Delegates creation to create_storyteller_from_data() for modularity; kicks off round analysis/planning.
/// Ensures chain starts with 3+ events, biased by profile (e.g., low tension for chill).
/datum/controller/subsystem/storytellers/proc/load_storyteller()
	if(active)
		message_admins(span_notice("Storyteller already initialized, deleting."))
		qdel(active)

	if(!selected_id || !storyteller_data[selected_id])
		log_storyteller("Failed to load storyteller: invalid ID [selected_id]")
		var/id = pick(storyteller_data)
		message_admins(span_bolditalic("Failed to load storyteller! Selected random storyteller"))
		active = create_storyteller_from_data(id)
		active.difficulty_multiplier = 1.0
		return

	active = create_storyteller_from_data(selected_id)
	active.difficulty_multiplier = clamp(selected_difficulty, 0.3, 5.0)


/datum/controller/subsystem/storytellers/proc/initialize_storyteller()
	if(!active)
		load_storyteller()
	active.initialize()


/datum/controller/subsystem/storytellers/proc/load_storyteller_data()
	storyteller_data = list()

	if(!fexists(STORYTELLER_JSON_PATH))
		log_storyteller("Storyteller JSON not found at [STORYTELLER_JSON_PATH], using defaults.")
		return

	var/json_text = rustg_file_read(STORYTELLER_JSON_PATH)
	var/list/loaded = json_decode(json_text)
	if(!islist(loaded))
		log_storyteller("Invalid JSON in storyteller data: [json_text]")
		return

	for(var/list/entry in loaded)
		var/id = entry["id"]
		if(!id || !istext(id))
			log_storyteller("Skipping invalid entry without valid 'id' string.")
			continue

		var/list/parsed = list()
		parsed["name"] = istext(entry["name"]) ? entry["name"] : "Unnamed Storyteller"
		parsed["desc"] = istext(entry["desc"]) ? entry["desc"] : "No description provided."
		parsed["base_cost_multiplier"] = isnum(entry["base_cost_multiplier"]) ? clamp(entry["base_cost_multiplier"], 0.1, 5.0) : 1.0
		parsed["player_antag_balance"] = isnum(entry["player_antag_balance"]) ? clamp(entry["player_antag_balance"], 0, 100) : STORY_DEFAULT_PLAYER_ANTAG_BALANCE
		parsed["ooc_desc"] = istext(entry["ooc_desc"]) ? entry["ooc_desc"] : "No description provided."
		parsed["ooc_difficulty"] = istext(entry["ooc_difficulty"]) ? entry["ooc_difficulty"] : "Default"
		parsed["portait_path"] = istext(entry["portait_path"]) ? STORYTELLER_ICONS_PATH + entry["portait_path"] : ""
		parsed["logo_path"] = istext(entry["logo_path"]) ? STORYTELLER_ICONS_PATH + entry["logo_path"] : ""

		var/mood_str = entry["mood_type"]
		parsed["mood_path"] = text2path(mood_str)
		if(!ispath(parsed["mood_path"], /datum/storyteller_mood))
			log_storyteller("Invalid mood_type '[mood_str]' for [id], using default.")
			parsed["mood_path"] = /datum/storyteller_mood


		parsed["base_think_delay"] = isnum(entry["base_think_delay"]) ? max(0, entry["base_think_delay"] SECONDS) : STORY_THINK_BASE_DELAY
		parsed["average_event_interval"] = isnum(entry["average_event_interval"]) ? max(0, entry["average_event_interval"] MINUTES) : 15 MINUTES
		parsed["grace_period"] = isnum(entry["grace_period"]) ? max(0, entry["grace_period"] MINUTES) : STORY_GRACE_PERIOD
		parsed["mood_update_interval"] = isnum(entry["mood_update_interval"]) ? max(0, entry["mood_update_interval"] MINUTES) : STORY_RECALC_INTERVAL


		// Non-time numerics
		parsed["recent_damage_threshold"] = isnum(entry["recent_damage_threshold"]) ? max(0, entry["recent_damage_threshold"]) : STORY_RECENT_DAMAGE_THRESHOLD
		parsed["threat_growth_rate"] = isnum(entry["threat_growth_rate"]) ? clamp(entry["threat_growth_rate"], 0, 10) : STORY_THREAT_GROWTH_RATE
		parsed["adaptation_decay_rate"] = isnum(entry["adaptation_decay_rate"]) ? clamp(entry["adaptation_decay_rate"], 0, 1) : STORY_ADAPTATION_DECAY_RATE
		parsed["target_tension"] = isnum(entry["target_tension"]) ? clamp(entry["target_tension"], 0, 100) : STORY_TARGET_TENSION
		parsed["max_threat_scale"] = isnum(entry["max_threat_scale"]) ? max(0, entry["max_threat_scale"]) : STORY_MAX_THREAT_SCALE
		parsed["repetition_penalty"] = isnum(entry["repetition_penalty"]) ? clamp(entry["repetition_penalty"], 0, 2) : STORY_REPETITION_PENALTY

		// Placeholder lists: welcome and round speech (assume list of strings)
		parsed["storyteller_welcome_speech"] = islist(entry["welcome_speech"]) ? entry["welcome_speech"] : list()
		parsed["storyteller_round_speech"] = islist(entry["round_speech"]) ? entry["round_speech"] : list()
		parsed["personality_traits"] = islist(entry["personality_traits"]) ? entry["personality_traits"] : list()
		storyteller_data[id] = parsed

	if(hard_debug)
		log_storyteller("Loaded [length(storyteller_data)] storytellers from JSON.")


/// Creates a new /datum/storyteller instance from JSON data (or default if null), applying all parsed fields.
/// Modular extraction: overrides vars (pacing, threat, adaptation), instantiates mood, sets speech lists.
/// Returns tuned instance for planner chain-building; logs profile for debug, announces welcome speech.
/datum/controller/subsystem/storytellers/proc/create_storyteller_from_data(id, make_new = TRUE)
	var/datum/storyteller/new_st
	if(!make_new && active)
		new_st = active
	else
		new_st = new /datum/storyteller(id)  // Base with ID for logging

	if((!id || !storyteller_data[id]) && make_new)
		// Default fallback
		new_st.name = "Default Storyteller"
		new_st.desc = "A generic storyteller managing station events and goals."
		new_st.mood = new /datum/storyteller_mood()
		if(hard_debug)
			log_storyteller("Created default storyteller.")
		return new_st

	var/list/data = storyteller_data[id]
	new_st.id = id
	new_st.name = data["name"]
	new_st.desc = data["desc"]
	new_st.base_cost_multiplier = data["base_cost_multiplier"]
	new_st.player_antag_balance = data["player_antag_balance"]

	// Core pacing/threat vars
	new_st.base_think_delay = data["base_think_delay"]
	new_st.average_event_interval = data["average_event_interval"]
	new_st.grace_period = data["grace_period"]
	new_st.mood_update_interval = data["mood_update_interval"]
	new_st.recent_damage_threshold = data["recent_damage_threshold"]
	new_st.threat_growth_rate = data["threat_growth_rate"]
	new_st.adaptation_decay_rate = data["adaptation_decay_rate"]
	new_st.target_tension = data["target_tension"]
	new_st.max_threat_scale = data["max_threat_scale"]
	new_st.repetition_penalty = data["repetition_penalty"]
	new_st.ooc_desc = data["ooc_desc"]
	new_st.ooc_difficulty = data["ooc_difficulty"]
	new_st.portrait_path = data["portait_path"]
	new_st.logo_path = data["logo_path"]

	var/mood = data["mood_path"]
	if(ispath(mood, /datum/storyteller_mood))
		new_st.mood = new mood
	var/list/traits = data["personality_traits"]
	if(length(traits))
		for(var/trait in traits)
			ADD_TRAIT(new_st, trait, "storyteller_mind")

	// new_st.storyteller_welcome_speech = data["storyteller_welcome_speech"]
	// new_st.storyteller_round_speech = data["storyteller_round_speech"]

	/* TODO storytellers welcome speach!
	if(length(new_st.storyteller_welcome_speech))
		var/welcome_msg = pick(new_st.storyteller_welcome_speech)
		to_chat(world, span_big(welcome_msg))
		log_storyteller("[new_st.name] welcomes: [welcome_msg]")
	*/
	if(hard_debug)
		log_storyteller("Created [new_st.name] ([id]): pace=[new_st.mood.pace], threat_growth=[new_st.threat_growth_rate], tension=[new_st.target_tension]")

	return new_st


/datum/controller/subsystem/storytellers/proc/set_storyteller(id)
	var/datum/storyteller/new_teller = create_storyteller_from_data(id)
	if(!new_teller)
		return FALSE
	qdel(active)
	active = new_teller
	active.difficulty_multiplier = selected_difficulty
	active.initialize()
	return TRUE

/datum/controller/subsystem/storytellers/fire(resumed)
	if(active)
		INVOKE_ASYNC(active, TYPE_PROC_REF(/datum/storyteller, think))
	for(var/datum/round_event/evt in active_events)
		if(!evt || QDELETED(evt))
			active_events -= evt
			continue
		evt.__process_for_storyteller(world.tick_lag)
	for(var/datum/storyteller_analyzer/AN in processed_metrics)
		if(!AN || QDELETED(AN))
			processed_metrics -= AN
			continue
		AN.process(world.tick_lag)
	for(var/datum/storyteller_poll/running_poll as anything in currently_polling)
		if(running_poll.time_left() <= 0)
			polling_finished(running_poll)

/datum/controller/subsystem/storytellers/proc/setup_game()

#ifdef UNIT_TESTS //Storyteller thinking disabled during testing, it's handle by unit test
	return
#endif

	disable_dynamic()
	disable_ICES()

	if(vote_active)
		end_vote()

	return TRUE

/datum/controller/subsystem/storytellers/proc/post_setup()

#ifdef UNIT_TESTS //Storyteller thinking disabled during testing, it's handle by unit test
	return
#endif

	initialize_storyteller()

/datum/controller/subsystem/storytellers/proc/disable_dynamic()
	if(!storyteller_replace_dynamic)
		return
	SSdynamic.flags = SS_NO_FIRE
	SSdynamic.antag_events_enabled = FALSE
	// TODO: add ability to completely disable dynamic by adding all rulesets to admin-disabled
	message_admins(span_bolditalic("Dynamic was disabled by Storyteller!"))

/datum/controller/subsystem/storytellers/proc/disable_ICES()
	SSevents.flags = SS_NO_FIRE
	message_admins(span_bolditalic("ICES and random events were disabled by Storyteller"))

/datum/controller/subsystem/storytellers/proc/active_goal_is_achieved(list/context)
	return FALSE  // Stub: removed active_goal, as per chain refactor


/datum/controller/subsystem/storytellers/proc/collect_available_goals()
	events_by_id = list()
	events_by_category = list()
	events_roots = list()

	// Initialize categories as empty lists with bitflags as keys
	events_by_category["GOAL_RANDOM"] = list()
	events_by_category["GOAL_GOOD"] = list()
	events_by_category["GOAL_BAD"] = list()
	events_by_category["GOAL_NEUTRAL"] = list()
	events_by_category["GOAL_UNCATEGORIZED"] = list()
	events_by_category["GOAL_ANTAGONIST"] = list()

	for(var/control_type in typesof(/datum/round_event_control))
		var/datum/round_event_control/event_control = new control_type()

		if(!event_control.valid_for_map())
			continue // Skip invalid for map
		if(event_control.tags & STORY_GOAL_NEVER)
			continue // Skip never goals
		if(istype(event_control, /datum/round_event_control/wizard))
			continue
		if(!event_control.id)
			stack_trace("Storyteller event control [event_control.name] has no ID using name instead.")
			event_control.id = event_control.name
		if(events_by_id[event_control.id])  // Prevent duplicates
			stack_trace("Duplicate event control ID [event_control.id] for [event_control.name], skipping.")
			continue
		events_by_id[event_control.id] = event_control

		if(!event_control.story_category)  // Use story_category instead of category
			stack_trace("Storyteller event control [event_control.id] has no story_category, assigning random.")
			event_control.story_category = STORY_GOAL_RANDOM

		// Assign to all matching categories (bitflags allow multiple)
		if(event_control.story_category & STORY_GOAL_RANDOM)
			events_by_category["GOAL_RANDOM"] += event_control
		else if(event_control.story_category & STORY_GOAL_GOOD)
			events_by_category["GOAL_GOOD"] += event_control
		else if(event_control.story_category & STORY_GOAL_BAD)
			events_by_category["GOAL_BAD"] += event_control
		else if(event_control.story_category & STORY_GOAL_NEUTRAL)
			events_by_category["GOAL_NEUTRAL"] += event_control
		else if(event_control.story_category & STORY_GOAL_ANTAGONIST)
			events_by_category["GOAL_ANTAGONIST"] += event_control


	// Collect roots: no parent or invalid parent (round_event_control doesn't use parent_id, so skip this)
	for(var/id in events_by_id)
		var/datum/round_event_control/event_control = events_by_id[id]
		// round_event_control doesn't have parent_id, so all are roots
		events_roots += event_control

	if(hard_debug)
		log_storyteller("Collected [length(events_by_id)] goals, [length(events_roots)] roots.")


/datum/controller/subsystem/storytellers/proc/load_event_config()
	var/list/json_files = list()
	var/list/loaded = list()

	for(var/file in flist(STORYTELLER_EVENT_CONFIG_PATH))
		if(file == "." || file == "..")
			continue
		if(!findtext(file, ".json"))
			continue
		json_files += file

	for(var/json_file in json_files)
		var/json_text = rustg_file_read("[STORYTELLER_EVENT_CONFIG_PATH][json_file]")
		var/list/current_loaded = json_decode(json_text)
		if(!islist(current_loaded))
			stack_trace("Invalid JSON in storyteller event config: [json_file]")
			continue
		loaded |= current_loaded

	for(var/id in loaded)
		var/datum/round_event_control/event = events_by_id[id]
		if(!event)
			stack_trace("Invalid event ID [id] in storyteller event config, skipping.")
			continue
		for(var/event_variable in loaded[id])
			if(!(event_variable in event.vars))
				stack_trace("Invalid event configuration variable [event_variable] in variable changes for [id].")
				continue
			if(event_variable == "id")
				stack_trace("Cannot override event ID in configuration for [id], skipping.")
				continue
			if(event_variable == "story_category")
				stack_trace("Cannot override event story_category in configuration for [id], skipping.")
				continue
			if(event_variable == "tags")
				stack_trace("Cannot override event tags in configuration for [id], skipping.")
				continue
			event.vars[event_variable] = loaded[id][event_variable]


/datum/controller/subsystem/storytellers/proc/load_vote_cahce()
	if(rustg_file_exists(STORYTELLER_VOTE_CACHE))
		storyteller_vote_cache = json_decode(file2text(STORYTELLER_VOTE_CACHE))
		if(length(storyteller_vote_cache))
			last_selected_id = storyteller_vote_cache[1]
	else
		storyteller_vote_cache = list()

/datum/controller/subsystem/storytellers/proc/write_cache()
	storyteller_vote_cache = list()
	storyteller_vote_cache += active ? active.id : "n/a"
	rustg_file_write(json_encode(storyteller_vote_cache), STORYTELLER_VOTE_CACHE)

/datum/controller/subsystem/storytellers/proc/filter_goals(category = null, required_tags = null, subtype = null, all_tags_required = FALSE, include_children = TRUE)
	var/list/result = list()

	var/list/goals_to_check = list()
	var/category_str
	if(category)
		if(category & STORY_GOAL_RANDOM)
			category_str = "GOAL_RANDOM"
		else if(category & STORY_GOAL_GOOD)
			category_str = "GOAL_GOOD"
		else if(category & STORY_GOAL_BAD)
			category_str = "GOAL_BAD"
		else if(category & STORY_GOAL_NEUTRAL)
			category_str = "GOAL_NEUTRAL"
		else if(category & STORY_GOAL_ANTAGONIST)
			category_str = "GOAL_ANTAGONIST"
		else
			category_str = "GOAL_RANDOM"
	else
		category_str = "GOAL_RANDOM"  // Default to uncategorized if none specified

	goals_to_check = _list_copy(events_by_category[category_str])
	if(!goals_to_check)
		return list()

	for(var/datum/round_event_control/event_control in goals_to_check)
		if(!event_control.enabled)
			continue
		if(subtype && !istype(event_control, subtype))
			continue
		if(required_tags)
			if(!event_control.tags)
				continue
			if(all_tags_required)
				if((event_control.tags & required_tags) != required_tags)
					continue
			else
				if(!(event_control.tags & required_tags))
					continue

		// round_event_control doesn't have parent_id, so skip parent check

		// Additional filter for global flag if set in category
		if(category & STORY_GOAL_GLOBAL && !(event_control.story_category & STORY_GOAL_GLOBAL))
			continue

		result += event_control
	return result


/// Convenience method to get root goals by category, tags, and subtype
/datum/controller/subsystem/storytellers/proc/get_root_goals(category = null, required_tags = null, subtype = null, all_tags_required = FALSE)
	return filter_goals(category, required_tags, subtype, all_tags_required, FALSE)

/// Convenience method to get goals by category and subtype
/datum/controller/subsystem/storytellers/proc/get_events_by_category_and_subtype(category, subtype)
	return filter_goals(category, null, subtype, FALSE, TRUE)

/// Convenience method to get goals by tags
/datum/controller/subsystem/storytellers/proc/get_goals_by_tags(required_tags, all_tags_required = FALSE)
	return filter_goals(null, required_tags, null, all_tags_required, TRUE)

/datum/controller/subsystem/storytellers/proc/register_active_event(datum/round_event/E)
	if(!E || QDELETED(E))
		return
	active_events += E

/datum/controller/subsystem/storytellers/proc/unregister_active_event(datum/round_event/E)
	if(!E || QDELETED(E) || !(E in active_events))
		return
	active_events -= E

/datum/controller/subsystem/storytellers/proc/register_analyzer(datum/storyteller_analyzer/A)
	if(!A || QDELETED(A))
		return
	processed_metrics += A

/datum/controller/subsystem/storytellers/proc/unregister_analyzer(datum/storyteller_analyzer/A)
	if(!A || QDELETED(A))
		return
	processed_metrics -= A


#define STORY_TRAIT_IM_SIMULATION "simulation_mob"

ADMIN_VERB(storyteller_simulation, R_ADMIN, "Storyteller - Simulation", "Simulate round", ADMIN_CATEGORY_STORYTELLER)
	var/ask = tgui_alert(usr, "Do you want to perform simulation?", "Storyteller - simulation", list("Process", "Nevermind"))
	if(ask != "Process")
		return


	var/list/variants = list(
		"simulate manifest",
		"simulate antagonist",
		"simulate influence",
		"abort",
	)
	var/chosen = tgui_input_list(usr, "Pick variant of simulation.", "Storyteller - simulation", variants)
	if(chosen == "abort")
		return

	SSstorytellers.hard_debug = TRUE
	SSstorytellers.simulation = TRUE

	message_admins("[key_name_admin(user)]is starting storyteller round simulation with: [chosen] mode.")
	if(chosen == "simulate manifest")
		var/gear_ask = tgui_alert(usr, "Should we add some gear to crew?", "Storyteller - simulation", list("Yes", "Nevermind"))
		SSstorytellers.simulate_crew_activity(gear_ask == "Yes")

/datum/controller/subsystem/storytellers/proc/generate_random_key(length = 16)
	var/static/list/to_pick = list(
		"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
		"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
	)
	var/key = ""
	for(var/i = 0 to length)
		key += pick(to_pick)
	key += num2text(rand(16, 1024))
	return key


/datum/controller/subsystem/storytellers/proc/simulate_crew_activity(add_gear)
	if(!usr)
		return
	var/obj/effect/landmark/observer_start/observer_point = locate(/obj/effect/landmark/observer_start) in GLOB.landmarks_list
	var/turf/destination = get_turf(observer_point)
	if(!destination)
		to_chat(usr, "Failed to find the observer spawn to send the dummies.")
		return

	var/list/possible_species = list(
		/datum/species/human = 70,
		/datum/species/teshari = 20,
		/datum/species/moth = 10,
	)
	var/number_made = 0
	for(var/rank in SSjob.name_occupations)
		var/datum/job/job = SSjob.get_job(rank)
		if(!(job.job_flags & JOB_CREW_MEMBER))
			continue

		var/mob/dead/new_player/new_guy = new()
		new_guy.mind_initialize()
		new_guy.mind.name = "[rank] Dummy"

		if(!SSjob.assign_role(new_guy, job, do_eligibility_checks = FALSE))
			qdel(new_guy)
			to_chat(usr, "[rank] wasn't able to be spawned.")
			continue
		var/mob/living/carbon/human/character = new(destination)
		character.name = new_guy.mind.name
		new_guy.mind.transfer_to(character)
		qdel(new_guy)

		character.set_species(pick_weight(possible_species))
		SSjob.equip_rank(character, job)
		job.after_latejoin_spawn(character)

		SSticker.minds += character.mind
		if(ishuman(character))
			GLOB.manifest.inject(character)

		number_made++
		CHECK_TICK
		LAZYADD(simulated_atoms, WEAKREF(character))

	to_chat(usr, "[number_made] crewmembers have been created.")


#undef STORY_TRAIT_IM_SIMULATION


/datum/config_entry/flag/storyteller_replace_dynamic
	default = TRUE

/datum/config_entry/flag/storyteller_helps_antags
	default = TRUE

/datum/config_entry/flag/storyteller_allows_speech
	default = TRUE

#undef FIRE_PRIORITY_STORYTELLERS
#undef STORYTELLER_JSON_PATH
#undef STORYTELLER_ICONS_PATH
#undef STORYTELLER_EVENT_CONFIG_PATH
#undef STORYTELLER_VOTE_CACHE
