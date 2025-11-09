// Default population thresholds (can be overridden per storyteller instance)
#define STORY_POPULATION_THRESHOLD_LOW_DEFAULT 10	   // Very low pop → mercy mode (positive goals)
#define STORY_POPULATION_THRESHOLD_MEDIUM_DEFAULT 21	// Medium → standard
#define STORY_POPULATION_THRESHOLD_HIGH_DEFAULT 32	  // High → challenge
#define STORY_POPULATION_THRESHOLD_FULL_DEFAULT 51	 // Full → max escalation

#define STORY_POPULATION_FACTOR_LOW_DEFAULT 0.3		 // Low pop: easier, more positive branches
#define STORY_POPULATION_FACTOR_MEDIUM_DEFAULT 0.5
#define STORY_POPULATION_FACTOR_HIGH_DEFAULT 0.8
#define STORY_POPULATION_FACTOR_FULL_DEFAULT 1.0

#define STORY_POPULATION_SMOOTH_WEIGHT_DEFAULT 0.4

#define STORY_POPULATION_HISTORY_MAX 20

/datum/storyteller
	var/name = "John Dynamic"
	var/desc = "A generic storyteller managing station events and goals."
	var/ooc_desc = "Tell to coder if you saw this storyteller in action."
	var/ooc_difficulty = "Dynamic"
	var/portrait_path = ""
	var/logo_path = ""
	var/id = "john_dynamic"
	/// Base cost multiplier for event cost calculations
	var/base_cost_multiplier = 1.0
	/// Current mood profile, affecting event pacing and tone
	var/datum/storyteller_mood/mood
	/// Planner selects chain of goals and timeline-based execution
	var/datum/storyteller_planner/planner
	/// Mind of storyteller; determines how they shoot events
	var/datum/storyteller_think/mind
	/// Analyzer computes station value and inputs
	var/datum/storyteller_analyzer/analyzer
	/// Balancer computes weights of players vs antagonists
	var/datum/storyteller_balance/balancer
	/// Storyteller short memory of inputs and vault
	var/datum/storyteller_inputs/inputs
	/// Next time to update analysis and planning (in world.time)
	var/next_think_time = 0
	/// Base think frequency; scaled by mood pace (in ticks)
	var/base_think_delay = STORY_THINK_BASE_DELAY
	// Event pacing limits
	var/average_event_interval = 15 MINUTES
	/// Recent events timeline (timestamps) for admin UI and spacing
	var/list/recent_events = list()
	/// Recent event ids for repetition penalty logic in planner selection
	var/list/recent_event_ids = list()
	/// Max recent ids to remember (older dropped first)
	var/recent_event_ids_max = 20
	/// Aggregate balance indicator for UI (0..100 where 50 is balanced)
	var/player_antag_balance = 0
	// Target balance level
	var/target_player_antag_balance = STORY_DEFAULT_PLAYER_ANTAG_BALANCE
	// Adaptation and difficulty variables (inspired by RimWorld's threat adaptation and cycles)
	/// Current threat points; accumulate over time to scale event intensity
	var/threat_points = 0
	/// Rate at which threat points increase per think cycle
	var/threat_growth_rate = STORY_THREAT_GROWTH_RATE
	/// Adaptation factor; reduces threat intensity after recent damage/losses (0-1, where 0 = full adaptation/no threats)
	var/adaptation_factor = 0
	/// Rate at which adaptation decays over time (e.g., gradual recovery after disasters)
	var/adaptation_decay_rate = STORY_ADAPTATION_DECAY_RATE
	/// Threshold for triggering adaptation spikes
	var/recent_damage_threshold = STORY_RECENT_DAMAGE_THRESHOLD
	/// Target tension level; storyteller aims to keep overall_tension around this
	var/target_tension = STORY_TARGET_TENSION
	/// Current level of overall tension
	var/current_tension = 0
	/// Current grace period after major event when we avoid rapid-fire scheduling
	var/grace_period = STORY_GRACE_PERIOD
	/// Time since last major event; used to enforce grace periods
	var/last_event_time = 0
	/// Round start timestamp
	var/round_start_time = 0
	/// Cached progression 0..1 over target duration
	var/round_progression = 0
	/// Overall difficulty multiplier; scales all weights/threats (1.0 = normal)
	var/difficulty_multiplier = STORY_DIFFICULTY_MULTIPLIER
	/// Population factor; scales by active player population, larger crews get denser and more frequent events
	var/population_factor = 0
	/// History of population counts for counting population factor
	VAR_PRIVATE/list/population_history = list()
	/// History of raw crew counts (numeric) — used for spike detection
	VAR_PRIVATE/list/population_count_history = list()
	/// History of tension values used for spike detection
	VAR_PRIVATE/list/tension_history = list()
	/// Max threat scale; caps threat_points to prevent over-escalation
	var/max_threat_scale = STORY_MAX_THREAT_SCALE
	/// Repetition penalty; reduces weight of recently used events/goals for variety
	var/repetition_penalty = STORY_REPETITION_PENALTY
	/// Interval for mood adjustment (reuse planner recalc cadence)
	var/mood_update_interval = STORY_RECALC_INTERVAL
	/// Is this storyteller initialized
	var/initialized = FALSE

	/// Population scaling configuration
	/// Threshold for low population classification
	var/population_threshold_low = STORY_POPULATION_THRESHOLD_LOW_DEFAULT
	/// Threshold for medium population classification
	var/population_threshold_medium = STORY_POPULATION_THRESHOLD_MEDIUM_DEFAULT
	/// Threshold for high population classification
	var/population_threshold_high = STORY_POPULATION_THRESHOLD_HIGH_DEFAULT
	/// Threshold for full population classification
	var/population_threshold_full = STORY_POPULATION_THRESHOLD_FULL_DEFAULT
	/// Factor multiplier for low population (lower = fewer/smaller threats)
	var/population_factor_low = STORY_POPULATION_FACTOR_LOW_DEFAULT
	/// Factor multiplier for medium population
	var/population_factor_medium = STORY_POPULATION_FACTOR_MEDIUM_DEFAULT
	/// Factor multiplier for high population
	var/population_factor_high = STORY_POPULATION_FACTOR_HIGH_DEFAULT
	/// Factor multiplier for full population (1.0 = full scaling)
	var/population_factor_full = STORY_POPULATION_FACTOR_FULL_DEFAULT
	/// Smoothing weight for population factor changes (0-1, higher = slower changes)
	var/population_smooth_weight = STORY_POPULATION_SMOOTH_WEIGHT_DEFAULT

	COOLDOWN_DECLARE(mood_update_cooldown)
	/// Cooldown for checking antagonist spawn balance (in ticks)
	COOLDOWN_DECLARE(antag_balance_check_cooldown)
	/// Base interval for checking antagonist balance (default: 30 minutes for wave-based spawning)
	var/antag_balance_check_interval = 30 MINUTES
	/// Time when roundstart antagonists should be selected (approximately 10 minutes after round start)
	var/roundstart_antag_selection_time = 0
	/// Whether roundstart antagonists have been selected
	var/roundstart_antags_selected = FALSE


