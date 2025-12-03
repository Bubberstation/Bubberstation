/**
 * Storyteller antagonist spawning logic
 */


/// Checks antagonist balance and spawns midround antagonists in waves if needed
/// Called approximately every ~30 minutes based on cooldown
/// Uses threat level, balance ratio, and antag weight to determine if spawns are needed
/datum/storyteller/proc/check_and_spawn_antagonists(datum/storyteller_balance_snapshot/snap, force = FALSE)
	if(!SSstorytellers.storyteller_replace_dynamic && !force)
		return

	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS) && !force)
		return
	if(!snap)
		snap = balancer.make_snapshot(inputs)

	var/balance_ratio = snap.balance_ratio
	var/antag_count = inputs.antag_count()
	var/antag_weight = inputs.antag_weight()
	var/player_weight = inputs.crew_weight()

	// Check if antags are too weak, inactive, or missing
	var/needs_antags = FALSE
	var/reason = ""

	if(!force)
		if(population_factor <= population_factor_low)
			needs_antags = FALSE
			reason = "insufficient population (factor: [population_factor])"
		// No antags at all
		else if(antag_count <= 0)
			needs_antags = TRUE
			reason = "no antagonists"
		// Antags are too weak (effectiveness below threshold)
		else if(snap.antag_weak)
			needs_antags = TRUE
			reason = "antagonists too weak (effectiveness: [snap.get_antag_advantage()])"
		// Antags are inactive
		else if(snap.antag_inactive)
			needs_antags = TRUE
			reason = "antagonists inactive (activity: [snap.antag_activity_index])"
		// Balance ratio indicates antags are significantly weaker than station
		else if(balance_ratio < 0.5)
			needs_antags = TRUE
			reason = "antagonists too weak relative to station (ratio: [balance_ratio])"
		// Antag weight is too low relative to player weight
		else if(player_weight > 0 && antag_weight / player_weight < 0.3)
			needs_antags = TRUE
			reason = "antagonist weight too low (antag: [antag_weight], players: [player_weight])"

		// If antags are sufficient, don't spawn
		if(!needs_antags)
			message_admins("[name] skipped antagonist spawn wave - [reason]")
			return
	else
		needs_antags = TRUE
		message_admins("[name] forced antagonist spawn wave!")

	// Calculate spawn weight based on threat level, balance ratio, and antag weight
	var/spawn_weight = calculate_antagonist_spawn_weight_wave(balance_ratio, snap, antag_weight, player_weight)

	// Only attempt spawn if weight suggests we should
	if(spawn_weight <= 0 && !force)
		return

	// Try to spawn midround antagonists (wave-based)
	try_spawn_midround_antagonist_wave(snap)


/datum/storyteller/proc/spawn_initial_antagonists()
	if(!SSstorytellers?.storyteller_replace_dynamic)
		return

	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		message_admins("[name] skipped initial antagonist spawn (NO_ANTAGS trait)")
		return FALSE

	var/pop = inputs.player_count()
	if(pop < population_threshold_low)
		message_admins("[name] skipped initial antagonist spawn - insufficient population (pop: [pop])")
		return FALSE

	var/list/possible_candidates = SSstorytellers.filter_goals(STORY_GOAL_ANTAGONIST, STORY_TAG_ROUNDSTART)
	var/datum/storyteller_balance_snapshot/bal = balancer.make_snapshot(inputs)
	var/tags = mind.tokenize(STORY_GOAL_ANTAGONIST, src, inputs, bal, mood)
	var/spawn_count = calculate_roundstart_antag_count(pop, bal.balance_ratio)
	for(var/i = 1 to spawn_count)
		var/datum/round_event_control/antag_event = mind.select_weighted_goal(src, inputs, bal, possible_candidates, population_factor, tags)
		if(!antag_event)
			log_storyteller("[name] failed to select initial antagonist goal ([i]/[spawn_count])")
			continue
		var/spawn_offset = rand(45 SECONDS, 120 SECONDS)
		if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
			spawn_offset *= 0.7
		if(!planner.try_plan_event(antag_event, world.time + (spawn_offset * i)))
			message_admins("[name] failed to execute initial antagonist goal [antag_event.name] ([i]/[spawn_count])")
	message_admins("[name] spawned [spawn_count] initial antagonists for population [pop]")
	return TRUE


