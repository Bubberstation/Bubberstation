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
	var/tension = get_tension_bonus()

	var/crew_count = inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT) || 0
	var/security_count = inputs.get_entry(STORY_VAULT_SECURITY_COUNT) || 0
	var/station_integrity = inputs.get_entry(STORY_VAULT_STATION_INTEGRITY) || 0
	var/resource_strength = inputs.get_entry(STORY_VAULT_)

	var/vault = inputs.vault
	var/crew_count = vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0
	var/security_count = vault[STORY_VAULT_SECURITY_COUNT] || 0
	var/crew_health = vault[STORY_VAULT_AVG_CREW_HEALTH] || 100
	var/integrity = inputs.get_station_integrity() || 100


	snap.strengths["station_raw"] = (
		(crew_count / 60.0 * 100) * 0.3 + \
		(security_count / max(crew_count * 0.2, 1) * 100) * 0.3 + \
		crew_health * 0.2 + \
		integrity * 0.2
	)


	var/research = vault[STORY_VAULT_RESEARCH_PROGRESS] || 0
	if(research >= STORY_VAULT_HIGH_RESEARCH)
		snap.strengths["station_raw"] *= 1.15
	else if(research <= STORY_VAULT_LOW_RESEARCH)
		snap.strengths["station_raw"] *= 0.7

	var/minerals = vault[STORY_VAULT_RESOURCE_MINERALS] || 0
	if(minerals < 250)
		snap.strengths["station_raw"] *= 0.9

	snap.strengths["station"] = NORMALIZE(clamp(snap.strengths["station_raw"], 0, 100), 100)

	// Simplified antag strength: activity + presence
	var/antag_count = inputs.antag_count()
	if(antag_count <= 0)
		snap.strengths["antag_raw"] = 0
		snap.strengths["antag"] = 0
	else
		var/activity = NORMALIZE(vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || 0, 3)
		var/presence = NORMALIZE(vault[STORY_VAULT_ANTAGONIST_PRESENCE] || 0, 3)
		var/kills = NORMALIZE(vault[STORY_VAULT_ANTAG_KILLS] || 0, 3)

		snap.strengths["antag_raw"] = (activity * 0.5 + presence * 0.3 + kills * 0.2) * 100
		snap.strengths["antag"] = NORMALIZE(snap.strengths["antag_raw"], 100)


	snap.weights["player"] = crew_count * STORY_BALANCER_PLAYER_WEIGHT * snap.strengths["station"]
	snap.weights["antag"] = antag_count * STORY_BALANCER_ANTAG_WEIGHT * snap.strengths["antag"]


	snap.balance_ratio = snap.strengths["antag_raw"] / max(snap.strengths["station_raw"], 1)


	snap.antag_activity_index = NORMALIZE(vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || 0, 3)
	snap.antag_weak = snap.strengths["antag"] < WEAK_ANTAG_THRESHOLD
	snap.antag_inactive = snap.antag_activity_index < INACTIVE_ACTIVITY_THRESHOLD


	snap.overall_tension = calculate_overall_tension(inputs, snap)

	// Flags
	snap.flags = list(
		"antag_coordinated" = NORMALIZE(vault[STORY_VAULT_ANTAG_TEAMWORK] || 0, 3) > 0.5,
		"station_vulnerable" = snap.strengths["station"] < 0.5
	)

	// Resource strength (simplified)
	var/other_res = vault[STORY_VAULT_RESOURCE_OTHER] || 0
	snap.resource_strength = NORMALIZE(minerals / 1000 + other_res / 100000, 1)

	return snap

/// Calculate overall tension (simplified)
/datum/storyteller_balance/proc/calculate_overall_tension(datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/snap)
	PRIVATE_PROC(TRUE)
	var/vault = inputs.vault

	var/base = NORMALIZE(tension_bonus, MAX_TENSION_BONUS) * 30 * (1 - owner.adaptation_factor)

	var/antag_contrib = snap.strengths["antag"] * 40

	var/crew_health = vault[STORY_VAULT_AVG_CREW_HEALTH] || 100
	var/health_tension = (100 - crew_health) * 0.3


	var/integrity = inputs.get_station_integrity() || 100
	var/integrity_tension = (100 - integrity) * 0.2

	var/dead_ratio = NORMALIZE(vault[STORY_VAULT_CREW_DEAD_RATIO] || 0, STORY_VAULT_EXTREME_DEAD_RATIO)
	var/death_tension = dead_ratio * 20


	var/ratio_tension = clamp((snap.balance_ratio - 1) * 10, 0, 15)

	return clamp(base + antag_contrib + health_tension + integrity_tension + death_tension + ratio_tension, 0, 100)

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