/datum/storyteller/New()
	..()
	mood = new /datum/storyteller_mood
	planner = new /datum/storyteller_planner(src)
	analyzer = new /datum/storyteller_analyzer(src)
	balancer = new /datum/storyteller_balance(src)
	mind = new /datum/storyteller_think
	inputs = new /datum/storyteller_inputs

/datum/storyteller/Destroy(force)
	qdel(mood)
	qdel(planner)
	qdel(analyzer)
	qdel(balancer)
	qdel(mind)
	qdel(inputs)

	UnregisterSignal(analyzer, COMSIG_STORYTELLER_FINISHED_ANALYZING)
	..()



/datum/storyteller/proc/initialize()
	round_start_time = world.time


	// Schedule roundstart antagonist selection approximately 10 minutes after round start
	// Will check for sufficient population when time comes
	roundstart_antag_selection_time = world.time + 10 MINUTES
	RegisterSignal(analyzer, COMSIG_STORYTELLER_FINISHED_ANALYZING, PROC_REF(on_metrics_finished))
	run_metrics(RESCAN_STATION_INTEGRITY | RESCAN_STATION_VALUE)


/datum/storyteller/proc/on_metrics_finished(datum/storyteller_analyzer/anl, datum/storyteller_inputs/inputs, timout, metrics_count)
	SIGNAL_HANDLER
	src.inputs = analyzer.get_inputs()
	if(initialized)
		return

	last_event_time = world.time
	var/datum/storyteller_balance_snapshot/bal = balancer.make_snapshot(inputs)
	planner.build_timeline(src, inputs, bal)
	initialized = TRUE

	// Send round start report (generates custom report based on storyteller parameters)
	send_round_start_report()
	INVOKE_ASYNC(src, PROC_REF(think))

