#define NORMALIZE(value, max_val) clamp((value) / (max_val), 0, 1)
#define INVERT_NORMALIZE(value, max_val) (1 - NORMALIZE(value, max_val))

#define WEAK_ANTAG_THRESHOLD 0.5
#define INACTIVE_ACTIVITY_THRESHOLD 0.25
#define STATION_STRENGTH_MULTIPLIER 1.0
#define MAX_TENSION_BONUS 30

#define INTEGRITY_WEIGHTS list( \
	"hull" = 0.4, \
	"infra" = 0.3, \
	"power" = 0.3 \
)
#define INTEGRITY_TENSION_MIN -20
#define INTEGRITY_TENSION_MAX 50

#define HEALTH_WEIGHTS list( \
	"health" = 0.4, \
	"wounds" = 0.3, \
	"diseases" = 0.2, \
	"dead" = 0.1 \
)
#define HEALTH_TENSION_MAX 35
#define WOUNDING_CRITICAL_THRESHOLD 3

#define STATION_STRENGTH_WEIGHTS list( \
	"crew_capability" = 0.4, \
	"security" = 0.35, \
	"crew_health" = 0.15, \
	"infra" = 0.10 \
)

#define ANTAG_STRENGTH_WEIGHTS list( \
	"activity" = 0.15, \
	"kills" = 0.10, \
	"objectives" = 0.15, \
	"disruption" = 0.10, \
	"influence" = 0.10, \
	"intensity" = 0.10, \
	"teamwork" = 0.05, \
	"escalation" = 0.10, \
	"stealth" = 0.05 \
)

#define ANTAG_MODIFIERS_WEIGHTS list( \
	"presence" = 0.15, \
	"survival" = 0.20, \
	"activity" = 0.25 \
)
#define ANTAG_CORE_WEIGHT 0.6
#define ANTAG_MOD_WEIGHT 0.4


/datum/storyteller_balance
	VAR_PRIVATE/datum/storyteller/owner
	var/tension_bonus = 0

/datum/storyteller_balance/New(_owner)
	owner = _owner
	..()

/datum/storyteller_balance/proc/make_snapshot(datum/storyteller_inputs/inputs)
	var/datum/storyteller_balance_snapshot/snap = new

	// Station metrics
	snap.strengths["station_raw"] = calculate_station_strength(inputs)
	snap.strengths["station"] = NORMALIZE(snap.strengths["station_raw"], 100)

	// Antag metrics
	snap.strengths["antag_raw"] = calculate_antag_strength(inputs)
	snap.strengths["antag"] = NORMALIZE(snap.strengths["antag_raw"], 100)

	// Weights
	snap.weights["player"] = calculate_total_player_weight(inputs, snap.strengths["station"])
	snap.weights["antag"] = calculate_total_antag_weight(inputs, snap.strengths["antag"])

	// Ratios and indices
	snap.balance_ratio = snap.strengths["antag_raw"] / max(snap.strengths["station_raw"], 1)
	snap.antag_activity_index = NORMALIZE(inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || 0, 3)
	snap.antag_weak = snap.strengths["antag"] < WEAK_ANTAG_THRESHOLD
	snap.antag_inactive = snap.antag_activity_index < INACTIVE_ACTIVITY_THRESHOLD

	// Tension
	snap.overall_tension = calculate_overall_tension(inputs, snap)


	snap.flags = list(
		"antag_coordinated" = NORMALIZE(inputs.vault[STORY_VAULT_ANTAG_TEAMWORK] || 0, 3) > 0.5,
		"antag_stealthy" = NORMALIZE(inputs.vault[STORY_VAULT_ANTAG_STEALTH] || 0, 3) > 0.5,
		"station_vulnerable" = snap.strengths["station"] < 0.5
	)

	// Resources
	snap.resource_strength = calculate_resource_strength(inputs.vault)

	return snap

/datum/storyteller_balance/proc/calculate_weighted_sum(values_list, weights_list)
	PRIVATE_PROC(TRUE)
	var/sum = 0
	for (var/key in values_list)
		if (weights_list[key])
			sum += values_list[key] * weights_list[key]
	return sum

