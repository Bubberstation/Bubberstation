/**
 * Storyteller antagonist spawning logic
 */

#define BALANCE_LOW 0.2
#define BALANCE_MED 0.5
#define BALANCE_HIGH 0.8
#define WEIGHT_LOW 0.2
#define WEIGHT_MED 0.4
#define WEIGHT_HIGH 0.6
#define TENSION_LOW 0.3
#define TENSION_MED 0.5

/// Calculates desired roundstart antagonist count based on population and balance
/datum/storyteller/proc/calculate_roundstart_antag_count(pop)
	var/count = 0
	var/security_count = inputs.get_entry(STORY_VAULT_SECURITY_COUNT) || 0
	// Base count on population
	if(pop >= population_threshold_full)
		count = 3
	else if(pop >= population_threshold_high)
		count = 2
	else if(pop >= population_threshold_medium)
		count = 1
	else
		count = 0

	var/ignore_security = (HAS_TRAIT(src, STORYTELLER_TRAIT_NO_MERCY) || HAS_TRAIT(src, STORYTELLER_TRAIT_IGNORE_SECURITY))
	if(security_count <= 0 && (ignore_security || difficulty_multiplier > 1.0))
		security_count = 1
	if(security_count <= 0)
		return 0  // No security, no antags

	var/adjustment_mult = 1.0
	if(security_count == 1 && !ignore_security)
		adjustment_mult = 0.5
	else if(security_count >= 5)
		adjustment_mult = 1.3
	// Apply storyteller personality traits
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
		adjustment_mult *= 0.5
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
		adjustment_mult *= 1.5

	count = max(0, round(count * adjustment_mult))
	// Clamp to reasonable limits
	count = clamp(count, 0, 4)
	return count


/datum/storyteller/proc/spawn_initial_antagonists()
	if(!SSstorytellers?.storyteller_replace_dynamic)
		return

	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		if(SSstorytellers.hard_debug)
			message_admins("[name] skipped initial antagonist spawn because of NO_ANTAGS trait")
		return TRUE

	var/pop = inputs.player_count()
	if(pop < population_threshold_low && !HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN))
		message_admins("[name] replan initial antagonist spawn because of insufficient population")
		roundstart_antag_selection_time = world.time + 10 MINUTES
		return FALSE
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN))
		message_admins("[name] there is insufficient population but [name] spawns initial antagonists due to IMMEDIATE_ANTAG_SPAWN trait")


	var/list/possible_candidates = SSstorytellers.filter_goals(STORY_GOAL_ANTAGONIST, STORY_TAG_ROUNDSTART, STORY_TAGS_MATCH)
	if(!length(possible_candidates))
		message_admins("[name] failed to spawn initial antagonists - no available roundstart antagonist events")
		return TRUE

	for(var/datum/round_event_control/ev in possible_candidates)
		if(ev.story_category & STORY_GOAL_MAJOR)
			if(HAS_TRAIT(src, STORYTELLER_TRAIT_MAJOR_ANTAGONISTS))
				continue
			if((pop > population_threshold_low) || HAS_TRAIT(src, STORYTELLER_TRAIT_NO_MERCY))
				continue
			possible_candidates -= ev
	var/datum/storyteller_balance_snapshot/bal = balancer.make_snapshot(inputs)
	var/tags = behevour.tokenize(STORY_GOAL_ANTAGONIST, inputs, bal, mood)
	var/spawn_count = calculate_roundstart_antag_count(pop)
	if(spawn_count <= 0)
		message_admins("[name] skipped initial antagonist spawn - no antagonists needed!")
		return TRUE

	for(var/i = 1 to spawn_count)
		var/datum/round_event_control/antag_event = behevour.select_weighted_goal(inputs, bal, possible_candidates, population_factor, tags)
		if(!antag_event)
			log_storyteller("[name] failed to select initial antagonist goal!")
			continue
		var/spawn_offset = rand(45 SECONDS, 120 SECONDS)
		if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
			spawn_offset *= 0.7
		if(!planner.try_plan_event(antag_event, world.time + (spawn_offset * i)))
			message_admins("[name] failed to execute initial antagonist goal [antag_event.name]!")
			continue
		if(antag_event.story_category & STORY_GOAL_MAJOR)
			possible_candidates -= antag_event
			if(!HAS_TRAIT(src, STORYTELLER_TRAIT_NO_MERCY))
				break

	message_admins("[name] spawned [spawn_count] initial antagonists for population [pop]")
	return TRUE



