#define FIRE_PRIORITY_STORYTELLERS 101
#define STORYTELLER_JSON_PATH "config/storytellers.json"  // Define for JSON path


SUBSYSTEM_DEF(storytellers)
	name = "AI Storytellers"
	runlevels = RUNLEVEL_GAME
	wait = 1 SECONDS
	priority = FIRE_PRIORITY_STORYTELLERS

	var/hard_debug = FALSE
	var/simulation = FALSE

	var/selected_id
	// Difficulty selected on vote
	var/selected_difficulty

	var/current_vote_duration = 60 SECONDS

	var/vote_active = FALSE
	/// Active storyteller instance
	var/datum/storyteller/active

	VAR_PRIVATE/list/active_events = list()

	VAR_PRIVATE/list/simulated_atoms = list()

	var/list/storyteller_vote_uis = list()

	// The current station value
	var/station_value = 0

	var/list/goals_by_category = list()
	/// Goal registry built from subtypes
	var/list/goals_by_id = list()
	/// Root goals without a valid parent
	var/list/goal_roots = list()

	/// Loaded storyteller data from JSON: id -> assoc list(name, desc, mood_type, base_think_delay, etc.)
	var/list/storyteller_data = list()

	// Config vars (read from config/storyteller.txt or similar; assume /datum/controller/configuration loads them)
	var/storyteller_replace_dynamic = TRUE
	var/storyteller_helps_antags = FALSE
	var/storyteller_allows_speech = TRUE



/datum/controller/subsystem/storytellers/Initialize()
	. = ..()
	// Load storyteller data from JSON
	load_storyteller_data()

	goals_by_id = list()
	goal_roots = list()
	goals_by_category = list()
	collect_available_goals()

	// Load config values (assuming global config loader; adjust if needed)
	storyteller_replace_dynamic = config.Get(/datum/config_entry/flag/storyteller_replace_dynamic) || TRUE
	storyteller_helps_antags = config.Get(/datum/config_entry/flag/storyteller_helps_antags) || FALSE
	storyteller_allows_speech = config.Get(/datum/config_entry/flag/storyteller_allows_speech) || TRUE

	RegisterSignal(src, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_login))
	return SS_INIT_SUCCESS

/// Initializes the active storyteller from selected_id (JSON profile), applying parsed data for adaptive behavior.
/// Delegates creation to create_storyteller_from_data() for modularity; kicks off round analysis/planning.
/// Ensures chain starts with 3+ events, biased by profile (e.g., low tension for chill).
/datum/controller/subsystem/storytellers/proc/initialize_storyteller()
	if(active)
		message_admins(span_notice("Storyteller already initialized, deleting."))
		qdel(active)

	if(!selected_id || !storyteller_data[selected_id])
		log_storyteller("Failed to Initialize storyteller: invalid ID [selected_id]")
		var/id = pick(storyteller_data)
		message_admins(span_bolditalic("Failed to Initialize storyteller! Selected random storyteller"))
		active = create_storyteller_from_data(id)
		active.difficulty_multiplier = 1.0
		active.initialize_round()
		return

	active = create_storyteller_from_data(selected_id)
	active.difficulty_multiplier = clamp(selected_difficulty, 0.3, 5.0)
	active.initialize_round()