/datum/storyteller/proc/try_spawn_midround_antagonist_wave(datum/storyteller_balance_snapshot/snap)
	if(!SSstorytellers.storyteller_replace_dynamic || HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		return

	var/balance_ratio = snap.balance_ratio
	var/antag_count = inputs.antag_count()
	var/antag_weight = inputs.antag_weight()
	var/player_weight = inputs.crew_weight()



	var/needs_antags = FALSE
	var/reason = ""
	if(antag_count <= 0 || snap.antag_weak || snap.antag_inactive || balance_ratio < 0.5 || (player_weight > 0 && antag_weight / player_weight < 0.3))
		needs_antags = TRUE
		reason = "imbalance detected (ratio: [balance_ratio], antag_weight: [antag_weight])"

	if(!needs_antags)
		message_admins("[name] skipped antag spawn - balanced (ratio: [balance_ratio])")
		return


	var/spawn_weight = calculate_antagonist_spawn_weight_wave(balance_ratio, snap, antag_weight, player_weight) * (mood ? mood.aggression : 1.0) * population_factor

	if(spawn_weight <= 0)
		return

	var/list/possible_candidates = SSstorytellers.filter_goals(STORY_GOAL_ANTAGONIST, STORY_TAG_MIDROUND)
	var/tags = mind.tokenize(STORY_GOAL_ANTAGONIST, src, inputs, snap, mood)
	var/spawn_count = clamp(round(spawn_weight / 20), 1, 3)


	for(var/i = 1 to spawn_count)
		var/datum/round_event_control/antag_event = mind.select_weighted_goal(src, inputs, snap, possible_candidates, population_factor, tags)
		if(!antag_event)
			continue

		// Delay scaled by mood.pace и traits
		var/spawn_offset = rand(30 SECONDS, 5 MINUTES) * (mood ? mood.pace : 1.0)
		if(HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN))
			spawn_offset *= 0.5
		else if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
			spawn_offset *= 1.5

		if(planner.try_plan_event(antag_event, world.time + spawn_offset))
			message_admins("[name] planned midround antag goal [antag_event.name] ([i]/[spawn_count]) - reason: [reason]")



/// Calculates desired roundstart antagonist count based on population and balance
/datum/storyteller/proc/calculate_roundstart_antag_count(pop, balance_ratio)
	var/count = 0
	// Base count on population
	if(pop >= population_threshold_full)
		count = 3
	else if(pop >= population_threshold_high)
		count = 2
	else if(pop >= population_threshold_medium)
		count = 1
	else
		count = 0

	var/adjustment_mult = 1.0
	if(balance_ratio < 0.4)
		adjustment_mult = 1.5  // Boost spawns if antags are very weak
	else if(balance_ratio > 1.3)
		adjustment_mult = 0.7  // Reduce spawns if antags are strong
	// Apply storyteller personality traits
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
		adjustment_mult *= 0.5
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
		adjustment_mult *= 1.5

	count = max(0, round(count * adjustment_mult))
	// Clamp to reasonable limits
	count = clamp(count, 0, 4)

	return count

/// Calculates spawn weight for wave-based antagonist spawning
/// Takes into account threat level, balance ratio, antag weight, and station stagnation
/datum/storyteller/proc/calculate_antagonist_spawn_weight_wave(balance_ratio, datum/storyteller_balance_snapshot/snap, antag_weight, player_weight)
	var/spawn_weight = 0.0

	// Base weight from balance ratio (how weak antags are relative to station)
	var/balance_factor = 0.0
	if(balance_ratio < 0.3)
		balance_factor = 50  // Very weak antags
	else if(balance_ratio < 0.5)
		balance_factor = 40  // Weak antags
	else if(balance_ratio < 0.8)
		balance_factor = 30  // Moderate
	else
		balance_factor = 15  // Somewhat balanced

	// Threat level factor (normalized threat points 0-1)
	var/threat_factor = clamp(threat_points / max_threat_scale, 0, 1) * 25  // Max 25 points

	// Antag weight factor (normalized antag weight relative to player weight)
	var/weight_ratio = player_weight > 0 ? (antag_weight / player_weight) : 1.0
	var/weight_factor = 0.0
	if(weight_ratio < 0.2)
		weight_factor = 30  // Very low antag weight
	else if(weight_ratio < 0.4)
		weight_factor = 20  // Low antag weight
	else if(weight_ratio < 0.6)
		weight_factor = 10  // Moderate
	else
		weight_factor = 5   // Adequate

	// Stagnation factor (low tension indicates station stagnation)
	var/stagnation_factor = 0.0
	var/tension_normalized = clamp(current_tension / 100.0, 0, 1)
	if(tension_normalized < 0.3)
		stagnation_factor = 20  // Low tension = stagnation
	else if(tension_normalized < 0.5)
		stagnation_factor = 10  // Moderate stagnation
	else
		stagnation_factor = 0   // Active, no stagnation

	// Combine factors
	spawn_weight = balance_factor + threat_factor + weight_factor + stagnation_factor

	// Adjust based on storyteller traits
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		spawn_weight = 0
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
		spawn_weight *= 0.5
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
		spawn_weight *= 1.5
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN))
		if(balance_ratio < 0.3 || antag_weight == 0)
			spawn_weight *= 2.0

	// Boost if current antags are inactive or weak
	if(snap.antag_inactive)
		spawn_weight *= 1.5
	if(snap.antag_weak)
		spawn_weight *= 1.3

	// Adjust by mood aggression
	if(mood)
		spawn_weight *= clamp(mood.aggression, 0.5, 1.5)

	return clamp(spawn_weight, 0, 100)