/**
 * Geters and setters
 */


/// Checks if an event can trigger at a future time, respecting grace period after last event.
/// Aids scheduling during sub-goal analysis without disrupting global objective pacing.
/datum/storyteller/proc/can_trigger_event_at(time)
	// Scale grace period by population_factor: low pop = longer grace period
	// Linear interpolation: low pop (0.3) -> 1.5x grace, high pop (1.0) -> 1.0x grace
	var/pop_grace_mult = 1.5 - (population_factor - 0.3) * (1.5 - 1.0) / (1.0 - 0.3)
	pop_grace_mult = clamp(pop_grace_mult, 1.0, 1.5)
	var/effective_grace = get_effective_pace()
	return time - get_time_since_last_event() > effective_grace


/// Effective event pace: mood frequency multiplier * (1 - adaptation). Lower = slower events,
/// building tension toward global goals during crew adaptation phases.
/datum/storyteller/proc/get_effective_pace()
	return mood.get_event_frequency_multiplier() * (1.5 - adaptation_factor)



/datum/storyteller/proc/get_scaled_grace()
	var/pop_grace_mult = lerp(1.5, 0.5, (population_factor - 0.3) / (1.0 - 0.3))
	pop_grace_mult = clamp(pop_grace_mult, 0.0, 1.5)
	return grace_period * pop_grace_mult



/// Base event interval, scaled by pace and population factor.
/// Low population = longer intervals (fewer events), high population = shorter intervals (more frequent events)
/datum/storyteller/proc/get_event_interval()
	var/base = average_event_interval * get_effective_pace()
	var/pop_mod = 1.5 - population_factor
	return round(base * pop_mod)



/// Event interval without population adjustment; for baseline pacing in global goal selection.
/datum/storyteller/proc/get_event_interval_no_population_factor()
	return average_event_interval * get_effective_pace()



/// Time since last event; tracks history for grace periods and intervals in event planning.
/datum/storyteller/proc/get_time_since_last_event()
	return world.time - last_event_time


/datum/storyteller/proc/get_closest_subgoals()
	return planner.get_upcoming_events(10)


/// Event trigger guard for ad-hoc random events outside goals
/datum/storyteller/proc/can_trigger_event_now()
	// Scale grace period by population_factor: low pop = longer grace period
	// Linear interpolation: low pop (0.3) -> 1.5x grace, high pop (1.0) -> 1.0x grace
	var/pop_grace_mult = 1.5 - (population_factor - 0.3) * (1.5 - 1.0) / (1.0 - 0.3)
	pop_grace_mult = clamp(pop_grace_mult, 1.0, 1.5)
	var/effective_grace = grace_period * pop_grace_mult

	if(get_time_since_last_event() < effective_grace + 2 MINUTES * (mood ? mood.get_threat_multiplier() : 1.0))
		return FALSE
	if(get_time_since_last_event() > round(effective_grace * (mood ? mood.get_threat_multiplier() : 1.0) / min(3, difficulty_multiplier)))
		return TRUE
	var/prob_modifier = (mood ? mood.get_threat_multiplier() : 1.0) * difficulty_multiplier * population_factor
	return prob(50 * prob_modifier)