/datum/controller/subsystem/storytellers/proc/load_storyteller_data()
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

		var/mood_str = entry["mood_type"]
		parsed["mood_path"] = text2path(mood_str)
		if(!ispath(parsed["mood_path"], /datum/storyteller_mood))
			log_storyteller("Invalid mood_type '[mood_str]' for [id], using default.")
			parsed["mood_path"] = /datum/storyteller_mood


		parsed["base_think_delay"] = isnum(entry["base_think_delay"]) ? max(0, entry["base_think_delay"] SECONDS) : STORY_THINK_BASE_DELAY
		parsed["min_event_interval"] = isnum(entry["min_event_interval"]) ? max(0, entry["min_event_interval"] MINUTES) : STORY_MIN_EVENT_INTERVAL
		parsed["max_event_interval"] = isnum(entry["max_event_interval"]) ? max(parsed["min_event_interval"], entry["max_event_interval"] MINUTES) : STORY_MAX_EVENT_INTERVAL
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
/datum/controller/subsystem/storytellers/proc/create_storyteller_from_data(id)
	var/datum/storyteller/new_st = new /datum/storyteller(id)  // Base with ID for logging

	if(!id || !storyteller_data[id])
		// Default fallback
		new_st.name = "Default Storyteller"
		new_st.desc = "A generic storyteller managing station events and goals."
		new_st.mood = new /datum/storyteller_mood()
		if(hard_debug)
			log_storyteller("Created default storyteller.")
		return new_st

	var/list/data = storyteller_data[id]
	new_st.name = data["name"]
	new_st.desc = data["desc"]
	new_st.base_cost_multiplier = data["base_cost_multiplier"]
	new_st.player_antag_balance = data["player_antag_balance"]

	// Core pacing/threat vars
	new_st.base_think_delay = data["base_think_delay"]
	new_st.min_event_interval = data["min_event_interval"]
	new_st.max_event_interval = data["max_event_interval"]
	new_st.grace_period = data["grace_period"]
	new_st.mood_update_interval = data["mood_update_interval"]
	new_st.recent_damage_threshold = data["recent_damage_threshold"]
	new_st.threat_growth_rate = data["threat_growth_rate"]
	new_st.adaptation_decay_rate = data["adaptation_decay_rate"]
	new_st.target_tension = data["target_tension"]
	new_st.max_threat_scale = data["max_threat_scale"]
	new_st.repetition_penalty = data["repetition_penalty"]

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

/datum/controller/subsystem/storytellers/fire(resumed)

#ifdef TESTING //Storyteller thinking disabled during testing, it's handle by unit test
	return
#endif
	if(active)
		active.think()
	for(var/datum/round_event/evt in active_events)
		if(!evt || QDELETED(evt))
			active_events -= evt
			continue
		evt.__process_for_storyteller(world.tick_lag)

/datum/controller/subsystem/storytellers/proc/setup_game()

#ifdef UNIT_TESTS // Stortyteller setup disabled during testing, it's handle by unit test
	return TRUE
#endif

	disable_dynamic()
	disable_ICES()

	if(vote_active)
		end_vote()

	initialize_storyteller()
	return TRUE

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


/datum/controller/subsystem/storytellers/proc/on_login(mob/new_client)
	SIGNAL_HANDLER
	if(vote_active)
		var/datum/storyteller_vote_ui/ui = new(new_client.client, current_vote_duration)
		INVOKE_ASYNC(ui, TYPE_PROC_REF(/datum/storyteller_vote_ui, ui_interact), new_client)

/datum/controller/subsystem/storytellers/proc/register_atom_for_storyteller(atom/A)
	if(!active)
		return
	if(isnull(A) || QDELETED(A))
		return
	var/value = A.story_value()
	if(isnull(value) || value <= 0)
		return
	active.analyzer.register_atom_for_storyteller(A)


/datum/controller/subsystem/storytellers/proc/active_goal_is_achieved(list/context)
	return FALSE  // Stub: removed active_goal, as per chain refactor