/datum/storyteller_balance/proc/calculate_station_strength(datum/storyteller_inputs/inputs)
	PRIVATE_PROC(TRUE)
	var/vault = inputs.vault

	var/crew_capability = calculate_crew_capability(inputs, vault)
	var/security = calculate_security_contribution(inputs, vault)
	var/crew_health = vault[STORY_VAULT_AVG_CREW_HEALTH] || 100
	var/infra = inputs.get_station_integrity() || 100

	var/contributions = list(
		"crew_capability" = crew_capability,
		"security" = security,
		"crew_health" = crew_health,
		"infra" = infra
	)

	var/strength = calculate_weighted_sum(contributions, STATION_STRENGTH_WEIGHTS)
	strength *= calculate_strength_multiplier(inputs, vault)

	return clamp(strength, 0, 100)

/datum/storyteller_balance/proc/calculate_crew_capability(datum/storyteller_inputs/inputs, list/vault)
	PRIVATE_PROC(TRUE)
	var/readiness = NORMALIZE(vault[STORY_VAULT_CREW_READINESS] || 0, 3)
	var/avg_weight = clamp((inputs.crew_weight() || STORY_BALANCER_PLAYER_WEIGHT) * 2.5, 0, 100)
	return (avg_weight * 0.6) + (readiness * 100 * 0.4)  // Weighted average

/datum/storyteller_balance/proc/calculate_security_contribution(datum/storyteller_inputs/inputs, list/vault)
	PRIVATE_PROC(TRUE)
	var/total_crew = vault[STORY_VAULT_CREW_ALIVE_COUNT] || 1
	var/max_sec = max(total_crew * 0.2, 20)
	var/count_norm = NORMALIZE(vault[STORY_VAULT_SECURITY_COUNT] || 0, max_sec) * 100
	var/strength_norm = NORMALIZE(vault[STORY_VAULT_SECURITY_STRENGTH] || 0, 3) * 100
	return (count_norm * 0.6) + (strength_norm * 0.4)

/datum/storyteller_balance/proc/calculate_strength_multiplier(datum/storyteller_inputs/inputs, list/vault)
	PRIVATE_PROC(TRUE)
	var/mod = 1.0

	// Research
	var/research = vault[STORY_VAULT_RESEARCH_PROGRESS] || 0
	if(research <= STORY_VAULT_LOW_RESEARCH && owner.round_progression > STORY_ROUND_PROGRESSION_EARLY) mod -= 0.2
	else if(research <= STORY_VAULT_MODERATE_RESEARCH) mod += 0.1
	else if(research <= STORY_VAULT_HIGH_RESEARCH) mod += 0.15
	else if(research <= STORY_VAULT_ADVANCED_RESEARCH) mod += 0.2

	// Resources
	if((vault[STORY_VAULT_RESOURCE_MINERALS] || 0) < 250) mod -= 0.2
	var/other_res = vault[STORY_VAULT_RESOURCE_OTHER] || 0
	if(other_res < 10000) mod -= 0.4
	else if(other_res <= 40000) mod += 0.2
	else if(other_res <= 70000) mod += 0.4
	else if(other_res <= 100000) mod += 0.9

	// Allies
	if(vault[STORY_VAULT_STATION_ALLIES]) mod += 0.6

	return mod

/datum/storyteller_balance/proc/calculate_antag_strength(datum/storyteller_inputs/inputs)
	PRIVATE_PROC(TRUE)
	var/vault = inputs.vault
	if(inputs.antag_count() <= 0) return 0


	var/norms = list(
		"activity" = NORMALIZE(vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || 0, 3),
		"kills" = NORMALIZE(vault[STORY_VAULT_ANTAG_KILLS] || 0, 3),
		"objectives" = NORMALIZE(vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] || 0, 3),
		"disruption" = NORMALIZE(vault[STORY_VAULT_ANTAG_DISRUPTION] || 0, 3),
		"influence" = NORMALIZE(vault[STORY_VAULT_ANTAG_INFLUENCE] || 0, 3),
		"intensity" = NORMALIZE(vault[STORY_VAULT_ANTAG_INTENSITY] || 0, 3),
		"teamwork" = NORMALIZE(vault[STORY_VAULT_ANTAG_TEAMWORK] || 0, 3),
		"escalation" = NORMALIZE(vault[STORY_VAULT_THREAT_ESCALATION] || 0, 3),
		"stealth" = NORMALIZE(vault[STORY_VAULT_ANTAG_STEALTH] || 0, 3)
	)

	var/core_strength = calculate_weighted_sum(norms, ANTAG_STRENGTH_WEIGHTS)


	var/mod_norms = list(
		"presence" = NORMALIZE(vault[STORY_VAULT_ANTAGONIST_PRESENCE] || 0, 3),
		"survival" = INVERT_NORMALIZE(vault[STORY_VAULT_ANTAG_DEAD_RATIO] || 0, 3),
		"activity" = 1 - (vault[STORY_VAULT_ANTAG_INACTIVE_RATIO] || 0)
	)

	var/mod_strength = calculate_weighted_sum(mod_norms, ANTAG_MODIFIERS_WEIGHTS)


	var/overall_norm = (core_strength * ANTAG_CORE_WEIGHT) + (core_strength * mod_strength * ANTAG_MOD_WEIGHT)


	var/relative_scale = clamp(inputs.antag_count() / max(inputs.player_count() * 0.1, 1), 0.5, 2.0)

	return clamp(overall_norm * relative_scale * 100, 0, 100)

