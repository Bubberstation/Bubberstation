#define NORMALIZE(value, max_val) clamp((value) / (max_val), 0, 1)


#define WEAK_ANTAG_THRESHOLD 0.5
#define INACTIVE_ACTIVITY_THRESHOLD 0.25
#define MAX_TENSION_BONUS 20

/datum/storyteller_balance
	VAR_PRIVATE/datum/storyteller/owner
	var/tension_bonus = 0

/datum/storyteller_balance/New(datum/storyteller/owner_storyteller)
	. = ..()
	owner = owner_storyteller

/datum/storyteller_balance/proc/get_tension_bonus()
	tension_bonus = 0
	var/final_bonus = 0

	for(var/list/event_data in owner.recent_events)
		var/evt_id = event_data["id"]
		var/datum/round_event_control/evt = SSstorytellers.get_event_by_id(evt_id)
		if(!evt)
			continue
		var/has_escalation = evt.has_tag(STORY_TAG_ESCALATION)
		var/has_deescalation = evt.has_tag(STORY_TAG_DEESCALATION)
		if(has_escalation)
			final_bonus += 2
		if(has_deescalation)
			final_bonus -= 2

		if(evt.story_category & STORY_GOAL_BAD)
			final_bonus += 1

	tension_bonus = clamp(final_bonus, 0, MAX_TENSION_BONUS)
	return tension_bonus

// How many sec officers we consider "very strong security"
#define SECURITY_MAX_COUNT 8

/datum/storyteller_balance/proc/make_snapshot(datum/storyteller_inputs/inputs)
	SHOULD_NOT_OVERRIDE(TRUE)

	var/datum/storyteller_balance_snapshot/snap = new()

	// Get basic metrics from vault
	var/crew_count = inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT) || 0
	var/security_count = inputs.get_entry(STORY_VAULT_SECURITY_COUNT) || 0
	var/station_integrity = inputs.get_entry(STORY_VAULT_STATION_INTEGRITY) || 100
	var/cargo_points = inputs.get_entry(STORY_VAULT_RESOURCE_OTHER) || 0
	var/minerals = inputs.get_entry(STORY_VAULT_RESOURCE_MINERALS) || 0
	var/crew_health = inputs.get_entry(STORY_VAULT_AVG_CREW_HEALTH) || 100
	var/power_strength = inputs.get_entry(STORY_VAULT_POWER_GRID_STRENGTH) || 100
	var/research_progress = inputs.get_entry(STORY_VAULT_RESEARCH_PROGRESS) || STORY_VAULT_LOW_RESEARCH

	// Get antagonist metrics
	var/antag_count = inputs.get_entry(STORY_VAULT_ANTAG_ALIVE_COUNT) || 0
	var/antag_weight = inputs.get_entry(STORY_VAULT_ANTAG_WEIGHT) || 0
	var/antag_presence = inputs.get_entry(STORY_VAULT_ANTAGONIST_PRESENCE) || 0
	var/crew_weight = inputs.get_entry(STORY_VAULT_CREW_WEIGHT) || 0

	// Calculate station strength factors (normalized 0-1)
	var/health_factor = clamp(crew_health / 100, 0, 1)
	var/integrity_factor = clamp(station_integrity / 100, 0, 1)
	var/power_factor = clamp(power_strength / 100, 0, 1)
	var/resource_factor = clamp((cargo_points / 100000 + minerals / 500) / 2, 0, 1)
	var/research_factor = clamp(research_progress / STORY_VAULT_ADVANCED_RESEARCH, 0, 1)
	var/crew_size_factor = clamp(crew_count / owner.population_threshold_full, 0, 1)
	var/security_factor = clamp(security_count / SECURITY_MAX_COUNT, 0, 1)

	// Calculate overall station strength (weighted average)
	var/station_strength_raw = (health_factor * 0.25) + (integrity_factor * 0.20) + (power_factor * 0.15) + \
		(resource_factor * 0.15) + (research_factor * 0.10) + (crew_size_factor * 0.10) + (security_factor * 0.05)
	var/station_strength_norm = clamp(station_strength_raw, 0, 1)

	// Calculate antagonist strength
	var/antag_activity_norm = clamp(antag_presence / STORY_VAULT_MANY_ANTAGONISTS, 0, 1)
	var/antag_weight_normalized = antag_count > 0 ? clamp(antag_weight / crew_weight, 0, 2) : 0
	var/antag_strength_raw = (antag_activity_norm * 0.25) + (antag_weight_normalized * 0.25)
	var/antag_strength_norm = clamp(antag_strength_raw, 0, 1)

	// Calculate balance ratio (antag strength / station strength, higher = antags stronger)
	var/balance_ratio = station_strength_norm > 0 ? clamp(antag_strength_norm / station_strength_norm, 0, 1) : 0

	// Calculate antag activity index (0-1), without inactive ratio since it's not in original inputs
	var/antag_activity_index = antag_activity_norm

	// Check if antags are weak or inactive
	snap.antag_weak = antag_weight_normalized < WEAK_ANTAG_THRESHOLD
	snap.antag_inactive = antag_activity_index < INACTIVE_ACTIVITY_THRESHOLD

	// Store values in snapshot
	snap.strengths["station"] = station_strength_norm
	snap.strengths["station_raw"] = station_strength_raw
	snap.strengths["antag"] = antag_strength_norm
	snap.strengths["antag_raw"] = antag_strength_raw
	snap.weights["player"] = crew_weight
	snap.weights["antag"] = antag_weight
	snap.balance_ratio = balance_ratio
	snap.antag_activity_index = antag_activity_index
	snap.resource_strength = resource_factor

	// Calculate overall tension (will be refined in calculate_overall_tension)
	snap.overall_tension = calculate_overall_tension(inputs, snap)

	return snap