/// Ad-hoc random event for testing or emergency pacing
/datum/storyteller/proc/trigger_random_event(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	SSevents.spawnEvent()
	recent_events += world.time
	log_storyteller("Triggered random event via SSevents")


/datum/storyteller/proc/get_effective_threat()
	// Scale effective threat by population_factor: low pop = lower effective threat
	return (threat_points/10) * mood.get_threat_multiplier() * difficulty_multiplier * clamp(population_factor, 0.3, 1.0)


/datum/storyteller/proc/get_next_possible_event_time()
	return (world.time - last_event_time) + get_event_interval()


/datum/storyteller/proc/get_event_threat_points(category)
	var/base_threat = (threat_points * mood.get_threat_multiplier() * clamp(population_factor, 0.3, 1.0)) * 100
	if(category == STORY_GOAL_GOOD)
		return round(base_threat * 0.5 * (1.5 - adaptation_factor))
	else if(category == STORY_GOAL_NEUTRAL)
		return round(base_threat * 0.8 * (1.5 - adaptation_factor))
	else if(category == STORY_GOAL_BAD)
		return round(base_threat * 1.2 * max(0.5, adaptation_factor))
	return clamp(round(base_threat), 0, max_threat_scale * 100)

/**
 * Main thinker loop
 */


/datum/storyteller/proc/schedule_next_think()
	// Apply mood-based pacing (pace is clamped by storyteller bounds)
	var/pace_multiplier = (mood ? mood.pace : 1.0)
	var/delay = base_think_delay * clamp(pace_multiplier, STORY_PACE_MIN, STORY_PACE_MAX)
	next_think_time = world.time + delay


/datum/storyteller/proc/think(force = FALSE)
	SHOULD_NOT_SLEEP(TRUE)

	if(!initialized)
		return

	if(world.time < next_think_time && !force)
		return

	if(SEND_SIGNAL(src, COMSIG_STORYTELLER_PRE_THINK) & COMPONENT_THINK_BLOCKED && !force)
		return


	// 1) Balance snapshot: derive tension, station strength, antag efficacy/inactivity
	var/datum/storyteller_balance_snapshot/snap = balancer.make_snapshot(inputs)
	player_antag_balance = round(snap.overall_tension)

	// 2) Mood: adapt mood based on current tension vs target and recent adaptation
	if(COOLDOWN_FINISHED(src, mood_update_cooldown))
		update_mood_based_on_balance(snap)
		COOLDOWN_START(src, mood_update_cooldown, mood_update_interval)


	// 3) Plan and fire goals
	var/list/events_to_fire = planner.update_plan(src, inputs, snap)
	if(length(events_to_fire))
		for(var/datum/round_event_control/evt in events_to_fire)
			var/threat_points = get_event_threat_points()
			INVOKE_ASYNC(evt, TYPE_PROC_REF(/datum/round_event_control, run_event_as_storyteller), inputs, src, threat_points)
			record_event(evt, "Fired")
			post_event(evt)


	// 4) Passive threat/adaptation drift each think
	// Threat growth scales with population_factor: low pop = slower threat accumulation
	var/threat_mult = mood.get_threat_multiplier() * clamp(population_factor, 0.3, 1.0)
	threat_points = min(max_threat_scale, threat_points + threat_growth_rate * threat_mult)


	if(!HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ADAPTATION_DECAY))
		adaptation_factor = max(0, adaptation_factor - adaptation_decay_rate)
	round_progression = clamp((world.time - round_start_time) / STORY_ROUND_PROGRESSION_TRESHOLD, 0, 1)
	current_tension = snap.overall_tension
	balancer.tension_bonus = max(balancer.tension_bonus - STORY_TENSION_BONUS_DECAY_RATE * difficulty_multiplier, 0)
	update_population_factor()


	// 5) Check antagonist balance and spawn if needed
	if(COOLDOWN_FINISHED(src, antag_balance_check_cooldown) && SSstorytellers?.storyteller_replace_dynamic && roundstart_antags_selected)
		check_and_spawn_antagonists(snap)
		COOLDOWN_START(src, antag_balance_check_cooldown, antag_balance_check_interval)


	// 6) Check if it's time to select roundstart antagonists
	// Wait for ~10 minutes and check if there are enough people on station
	if(!roundstart_antags_selected && world.time >= roundstart_antag_selection_time)
		var/pop = inputs.player_count()

		// Check if we have enough people (at least medium population threshold)
		if(pop >= population_threshold_low)
			if(spawn_initial_antagonists())
				roundstart_antags_selected = TRUE
				COOLDOWN_START(src, antag_balance_check_cooldown, antag_balance_check_interval)
			else
			// Not enough people yet, wait a bit more (check again in 2 minutes)
				roundstart_antag_selection_time = world.time + (2 MINUTES)
		else
			roundstart_antag_selection_time = world.time + (5 MINUTES)


	var/latest_key = num2text(world.time)
	tension_history[latest_key] = current_tension
	if(length(tension_history) > STORY_POPULATION_HISTORY_MAX)
		tension_history.Cut(1, 2)

	// 7) Schedule next cycle
	schedule_next_think()
	SEND_SIGNAL(src, COMSIG_STORYTELLER_POST_THINK)