/datum/storyteller_balance/proc/calculate_total_player_weight(datum/storyteller_inputs/inputs, station_strength)
	PRIVATE_PROC(TRUE)
	var/total_players = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0
	var/avg_crew_weight = inputs.crew_weight() || STORY_BALANCER_PLAYER_WEIGHT
	var/readiness = NORMALIZE(inputs.vault[STORY_VAULT_CREW_READINESS] || 0, 3)
	var/readiness_mult = lerp(1.0, 0.7 + readiness * 0.6, STATION_STRENGTH_MULTIPLIER)
	return total_players * avg_crew_weight * readiness_mult * station_strength

/datum/storyteller_balance/proc/calculate_total_antag_weight(datum/storyteller_inputs/inputs, antag_effectiveness)
	PRIVATE_PROC(TRUE)
	return inputs.antag_count() * STORY_BALANCER_ANTAG_WEIGHT * antag_effectiveness

/datum/storyteller_balance/proc/calculate_overall_tension(datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/snap)
	PRIVATE_PROC(TRUE)
	var/norm_tension_bonus = NORMALIZE(tension_bonus, MAX_TENSION_BONUS)
	var/base_tension = norm_tension_bonus * 30 * (1 - owner.adaptation_factor)

	var/antag_contrib = (snap.strengths["antag"] * 0.6 + snap.antag_activity_index * 0.4) * 40
	var/integrity_tension = calculate_integrity_tension(inputs)
	var/health_tension = calculate_health_tension(inputs)


	var/extra = list(
		"teamwork" = NORMALIZE(inputs.vault[STORY_VAULT_ANTAG_TEAMWORK] || 0, 3) * 8,
		"stealth" = NORMALIZE(inputs.vault[STORY_VAULT_ANTAG_STEALTH] || 0, 3) * 6,
		"vulnerability" = (1 - snap.strengths["station"]) * 8,
		"ratio" = clamp((snap.balance_ratio - 1) / 2, 0, 1) * 10,
		"lowpop" = (1 - NORMALIZE(inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0, 60)) * 12
	)

	var/extra_tension = 0
	for(var/val in extra) extra_tension += extra[val]

	return clamp(base_tension + antag_contrib + integrity_tension + health_tension + extra_tension, 0, 100)

/datum/storyteller_balance/proc/calculate_integrity_tension(datum/storyteller_inputs/inputs)
	PRIVATE_PROC(TRUE)
	var/vault = inputs.vault

	var/norms = list(
		"hull" = INVERT_NORMALIZE(inputs.get_station_integrity() || 100, 100),
		"infra" = NORMALIZE(vault[STORY_VAULT_INFRA_DAMAGE] || 0, STORY_VAULT_CRITICAL_DAMAGE),
		"power" = INVERT_NORMALIZE(vault[STORY_VAULT_POWER_GRID_STRENGTH] || 100, 100)
	)

	var/base_tension = calculate_weighted_sum(norms, INTEGRITY_WEIGHTS) * INTEGRITY_TENSION_MAX


	var/infra_damage = vault[STORY_VAULT_INFRA_DAMAGE] || STORY_VAULT_NO_DAMAGE
	if(infra_damage <= STORY_VAULT_NO_DAMAGE) base_tension -= 5
	else if(infra_damage <= STORY_VAULT_MINOR_DAMAGE) base_tension += 5
	else if(infra_damage <= STORY_VAULT_MAJOR_DAMAGE) base_tension += 15
	else base_tension += 30

	var/power_damage = vault[STORY_VAULT_POWER_GRID_DAMAGE] || STORY_VAULT_POWER_GRID_NOMINAL
	if(power_damage <= STORY_VAULT_POWER_GRID_NOMINAL) base_tension -= 5
	else if(power_damage <= STORY_VAULT_POWER_GRID_FAILURES) base_tension += 3
	else if(power_damage <= STORY_VAULT_POWER_GRID_DAMAGED) base_tension += 5
	else base_tension += 15

	return clamp(base_tension, INTEGRITY_TENSION_MIN, INTEGRITY_TENSION_MAX)

