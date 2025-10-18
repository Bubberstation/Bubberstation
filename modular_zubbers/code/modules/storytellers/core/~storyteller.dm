/datum/storyteller
	var/name = "Base Storyteller"
	var/desc = "A generic storyteller managing station events and goals."

	var/base_cost_multiplier = 1.0
	/// Current mood profile, affecting event pacing and tone
	var/datum/storyteller_mood/mood
	/// Planner selects chain of goals and timeline-based execution
	var/datum/storyteller_planner/planner

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
	/// Event pacing limits
	var/min_event_interval = STORY_MIN_EVENT_INTERVAL
	var/max_event_interval = STORY_MAX_EVENT_INTERVAL

	/// Recent events timeline (timestamps) for admin UI and spacing
	var/list/recent_events = list()
	/// Recent event ids for repetition penalty logic in planner selection
	var/list/recent_event_ids = list()
	/// Max recent ids to remember (older dropped first)
	var/recent_event_ids_max = 20

	/// Aggregate balance indicator for UI (0..100 where 50 is balanced)
	var/player_antag_balance = STORY_DEFAULT_PLAYER_ANTAG_BALANCE

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
	/// Current level of overral tension
	var/current_tension = 0
	/// Current grace period after major event when we avoid rapid-fire scheduling
	var/grace_period = STORY_GRACE_PERIOD
	/// Time since last major event; used to enforce grace periods
	var/last_event_time = 0
	/// Round start timestamp
	var/round_start_time = 0
	/// Cached progression 0..1 over target duration
	var/round_progression = 0

	/// Overall difficulty multiplier; scales all weights/threats (1.0 normal)
	var/difficulty_multiplier = STORY_DIFFICULTY_MULTIPLIER
	/// Population factor; scales by active player population, larger crews get denser and more frequent events
	var/population_factor = STORY_POPULATION_FACTOR
	/// History of population counts for caunting population factor
	VAR_PRIVATE/list/population_history = list()
	/// Max threat scale; caps threat_points to prevent over-escalation
	var/max_threat_scale = STORY_MAX_THREAT_SCALE
	/// Repetition penalty; reduces weight of recently used events/goals for variety
	var/repetition_penalty = STORY_REPETITION_PENALTY

	/// Interval for mood adjustment (reuse planner recalc cadence)
	var/mood_update_interval = STORY_RECALC_INTERVAL
	var/last_mood_update_time = 0

	var/initialized = FALSE

/datum/storyteller/New()
	..()
	mood = new /datum/storyteller_mood
	planner = new /datum/storyteller_planner(src)
	analyzer = new /datum/storyteller_analyzer(src)
	balancer = new /datum/storyteller_balance(src)
	mind = new /datum/storyteller_think
	inputs = new /datum/storyteller_inputs


/datum/storyteller/proc/initialize_round()
	round_start_time = world.time
	run_metrics(RESCAN_STATION_INTEGRITY | RESCAN_STATION_VALUE)
	addtimer(CALLBACK(src, PROC_REF(post_initialize)), 1 SECONDS)

/datum/storyteller/proc/post_initialize()
	inputs = analyzer.get_inputs()
	var/datum/storyteller_balance_snapshot/bal = balancer.make_snapshot(inputs)

	planner.build_timeline(src, inputs, bal)
	initialized = TRUE
	schedule_next_think()

/datum/storyteller/proc/schedule_next_think()
	// Apply mood-based pacing (pace is clamped by storyteller bounds)
	var/pace_multiplier = (mood ? mood.pace : 1.0)
	var/delay = base_think_delay * clamp(pace_multiplier, STORY_PACE_MIN, STORY_PACE_MAX)
	next_think_time = world.time + delay

/datum/storyteller/proc/post_goal(datum/storyteller_goal/goal)
	if(!goal)
		return

	var/tension_effect = 0
	if(goal.tags & STORY_TAG_ESCALATION)
		adaptation_factor = min(1.0, adaptation_factor + 0.3)
		tension_effect += 5
	else if(goal.tags & STORY_TAG_DEESCALATION)
		adaptation_factor = max(0, adaptation_factor - 0.1)
	if(goal.category == STORY_GOAL_BAD)
		// Calculate the percentage loss of threat_points based on recent_damage_threshold
		var/loss_percentage = 100 / recent_damage_threshold
		var/threat_loss = threat_points * (loss_percentage / 100)
		threat_points = min(threat_points, threat_points - threat_loss)
		tension_effect += 10

	balancer.tension_bonus = min(balancer.tension_bonus + tension_effect, STORY_MAX_TENSION_BONUS)
	record_event(goal, STORY_GOAL_FAILED)