/// Calculates spawn weight for wave-based antagonist spawning
/// Takes into account threat level, balance ratio, antag weight, and station stagnation
/datum/storyteller/proc/calculate_antagonist_spawn_weight_wave(datum/storyteller_balance_snapshot/snap, antag_weight, player_weight)
	var/spawn_weight = 0.0
	var/balance_ratio = snap.balance_ratio


	// Balance factor: higher when antags are weaker relative to station
	var/balance_factor = 0.0
	if(balance_ratio < BALANCE_LOW)
		balance_factor += 50
	else if(balance_ratio < BALANCE_MED)
		balance_factor += 30
	else if(balance_ratio < BALANCE_HIGH)
		balance_factor += 20
	else
		// Somewhat balanced
		balance_factor += 10
	// Threat factor: increases with current threat level
	var/threat_factor = clamp(threat_points / max_threat_scale, 0, 1) * 15  // Max 15 points
	// Weight factor: higher when antag weight is low relative to players
	var/weight_ratio = player_weight > 0 ? (antag_weight * 2 / player_weight) : 1.0

	var/weight_factor = 0.0
	if(weight_ratio < WEIGHT_LOW)
		weight_factor = 25  // Very low antag weight
	else if(weight_ratio < WEIGHT_MED)
		weight_factor = 15  // Low antag weight
	else if(weight_ratio < WEIGHT_HIGH)
		weight_factor = 10  // Moderate
	else
		weight_factor = 5   // Adequate

	// Stagnation factor: higher when tension is low (station stagnant)
	var/stagnation_factor
	var/tension_normalized = clamp(current_tension / 100.0, 0, 1)
	if(tension_normalized < TENSION_LOW)
		stagnation_factor = 15  // Low tension = stagnation
	else if(tension_normalized < TENSION_MED)
		stagnation_factor = 5  // Moderate stagnation
	else
		stagnation_factor = 0   // Active, no stagnation
	// Combine factors
	spawn_weight = min(balance_factor + threat_factor + weight_factor + stagnation_factor, STORY_MAJOR_ANTAG_WEIGHT)


	// Adjust based on storyteller traits
	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		spawn_weight = 0
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
		spawn_weight *= 0.5
	else if(HAS_TRAIT(src, STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN))
		spawn_weight *= 1.2

	if(HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN) && balance_ratio < 0.3)
		spawn_weight *= 1.4

	// Boost if current antags are inactive or weak
	if(snap.antag_weak)
		spawn_weight *= 1.2
	spawn_weight *= clamp(mood.aggression, 0.5, 1.5)
	return clamp(spawn_weight, 0, 100)