/datum/storyteller/proc/post_event(datum/round_event_control/evt)
	if(!evt)
		return

	var/tension_effect = 0
	if(evt.tags & STORY_TAG_ESCALATION)
		adaptation_factor = min(1.0, adaptation_factor + 0.3)
		tension_effect += 5
		if(evt.tags & STORY_GOAL_MAJOR)
			adaptation_factor = min(1.0, adaptation_factor + 0.2)
	else if(evt.tags & STORY_TAG_DEESCALATION)
		adaptation_factor = max(0, adaptation_factor - 0.1)

	if(evt.story_category & STORY_GOAL_BAD)
		// Calculate the percentage loss of threat_points based on recent_damage_threshold
		var/loss_percentage = 100 / recent_damage_threshold
		if(evt.story_category & STORY_GOAL_MAJOR && !HAS_TRAIT(src, STORYTELLER_TRAIT_NO_MERCY))
			loss_percentage *= 2

		var/threat_loss = threat_points * (loss_percentage / 100)
		threat_points = min(threat_points, threat_points - threat_loss)
		tension_effect += 10

	balancer.tension_bonus = min(balancer.tension_bonus + tension_effect, STORY_MAX_TENSION_BONUS)
	record_event(evt, STORY_GOAL_COMPLETED)



/// Helper to record a goal event: store timestamp for spacing and id for repetition penalty
/datum/storyteller/proc/record_event(datum/round_event_control/evt, status)
	if(!evt)
		return
	var/current_time = world.time
	var/id = evt.id + "_" + num2text(current_time)
	recent_events[id] = list(list(
		"id" = evt.id,
		"desc" = evt.description,
		"status" = status,
		"fired_ts" = current_time,
		"fired_at" = time2text(world.time, "hh:mm", NO_TIMEZONE),
	))
	recent_event_ids |= evt.id
	while(length(recent_event_ids) > recent_event_ids_max)
		recent_event_ids.Cut(1, 2)
	last_event_time = current_time



/datum/storyteller/proc/update_population_factor()
	var/current = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0

	var/low_thresh = population_threshold_low * (mood ? mood.aggression : 1.0)
	var/med_thresh = population_threshold_medium * (mood ? mood.aggression : 1.0)
	var/high_thresh = population_threshold_high * (mood ? mood.aggression : 1.0)


	var/desired = population_factor_medium
	if(current <= low_thresh)
		desired = population_factor_low
	else if(current <= med_thresh)
		desired = population_factor_medium
	else if(current <= high_thresh)
		desired = population_factor_high
	else
		desired = population_factor_full


	var/effective_smooth = population_smooth_weight
	if(has_population_spike(20))
		effective_smooth = 0.5

	var/new_factor = (population_factor * effective_smooth) + (desired * (1.0 - effective_smooth))
	var/delta = new_factor - population_factor
	new_factor = population_factor + clamp(delta, -0.2, 0.2)
	population_factor = clamp(new_factor, 0.1, 1.0)

	population_history[num2text(world.time)] = population_factor
	if(length(population_history) > STORY_POPULATION_HISTORY_MAX)
		population_history.Cut(1, 2)
	population_count_history[num2text(world.time)] = current
	if(length(population_count_history) > STORY_POPULATION_HISTORY_MAX)
		population_count_history.Cut(1, 2)