/datum/storyteller/proc/think(force = FALSE)
	if(!initialized)
		return

	if(world.time < next_think_time && !force)
		return

	// 1) Analyze: sample station metrics, compute crew/antag weights, update vault
	inputs = analyzer.get_inputs()

	// 2) Balance snapshot: derive tension, station strength, antag efficacy/inactivity
	var/datum/storyteller_balance_snapshot/snap = balancer.make_snapshot(inputs)
	player_antag_balance = round(snap.overall_tension)

	// 3) Mood: adapt mood based on current tension vs target and recent adaptation
	if(world.time - last_mood_update_time > mood_update_interval)
		update_mood_based_on_balance(snap)
		last_mood_update_time = world.time


	// 4) plan anf fire goals
	var/list/fired = planner.update_plan(src, inputs, snap)
	for(var/datum/storyteller_goal/completed_goal in fired)
		post_goal(completed_goal)

	// 5) Passive threat/adaptation drift each think
	threat_points = min(max_threat_scale, threat_points + threat_growth_rate * mood.get_threat_multiplier())
	adaptation_factor = max(0, adaptation_factor - adaptation_decay_rate)
	round_progression = clamp((world.time - round_start_time) / STORY_ROUND_PROGRESSION_TRESHOLD, 0, 1)

	population_history[num2text(world.time)] = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] \
											? inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] : 0
	while(length(population_history) > 10)
		population_history.Cut(1, 2)
	current_tension = snap.overall_tension
	balancer.tension_bonus = max(balancer.tension_bonus - STORY_TENSION_BONUS_DECAY_RATE * difficulty_multiplier, 0)
	update_population_factor()
	// 6) Schedule next cycle
	schedule_next_think()

/// Helper to record a goal event: store timestamp for spacing and id for repetition penalty
/datum/storyteller/proc/record_event(datum/storyteller_goal/G, status)
	if(!G)
		return
	var/current_time = world.time
	var/id = G.id + "_" + num2text(current_time)
	recent_events[id] = list(list(
		"id" = G.id,
		"desc" = G.desc,
		"status" = status,
		"fired_ts" = current_time, // raw world.time
		"fired_at" = num2text((current_time / 1 MINUTES)) + " min", // UI only
	))
	recent_event_ids |= G.id
	while(length(recent_event_ids) > recent_event_ids_max)
		recent_event_ids.Cut(1, 2)
	last_event_time = current_time

/datum/storyteller/proc/update_population_factor()
	var/current = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] ? inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] : 0

	var/total = 0
	var/count = 0
	for(var/key in population_history)
		total += text2num(population_history[key])
		count++
	var/avg = (count > 0 ? total / count : current)


	var/desired = (avg > 0 ? current / avg : 1.0)
	desired = clamp(desired, 0.1, 1.0)
	var/smooth_weight = 0.7
	population_factor = clamp((population_factor * smooth_weight) + (desired * (1.0 - smooth_weight)), 0.1, 1.0)

/datum/storyteller/proc/get_closest_subgoals()
	return planner.get_upcoming_goals(10)

/// Event trigger guard for ad-hoc random events outside goals
/datum/storyteller/proc/can_trigger_event_now()
	if(get_time_since_last_event() < grace_period + 2 MINUTES * (mood ? mood.get_threat_multiplier() : 1.0))
		return FALSE
	if(get_time_since_last_event() > round(grace_period * (mood ? mood.get_threat_multiplier() : 1.0) / min(3,difficulty_multiplier)))
		return TRUE
	var/prob_modifier = (mood ? mood.get_threat_multiplier() : 1.0) * difficulty_multiplier
	return prob(50 * prob_modifier)

/// Checks if an event can trigger at a future time, respecting grace period after last event.
/// Aids scheduling during sub-goal analysis without disrupting global objective pacing.
/datum/storyteller/proc/can_trigger_event_at(time)
	return time - get_time_since_last_event() > grace_period

/// Effective event pace: mood frequency multiplier * (1 - adaptation). Lower = slower events,
/// building tension toward global goals during crew adaptation phases.
/datum/storyteller/proc/get_effective_pace()
	return mood.get_event_frequency_multiplier() * (1.0 - adaptation_factor)

/// Base event interval, scaled by pace and divided by population for denser threats in larger crews.
/// Biger crews can handle more frequent events
/datum/storyteller/proc/get_event_interval()
	var/base = max_event_interval
	var/pop_mod = clamp(1.0 - 0.6 * population_factor, 0.4, 1.0)
	var/interval = base / max(get_effective_pace(), 0.05) * pop_mod
	return clamp(interval, min_event_interval, max_event_interval)


/// Event interval without population adjustment; for baseline pacing in global goal selection.
/datum/storyteller/proc/get_event_interval_no_population_factor()
	return min_event_interval + (max_event_interval - min_event_interval) / get_effective_pace()

/// Time since last event; tracks history for grace periods and intervals in event planning.
/datum/storyteller/proc/get_time_since_last_event()
	return world.time - last_event_time

/// Ad-hoc random event for testing or emergency pacing
/datum/storyteller/proc/trigger_random_event(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	SSevents.spawnEvent()
	recent_events += world.time
	log_storyteller("Triggered random event via SSevents")

/datum/storyteller/proc/get_effective_threat()
	return (threat_points/10) * mood.get_threat_multiplier() * difficulty_multiplier


/datum/storyteller/proc/get_next_possible_event_time()
	return world.time - get_time_since_last_event() + get_event_interval()

/// Adjust current mood variables based on balance snapshot (smooth, non-destructive)
/datum/storyteller/proc/update_mood_based_on_balance(datum/storyteller_balance_snapshot/snap)
	if(!mood || !snap)
		return
	// If tension is too high, bias towards calmer pacing and lower aggression
	if(snap.overall_tension > target_tension + 10)
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


/datum/storyteller/proc/get_active_player_count()
	return inputs.player_count

/datum/storyteller/proc/get_active_antagonist_count()
	return inputs.antag_count

/datum/storyteller/proc/run_metrics(flags)
	INVOKE_ASYNC(analyzer, TYPE_PROC_REF(/datum/storyteller_analyzer, scan_station), flags)