/datum/controller/subsystem/storytellers/proc/collect_available_goals()
	goals_by_id = list()
	goals_by_category = list()
	goal_roots = list()

	// Initialize categories as empty lists with bitflags as keys
	goals_by_category["GOAL_RANDOM"] = list()
	goals_by_category["GOAL_GOOD"] = list()
	goals_by_category["GOAL_BAD"] = list()
	goals_by_category["GOAL_NEUTRAL"] = list()
	goals_by_category["GOAL_UNCATEGORIZED"] = list()


	for(var/goal_type in subtypesof(/datum/storyteller_goal))
		if(goal_type == /datum/storyteller_goal)  // Skip base type
			continue
		var/datum/storyteller_goal/goal = new goal_type()

		if(!goal.id)
			log_storyteller("Storyteller goal [goal_type] has no ID and was skipped.")
			qdel(goal)
			continue
		if(goals_by_id[goal.id])  // Prevent duplicates
			log_storyteller("Duplicate goal ID [goal.id] for [goal_type], skipping.")
			qdel(goal)
			continue
		goals_by_id[goal.id] = goal

		if(!goal.category)  // Fixed: tags -> category for consistency
			log_storyteller("Storyteller goal [goal_type] has no category, assigning uncategorized.")
			goal.category = STORY_GOAL_UNCATEGORIZED

		// Assign to all matching categories (bitflags allow multiple)
		if(goal.category & STORY_GOAL_RANDOM)
			goals_by_category["GOAL_RANDOM"] += goal
		if(goal.category & STORY_GOAL_GOOD)
			goals_by_category["GOAL_GOOD"] += goal
		if(goal.category & STORY_GOAL_BAD)
			goals_by_category["GOAL_BAD"] += goal
		if(goal.category & STORY_GOAL_NEUTRAL)
			goals_by_category["GOAL_NEUTRAL"] += goal
		if(goal.category & STORY_GOAL_UNCATEGORIZED)
			goals_by_category["GOAL_UNCATEGORIZED"] += goal

	// Link children after all instantiated
	for(var/id in goals_by_id)
		var/datum/storyteller_goal/goal = goals_by_id[id]
		goal.link_children(goals_by_id)

	// Collect roots: no parent or invalid parent
	for(var/id in goals_by_id)
		var/datum/storyteller_goal/goal = goals_by_id[id]
		if(!goal.parent_id || !goals_by_id[goal.parent_id])
			goal_roots += goal

	if(hard_debug)
		log_storyteller("Collected [length(goals_by_id)] goals, [length(goal_roots)] roots.")



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
		else
			category_str = "GOAL_UNCATEGORIZED"
	else
		category_str = "GOAL_UNCATEGORIZED"  // Default to uncategorized if none specified

	goals_to_check = _list_copy(goals_by_category[category_str])
	if(!goals_to_check)
		return list()

	for(var/datum/storyteller_goal/goal in goals_to_check)
		if(subtype && !istype(goal, subtype))
			continue
		if(required_tags)
			if(!goal.tags)
				continue
			if(all_tags_required)
				if((goal.tags & required_tags) != required_tags)
					continue
			else
				if(!(goal.tags & required_tags))
					continue

		if(!include_children && goal.parent_id && goals_by_id[goal.parent_id])
			continue

		// Additional filter for global flag if set in category
		if(category & STORY_GOAL_GLOBAL && !(goal.category & STORY_GOAL_GLOBAL))
			continue

		result += goal

	if(hard_debug)
		log_storyteller("Filtered [length(result)] goals for category=[category], tags=[required_tags].")

	return result


/// Convenience method to get root goals by category, tags, and subtype
/datum/controller/subsystem/storytellers/proc/get_root_goals(category = null, required_tags = null, subtype = null, all_tags_required = FALSE)
	return filter_goals(category, required_tags, subtype, all_tags_required, FALSE)

/// Convenience method to get goals by category and subtype
/datum/controller/subsystem/storytellers/proc/get_goals_by_category_and_subtype(category, subtype)
	return filter_goals(category, null, subtype, FALSE, TRUE)

/// Convenience method to get goals by tags
/datum/controller/subsystem/storytellers/proc/get_goals_by_tags(required_tags, all_tags_required = FALSE)
	return filter_goals(null, required_tags, null, all_tags_required, TRUE)

/datum/controller/subsystem/storytellers/proc/register_active_event(datum/round_event/E)
	if(!E || QDELETED(E))
		return
	active_events += E

/datum/controller/subsystem/storytellers/proc/unregister_active_event(datum/round_event/E)
	if(!E || QDELETED(E))
		return
	active_events -= E

/datum/config_entry/flag/storyteller_replace_dynamic
	default = TRUE

/datum/config_entry/flag/storyteller_helps_antags
	default = TRUE

/datum/config_entry/flag/storyteller_allows_speech
	default = TRUE

#undef FIRE_PRIORITY_STORYTELLERS
#undef STORYTELLER_JSON_PATH