/// Adjust current mood variables based on balance snapshot (smooth, non-destructive)
/datum/storyteller/proc/update_mood_based_on_balance(datum/storyteller_balance_snapshot/snap)
	if(!mood || !snap)
		return
	// If tension is too high, bias towards calmer pacing and lower aggression
	if(snap.overall_tension > target_tension + 10 || (HAS_TRAIT(src, STORYTELLER_TRAIT_KIND) && prob(50)))
		mood.aggression = max(0.5, mood.aggression - 0.1)
		mood.pace = max(0.5, mood.pace - 0.1)
		mood.volatility = max(0.6, mood.volatility - 0.05)
	// If too calm, spice it up a bit
	else if(snap.overall_tension < target_tension - 10)
		mood.aggression = min(1.5, mood.aggression + 0.1)
		mood.pace = min(1.5, mood.pace + 0.1)
		mood.volatility = min(1.4, mood.volatility + 0.05)
	// Otherwise, gently normalize toward neutral
	else
		mood.aggression = clamp((mood.aggression * 0.9) + 0.1 * 1.0, 0.5, 1.5)
		mood.pace = clamp((mood.pace * 0.9) + 0.1 * 1.0, 0.5, 1.5)
		mood.volatility = clamp((mood.volatility * 0.9) + 0.1 * 1.0, 0.6, 1.4)

/**
 * Metrics and helpers
 */


/datum/storyteller/proc/run_metrics(flags)
	INVOKE_ASYNC(analyzer, TYPE_PROC_REF(/datum/storyteller_analyzer, scan_station), flags)


// Returns TRUE if the latest crew count differs from recent average by 'threshold_percent' or more.
/datum/storyteller/proc/has_population_spike(threshold_percent = 20)
	var/current = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0
	var/total = 0
	var/count = 0
	var/latest_key = num2text(world.time)
	// compute average excluding latest sample (if present) to avoid self-comparison
	for(var/key in population_count_history)
		if(key == latest_key)
			continue
		total += text2num(population_count_history[key])
		count++
	var/avg = (count > 0 ? total / count : 0)
	if(count < 3 || avg <= 0)
		// not enough history to make a decision
		return FALSE
	var/delta = abs(current - avg)
	return (delta / max(1, avg)) >= (threshold_percent / 100)


// Returns TRUE if the latest tension differs from recent average by 'threshold_percent' or more.
/datum/storyteller/proc/has_tension_spike(threshold_percent = 20)
	var/current = current_tension
	var/total = 0
	var/count = 0
	var/latest_key = num2text(world.time)
	for(var/key in tension_history)
		if(key == latest_key)
			continue
		total += text2num(tension_history[key])
		count++
	var/avg = (count > 0 ? total / count : 0)
	if(count < 3 || avg <= 0)
		return FALSE
	var/delta = abs(current - avg)
	return (delta / max(1, avg)) >= (threshold_percent / 100)


/**
 * Round start report generation
 */


/// Generates and sends round start report based on storyteller parameters
/// Should be called after round initialization
/datum/storyteller/proc/send_round_start_report()
	if(!CONFIG_GET(flag/no_intercept_report))
		// Generate and send full roundstart report independently
		addtimer(CALLBACK(src, PROC_REF(send_full_roundstart_report)), \
			rand(60 SECONDS, 180 SECONDS), TIMER_UNIQUE)

