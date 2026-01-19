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
	var/crew_weight = inputs.get_entry(STORY_VAULT_CREW_WEIGHT) || 0
	var/antag_activity = inputs.get_entry(STORY_VAULT_ANTAGONIST_ACTIVITY) || STORY_VAULT_NO_ACTIVITY
	var/antag_inactive_ratio = inputs.get_entry(STORY_VAULT_ANTAG_INACTIVE_RATIO) || 0

	// Calculate station strength factors (normalized 0-1)
	var/health_factor = NORMALIZE(crew_count > 0 ? crew_health / 100.0 : 1.0, 1.0)
	var/integrity_factor = NORMALIZE(station_integrity, 100.0)
	var/power_factor = NORMALIZE(power_strength, 100.0)

	// Resource factor: cargo points normalized to 100k, minerals to 10k
	var/resource_factor = NORMALIZE((cargo_points / 100000.0) + (minerals / 10000.0), 1.0)

	// Research factor: normalize 0-3 scale to 0-1
	var/research_factor = NORMALIZE(research_progress, STORY_VAULT_ADVANCED_RESEARCH)

	// Crew size factor: normalize to reasonable max (50 crew = 1.0)
	var/crew_size_factor = NORMALIZE(crew_count, 50.0)

	// Security factor: normalize to reasonable max (10 sec = 1.0)
	var/security_factor = NORMALIZE(security_count, 10.0)

	// Calculate overall station strength (weighted average)
	var/station_strength_raw = (health_factor * 0.25) + (integrity_factor * 0.20) + (power_factor * 0.15) + \
		(resource_factor * 0.15) + (research_factor * 0.10) + (crew_size_factor * 0.10) + (security_factor * 0.05)
	var/station_strength_norm = clamp(station_strength_raw, 0, 1)

	// Calculate antagonist strength
	var/antag_activity_norm = NORMALIZE(antag_activity, STORY_VAULT_HIGH_ACTIVITY)
	var/antag_weight_normalized = antag_count > 0 ? (antag_weight / max(crew_weight, 1)) : 0
	var/antag_strength_raw = (antag_activity_norm * 0.6) + (clamp(antag_weight_normalized, 0, 2) * 0.4)
	var/antag_strength_norm = clamp(antag_strength_raw, 0, 1)

	// Calculate balance ratio (antag strength / station strength, inverted so higher = station stronger)
	var/balance_ratio = station_strength_norm > 0 ? (antag_strength_norm / station_strength_norm) : 1.0

	// Calculate antag activity index (0-1)
	var/antag_activity_index = antag_activity_norm * (1.0 - antag_inactive_ratio)

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

/// Calculate overall tension
/datum/storyteller_balance/proc/calculate_overall_tension(datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/snap)
	PRIVATE_PROC(TRUE)

	// Base tension starts at 20 (neutral)
	var/base_tension = 20.0

	// Get tension bonus from recent events
	var/tension_bonus = get_tension_bonus()

	// Retrieve relevant factors
	var/station_integrity = inputs.get_entry(STORY_VAULT_STATION_INTEGRITY) || 100
	var/crew_health = inputs.get_entry(STORY_VAULT_AVG_CREW_HEALTH) || 100
	var/security_count = inputs.get_entry(STORY_VAULT_SECURITY_COUNT) || 0
	var/cargo_points = inputs.get_entry(STORY_VAULT_RESOURCE_OTHER) || 0
	var/minerals = inputs.get_entry(STORY_VAULT_RESOURCE_MINERALS) || 0

	// Normalize factors to 0-1 scale
	var/integrity_factor = NORMALIZE(station_integrity, 100.0)
	var/health_factor = NORMALIZE(crew_health, 100.0)
	var/security_factor = NORMALIZE(security_count, 10.0)
	var/resource_factor = NORMALIZE((cargo_points / 100000.0) + (minerals / 10000.0), 1.0)

	// Calculate inverse factors for tension (low value -> high tension contribution)
	var/inverse_integrity = 1.0 - integrity_factor
	var/inverse_health = 1.0 - health_factor
	var/inverse_security = 1.0 - security_factor
	var/inverse_resources = 1.0 - resource_factor

	// Antag bias modifier: higher balance_ratio means antags stronger, higher tension
	// Scale the excess over 1.0 (neutral)
	var/antag_bias_modifier = max(snap.balance_ratio - 1.0, 0)  // Only positive bias contributes

	// Apply weights for contributions
	var/security_modifier = inverse_security * 25.0
	var/integrity_modifier = inverse_integrity * 25.0
	var/bias_modifier = antag_bias_modifier * 25.0
	var/health_modifier = inverse_health * 10.0
	var/resources_modifier = inverse_resources * 10.0

	// Include antag activity for additional context
	var/activity_modifier = snap.antag_activity_index * 10.0

	// Calculate final tension
	var/final_tension = base_tension + security_modifier + integrity_modifier + bias_modifier + \
		health_modifier + resources_modifier + activity_modifier + tension_bonus
	return clamp(final_tension, 0, 100)


// Balance snapshot datum
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