// Tension calculation tuning constants
#define BASE_TENSION 8.0

#define SECURITY_WEIGHT 30.0
#define SECURITY_POWER 1.1

#define INTEGRITY_WEIGHT 40.0
#define INTEGRITY_POWER 1.8

#define BIAS_WEIGHT 35.0

#define ACTIVITY_WEIGHT 15.0

#define RESOURCE_WEIGHT 8.0
#define HEALTH_WEIGHT 20.0

// How much random jitter we add at the very end
#define TENSION_JITTER_MIN -2
#define TENSION_JITTER_MAX 2


/// Calculate overall tension
/// Returns number between 0 and 100
/datum/storyteller_balance/proc/calculate_overall_tension(datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/snap)
	PRIVATE_PROC(TRUE)

	var/tension_bonus = get_tension_bonus()

	//Raw values from vault
	var/station_integrity = inputs.get_entry(STORY_VAULT_STATION_INTEGRITY) || 100
	var/crew_health = inputs.get_entry(STORY_VAULT_AVG_CREW_HEALTH)   || 100
	var/security_count = inputs.get_entry(STORY_VAULT_SECURITY_COUNT)    || 0

	//Normalized (0→1)
	var/integrity_factor = clamp(station_integrity / 100, 0, 1)
	var/health_factor = clamp(crew_health / 100, 0, 1)
	var/security_factor = clamp(security_count / SECURITY_MAX_COUNT, 0, 1)

	// The worse the situation — the bigger the penalty
	var/inverse_integrity = 1 - integrity_factor
	var/inverse_health = 1 - health_factor
	var/inverse_security = 1 - security_factor

	// Resources — the more we have, the less tension
	var/raw_resources = inputs.get_entry(STORY_VAULT_RESOURCE_OTHER) / 100000.0 + \
						inputs.get_entry(STORY_VAULT_RESOURCE_MINERALS) / 500.0

	var/resource_factor = clamp(raw_resources, 0, 1)
	var/inverse_resources = 1 - resource_factor

	//Penalties
	var/security_penalty  = inverse_security * SECURITY_POWER  * SECURITY_WEIGHT
	if(owner.population_factor < 0.5)
		security_penalty *= 1.2
	else if(owner.population_factor < 0.3)
		security_penalty *= 1.6
	else
		security_penalty *= 0.6
	var/integrity_penalty = inverse_integrity * INTEGRITY_POWER * INTEGRITY_WEIGHT
	if(owner.population_factor < 0.5)
		integrity_penalty *= 1.2
	else if(owner.population_factor < 0.3)
		integrity_penalty *= 1.6
	else
		integrity_penalty *= 0.8

	//Balance bias based on balance ratio (-BIAS_WEIGHT, +BIAS_WEIGHT)
	var/antag_bias = max(snap.balance_ratio - 1, 0.1)
	var/bias_penalty = -(antag_bias * BIAS_WEIGHT)

	var/activity_modifier = snap.antag_activity_index * ACTIVITY_WEIGHT

	var/resource_penalty = inverse_resources * RESOURCE_WEIGHT
	var/health_penalty   = inverse_health   * HEALTH_WEIGHT
	if(owner.population_factor < 0.5)
		health_penalty *= 1.4
	else if(owner.population_factor < 0.3)
		health_penalty *= 2
	else
		health_penalty *= 0.9

	//Final calculation
	var/final_tension = BASE_TENSION \
	                  + security_penalty \
	                  + integrity_penalty \
	                  + bias_penalty \
	                  + activity_modifier \
	                  + resource_penalty \
	                  + health_penalty \
	                  + tension_bonus

	// Small random jitter so tension doesn't sit perfectly still
	final_tension += rand(TENSION_JITTER_MIN, TENSION_JITTER_MAX)

	return clamp(final_tension, 0, 100)


#undef BASE_TENSION
#undef SECURITY_WEIGHT
#undef SECURITY_POWER
#undef INTEGRITY_WEIGHT
#undef INTEGRITY_POWER
#undef BIAS_WEIGHT
#undef ACTIVITY_WEIGHT
#undef RESOURCE_WEIGHT
#undef HEALTH_WEIGHT
#undef TENSION_JITTER_MIN
#undef TENSION_JITTER_MAX
#undef SECURITY_MAX_COUNT

/datum/storyteller_balance_snapshot
	var/list/strengths = list()  // "station": norm, "station_raw": raw, "antag": norm, "antag_raw": raw
	var/list/weights = list()	// "player": total, "antag": total
	var/balance_ratio = 1.0
	var/overall_tension = 50
	var/antag_activity_index = 0
	var/antag_weak = FALSE
	var/antag_inactive = FALSE
	var/resource_strength = 0
	var/list/flags = list()

/// Get antagonist advantage
/datum/storyteller_balance_snapshot/proc/get_antag_advantage()
	return balance_ratio * strengths["antag"]

/// Get tension product
/datum/storyteller_balance_snapshot/proc/get_tension_product()
	return (overall_tension / 100) * antag_activity_index

/// Get station resilience
/datum/storyteller_balance_snapshot/proc/get_station_resilience()
	return strengths["station"] * resource_strength

/// Get weight ratio
/datum/storyteller_balance_snapshot/proc/get_weight_ratio()
	return weights["antag"] / max(weights["player"], 1)

#undef NORMALIZE
#undef WEAK_ANTAG_THRESHOLD
#undef INACTIVE_ACTIVITY_THRESHOLD
#undef MAX_TENSION_BONUS