/// Sends a complete roundstart report independently, without using communications_controller
/// Includes advisory report, station goals, and traits
/datum/storyteller/proc/send_full_roundstart_report()
	if(!initialized || !inputs)
		return

	// Generate advisory report based on storyteller's target tension and difficulty
	var/advisory_report = generate_roundstart_report()
	if(!advisory_report)
		// Fallback if generation fails
		if(SSstorytellers?.storyteller_replace_dynamic)
			log_storyteller("[name] failed to generate roundstart report, using fallback")
		else
			GLOB.communications_controller.queue_roundstart_report()
			return

	// Build full report (similar to communications_controller.send_roundstart_report)
	var/full_report = "<b><i>Nanotrasen Department of Intelligence Threat Advisory, Spinward Sector, TCD [time2text(world.realtime, "DDD, MMM DD")], [CURRENT_STATION_YEAR]:</i></b><hr>"
	full_report += advisory_report

	// Generate station goals (if storyteller controls dynamic, use appropriate budget)
	var/greenshift = determine_greenshift_status()
	var/goal_budget = greenshift ? INFINITY : CONFIG_GET(number/station_goal_budget)
	SSstation.generate_station_goals(goal_budget)

	var/list/datum/station_goal/goals = SSstation.get_station_goals()
	if(length(goals))
		var/list/texts = list("<hr><b>Special Orders for [station_name()]:</b><br>")
		for(var/datum/station_goal/station_goal as anything in goals)
			station_goal.on_report()
			texts += station_goal.get_report()
		full_report += texts.Join("<hr>")

	// Add station traits
	var/list/trait_list_strings = list()
	for(var/datum/station_trait/station_trait as anything in SSstation.station_traits)
		if(!station_trait.show_in_report)
			continue
		trait_list_strings += "[station_trait.get_report()]<BR>"
	if(trait_list_strings.len > 0)
		full_report += "<hr><b>Identified shift divergencies:</b><BR>" + trait_list_strings.Join("")

	// Add footnotes if any
	if(length(GLOB.communications_controller.command_report_footnotes))
		var/footnote_pile = ""
		for(var/datum/command_footnote/footnote as anything in GLOB.communications_controller.command_report_footnotes)
			footnote_pile += "[footnote.message]<BR>"
			footnote_pile += "<i>[footnote.signature]</i><BR>"
			footnote_pile += "<BR>"
		full_report += "<hr><b>Additional Notes: </b><BR><BR>" + footnote_pile

	// Send the report
#ifndef MAP_TEST
	print_command_report(full_report, "[command_name()] Status Summary", announce=FALSE)

	// Send priority announcement based on greenshift status
	if(greenshift)
		priority_announce(
			"Thanks to the tireless efforts of our security and intelligence divisions, \
				there are currently no credible threats to [station_name()]. \
				All station construction projects have been authorized. Have a secure shift!",
			"Security Report",
			SSstation.announcer.get_rand_report_sound(),
			color_override = "green",
		)
	else if(prob(90))
		priority_announce(
			"[SSsecurity_level.current_security_level.elevating_to_announcement]\n\n\
				A summary has been copied and printed to all communications consoles.",
			"Security level elevated.",
			ANNOUNCER_INTERCEPT,
			color_override = SSsecurity_level.current_security_level.announcement_color,
		)
	else
		priority_announce(
			"A summary of the station's situation has been copied and printed to all communications consoles.",
			"Security Report",
			SSstation.announcer.get_rand_report_sound(),
		)
#endif

	log_storyteller("[name] sent full roundstart report with advisory level based on target_tension=[target_tension], difficulty=[difficulty_multiplier]")

/// Determines if this should be treated as a greenshift (no threats)
/datum/storyteller/proc/determine_greenshift_status()
	// Greenshift if target tension is very low and difficulty is low
	if(target_tension < 20 && difficulty_multiplier < 0.8)
		return TRUE
	// Also greenshift if no antags trait is active
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		return TRUE
	return FALSE