/datum/storyteller_balance/proc/calculate_health_tension(datum/storyteller_inputs/inputs)
	PRIVATE_PROC(TRUE)
	var/vault = inputs.vault

	var/norms = list(
		"health" = INVERT_NORMALIZE(vault[STORY_VAULT_AVG_CREW_HEALTH] || 100, 100),
		"wounds" = NORMALIZE(vault[STORY_VAULT_AVG_CREW_WOUNDS] || 0, WOUNDING_CRITICAL_THRESHOLD),
		"diseases" = NORMALIZE(vault[STORY_VAULT_CREW_DISEASES] || 0, STORY_VAULT_OUTBREAK),
		"dead" = NORMALIZE(vault[STORY_VAULT_CREW_DEAD_RATIO] || 0, STORY_VAULT_EXTREME_DEAD_RATIO)
	)

	var/base_tension = calculate_weighted_sum(norms, HEALTH_WEIGHTS) * HEALTH_TENSION_MAX
	base_tension += norms["dead"] * 15

	return clamp(base_tension, 0, HEALTH_TENSION_MAX)

/datum/storyteller_balance/proc/calculate_resource_strength(list/vault)
	PRIVATE_PROC(TRUE)
	var/minerals = vault[STORY_VAULT_RESOURCE_MINERALS] || 0
	var/other = vault[STORY_VAULT_RESOURCE_OTHER] || 0
	return NORMALIZE(minerals / 1000 + other / 100000, 1)  // Max 1


/datum/storyteller_balance_snapshot
	var/list/strengths = list()  // "station": norm, "station_raw": raw, etc.
	var/list/weights = list()	// "player": total, "antag": total
	var/balance_ratio = 1.0
	var/overall_tension = 50
	var/antag_activity_index = 0
	var/antag_weak = FALSE
	var/antag_inactive = FALSE
	var/resource_strength = 0
	var/list/flags = list()  // "antag_coordinated": bool, etc.


/datum/storyteller_balance_snapshot/proc/get_antag_advantage()
	return balance_ratio * strengths["antag"]

// Returns the tension product value
/datum/storyteller_balance_snapshot/proc/get_tension_product()
	return (overall_tension / 100) * antag_activity_index

// Returns the station resilience value
/datum/storyteller_balance_snapshot/proc/get_station_resilience()
	return strengths["station"] * resource_strength

// Returns the weight ratio of antag to player
/datum/storyteller_balance_snapshot/proc/get_weight_ratio()
	return weights["antag"] / max(weights["player"], 1)

#undef NORMALIZE
#undef INVERT_NORMALIZE
#undef WEAK_ANTAG_THRESHOLD
#undef INACTIVE_ACTIVITY_THRESHOLD
#undef STATION_STRENGTH_MULTIPLIER
#undef MAX_TENSION_BONUS
#undef INTEGRITY_WEIGHTS
#undef INTEGRITY_TENSION_MIN
#undef INTEGRITY_TENSION_MAX
#undef HEALTH_WEIGHTS
#undef HEALTH_TENSION_MAX
#undef WOUNDING_CRITICAL_THRESHOLD
#undef STATION_STRENGTH_WEIGHTS
#undef ANTAG_STRENGTH_WEIGHTS
#undef ANTAG_MODIFIERS_WEIGHTS
#undef ANTAG_CORE_WEIGHT
#undef ANTAG_MOD_WEIGHT