/// Checks antagonist balance and spawns midround antagonists in waves if needed
/// Called approximately every ~30 minutes based on cooldown
/// Uses threat level, balance ratio, and antag weight to determine if spawns are needed
/datum/storyteller/proc/check_and_spawn_antagonists(datum/storyteller_balance_snapshot/snap, force = FALSE)
	if(!SSstorytellers.storyteller_replace_dynamic && !force)
		return

	if(HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS) && !force)
		return
	if(determine_greenshift_status())
		if(force)
			message_admins("[name] skipped antagonist spawn wave due to greenshift, change difficulty to allow spawns")
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
		if(population_factor <= population_factor_low && !HAS_TRAIT(src, STORYTELLER_TRAIT_NO_MERCY))
			needs_antags = FALSE
			reason = "insufficient population!"
		else if(antag_count <= 0 && target_player_antag_balance > 20)
			needs_antags = TRUE
			reason = "no antagonists"
		else if(snap.antag_weak && (player_antag_balance < 50 || prob(30 * mood.get_threat_multiplier())))
			needs_antags = TRUE
			reason = "antagonists too weak"
		else if(balance_ratio < 0.4)
			needs_antags = TRUE
			reason = "antagonists too weak relative to station (ratio: [balance_ratio])"
		else if(player_weight > 0 && antag_weight / player_weight < 0.4)
			needs_antags = TRUE
			reason = "antagonist weight too low (antag: [antag_weight], players: [player_weight])"
		if(!needs_antags)
			message_admins("[name] skipped antagonist spawn wave because of [reason]")
			return
	else
		needs_antags = TRUE
		message_admins("[name] forced antagonist spawn wave!")

	// Calculate spawn weight based on threat level, balance ratio, and antag weight
	var/spawn_weight = calculate_antagonist_spawn_weight_wave(snap, antag_weight, player_weight)
	if(spawn_weight <= 0 && !force)
		return
	else if(force)
		message_admins("[name] is forcing antagonist spawn wave despite low spawn weight ([spawn_weight]). Aborting!")
		return
	INVOKE_ASYNC(src, PROC_REF(try_spawn_midround_antagonist_wave), snap, spawn_weight)




/datum/storyteller/proc/try_spawn_midround_antagonist_wave(datum/storyteller_balance_snapshot/snap, wave_weight)
	if(!SSstorytellers.storyteller_replace_dynamic || HAS_TRAIT(src, STORYTELLER_TRAIT_NO_ANTAGS))
		return
	if(wave_weight <= 0)
		return

	var/list/possible_candidates = SSstorytellers.filter_goals(STORY_GOAL_ANTAGONIST, STORY_TAG_MIDROUND)
	if(!length(possible_candidates))
		log_storyteller("[name] skipped antag spawn - no available midround antagonist events")
		return

	var/tags = behevour.tokenize(STORY_GOAL_ANTAGONIST, inputs, snap, mood)
	var/list/valid_candidates = list()
	for(var/datum/round_event_control/ev in possible_candidates)
		var/ev_weight = ev.get_story_weight(inputs, snap)
		if(ev_weight <= 0)
			continue
		if(!behevour.is_event_valid_for_behevour(ev, snap, inputs))
			continue
		valid_candidates[ev] = ev_weight

	if(!length(valid_candidates))
		log_storyteller("[name] skipped midround antag wave - no valid candidates after filtering")
		return
	var/spawned_count = 0
	var/max_attempts = 25

	while(wave_weight > 0 && length(valid_candidates) > 0 && max_attempts > 0)
		max_attempts--

		var/datum/round_event_control/chosen = behevour.select_weighted_goal(inputs, snap, valid_candidates, population_factor, tags)
		if(!chosen)
			break
		var/cost = valid_candidates[chosen]

		if(cost > wave_weight)
			valid_candidates -= chosen
			continue

		if(planner.is_event_in_timeline(chosen) && !prob(50))
			valid_candidates -= chosen
			continue

		var/spawn_offset = rand(30 SECONDS, 5 MINUTES) * (mood ? mood.pace : 1.0)
		if(HAS_TRAIT(src, STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN))
			spawn_offset *= 0.5
		else if(HAS_TRAIT(src, STORYTELLER_TRAIT_RARE_ANTAG_SPAWN))
			spawn_offset *= 1.5

		if(planner.try_plan_event(chosen, world.time + spawn_offset))
			spawned_count++
			wave_weight -= cost
		else
			valid_candidates -= chosen

	if(spawned_count > 0)
		message_admins("[name] spawned [spawned_count] midround antagonists with [wave_weight] remaining wave weight")
		log_storyteller("[name] spawned [spawned_count] midround antagonists with [wave_weight] remaining wave weight")
	else
		message_admins("[name] failed to spawn any midround antagonists despite [wave_weight] wave weight")


#undef BALANCE_LOW
#undef BALANCE_MED
#undef BALANCE_HIGH
#undef WEIGHT_LOW
#undef WEIGHT_MED
#undef WEIGHT_HIGH
#undef TENSION_LOW
#undef TENSION_MED