/// Generates a roundstart advisory report based on storyteller's target tension and difficulty
/// Uses target_tension (what storyteller aims for) and difficulty_multiplier instead of current tension
/datum/storyteller/proc/generate_roundstart_report()
	if(!initialized || !inputs)
		return null

	// Calculate threat level based on target_tension and difficulty_multiplier
	// Higher target_tension and difficulty = higher threat advisory
	var/threat_score = (target_tension / 100.0) * difficulty_multiplier

	// Determine threat advisory level based on target_tension and difficulty
	var/advisory_level = "Green Star"
	var/advisory_desc = "no credible threats"
	var/threat_scale = threat_score

	// Scale threat based on target_tension (0-100) and difficulty_multiplier
	// target_tension represents what the storyteller is aiming for, not current state
	if(threat_scale > 0.75 || (target_tension > 70 && difficulty_multiplier > 1.2))
		advisory_level = "Midnight Sun"
		advisory_desc = "high likelihood of major coordinated attacks expected during this shift"
	else if(threat_scale > 0.60 || (target_tension > 50 && difficulty_multiplier > 1.0))
		advisory_level = "Black Orbit"
		advisory_desc = "elevated threat level with potential for significant enemy activity"
	else if(threat_scale > 0.40 || (target_tension > 30 && difficulty_multiplier > 0.8))
		advisory_level = "Red Star"
		advisory_desc = "credible risk of enemy attack against our assets"
	else if(threat_scale > 0.20 || (target_tension > 15 && difficulty_multiplier > 0.7))
		advisory_level = "Yellow Star"
		advisory_desc = "potential risk requiring heightened vigilance"
	else
		advisory_level = "Green Star"
		advisory_desc = "minimal threats anticipated"

	// Adjust description based on difficulty multiplier
	if(difficulty_multiplier > 1.3)
		advisory_desc += ". Intelligence indicates above-average operational complexity"
	else if(difficulty_multiplier < 0.7)
		advisory_desc += ". Conditions appear more favorable than typical"

	// Build report text based on storyteller personality
	var/report = "Advisory Level: <b>[advisory_level]</b></center><BR>"
	report += "Your sector's advisory level is [advisory_level]. "

	// Add storyteller-specific flavor text
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_KIND))
		report += "Intelligence reports suggest a relatively peaceful shift, but "
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_FORCE_TENSION))
		report += "Recent intelligence decrypts indicate elevated tension levels. "
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_SPEAKER))
		report += "Comprehensive surveillance analysis suggests "
	else
		report += "Surveillance information suggests "

	report += "[advisory_desc] within the Spinward Sector. "

	// Add information about expected antagonist activity
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		report += "However, no immediate antagonist activity is expected. "
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
		report += "Antagonist activity is expected to be minimal and sporadic. "
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
		report += "Multiple potential threats detected. Expect frequent antagonist encounters. "
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN))
		report += "Rapid response threats may materialize quickly. "

	// Add note about difficulty if significantly different from normal
	if(difficulty_multiplier > 1.2)
		report += "Operational difficulty is assessed as above standard. "
	else if(difficulty_multiplier < 0.8)
		report += "Operational conditions appear more manageable than typical. "

	report += "As always, the Department advises maintaining vigilance against potential threats."

	return report

/// Gets a descriptive threat level string based on target_tension and difficulty
/// Uses the storyteller's target tension (what it aims for) rather than current threat points
/datum/storyteller/proc/get_threat_level_description()
	var/threat_score = (target_tension / 100.0) * difficulty_multiplier

	if(threat_score > 0.9 || (target_tension > 80 && difficulty_multiplier > 1.5))
		return "Apocalyptic"
	else if(threat_score > 0.75 || (target_tension > 65 && difficulty_multiplier > 1.2))
		return "Extreme"
	else if(threat_score > 0.55 || (target_tension > 45 && difficulty_multiplier > 1.0))
		return "High"
	else if(threat_score > 0.35 || (target_tension > 25 && difficulty_multiplier > 0.8))
		return "Moderate"
	else
		return "Low"


#undef STORY_POPULATION_THRESHOLD_LOW_DEFAULT
#undef STORY_POPULATION_THRESHOLD_MEDIUM_DEFAULT
#undef STORY_POPULATION_THRESHOLD_HIGH_DEFAULT
#undef STORY_POPULATION_THRESHOLD_FULL_DEFAULT
#undef STORY_POPULATION_FACTOR_LOW_DEFAULT
#undef STORY_POPULATION_FACTOR_MEDIUM_DEFAULT
#undef STORY_POPULATION_FACTOR_HIGH_DEFAULT
#undef STORY_POPULATION_FACTOR_FULL_DEFAULT
#undef STORY_POPULATION_SMOOTH_WEIGHT_DEFAULT
#undef STORY_POPULATION_HISTORY_MAX
