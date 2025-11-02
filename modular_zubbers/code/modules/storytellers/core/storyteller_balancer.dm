/// Balance subsystem for storyteller
/// Analyzes antagonist quantity, effectiveness (e.g., health, activity from metrics), and ratio to station strength (e.g., crew resilience, resources).
/// Inspired by RimWorld's threat adaptation: balances player/antag weights to prevent one-sided dominance, influencing goal selection (e.g., boost weak antags).
/// Snapshot captures current state for planner use.

/datum/storyteller_balance
	VAR_PRIVATE/datum/storyteller/owner

	/// Base weight per player (scales with crew health/resilience)
	var/player_weight = STORY_BALANCER_PLAYER_WEIGHT
	/// Base weight per antagonist (scales with antag effectiveness)
	var/antag_weight = STORY_BALANCER_ANTAG_WEIGHT
	/// Threshold for "weak antags" effectiveness (0-1)
	var/weak_antag_threshold = STORY_BALANCER_WEAK_ANTAG_THRESHOLD
	/// Threshold for "inactive antags" activity level (0-3 scaled -> 0-1 after normalize)
	var/inactive_activity_threshold = STORY_BALANCER_INACTIVE_ACTIVITY_THRESHOLD
	/// Station strength multiplier (e.g., high crew health/resources = higher value)
	var/station_strength_multiplier = STORY_STATION_STRENGTH_MULTIPLIER
	/// A tension bonus coming from completed bad/escalation goals (from planner history)
	var/tension_bonus

/datum/storyteller_balance/New(_owner)
	owner = _owner
	..()

/// Create a snapshot of current balance state based on storyteller inputs and vault
/datum/storyteller_balance/proc/make_snapshot(datum/storyteller_inputs/inputs)
	var/datum/storyteller_balance_snapshot/snap = new

	// Station strength calculations (raw 0-100, normalized 0-1)
	var/raw_station_strength = get_station_strength(inputs, inputs.vault)
	var/station_strength_mod = get_strength_multiplayer(inputs, inputs.vault)
	snap.station_strength = clamp(raw_station_strength * station_strength_mod / 100, 0, 1)
	snap.station_strength_raw = clamp(raw_station_strength * station_strength_mod, 0, 100)

	// Antag strength calculations (raw 0-100, effectiveness 0-1)
	var/antag_strength_raw = get_antagonist_strength(inputs, inputs.vault)
	snap.antag_strength_raw = antag_strength_raw
	snap.antag_effectiveness = antag_strength_raw / 100  // Normalized for contrib

	// Improved weight calculation - uses actual crew weight from metrics, not just player count
	var/total_players = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0
	var/avg_crew_weight = inputs.crew_weight() || player_weight  // Get average crew weight from metrics
	var/crew_readiness = inputs.vault[STORY_VAULT_CREW_READINESS] || 0  // 0-3 scale

	// Normalize readiness (0-3) to multiplier (0.7-1.3)
	var/readiness_mult = clamp(0.7 + (crew_readiness / 3.0) * 0.6, 0.7, 1.3)

	// Calculate total player weight: (avg weight per player * number of players) * strength modifier * readiness
	// This better reflects actual crew capability
	var/effective_crew_weight = total_players * avg_crew_weight * readiness_mult
	snap.total_player_weight = effective_crew_weight * snap.station_strength_raw / 100

	var/antag_count = inputs.antag_count()
	snap.total_antag_weight = antag_count * antag_weight * snap.antag_effectiveness

	// Ratio between station and antagonist strength (>1 = antag advantage)
	// Prevent division by zero while preserving the actual ratio value
	snap.ratio = antag_strength_raw / max(snap.station_strength_raw, 1)

	// Activity and flags
	snap.antag_activity_index = (inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || 0) / 3
	snap.antag_weak = snap.antag_effectiveness < weak_antag_threshold
	snap.antag_inactive = snap.antag_activity_index < inactive_activity_threshold

	snap.resource_strength = get_resource_strength(inputs.vault)
	snap.antag_coordinated = (inputs.vault[STORY_VAULT_ANTAG_TEAMWORK] || 0) > 1.5
	snap.antag_stealthy = (inputs.vault[STORY_VAULT_ANTAG_STEALTH] || 0) > 1.5
	snap.station_vulnerable = snap.station_strength < 0.5

	// Base tension from planner history (normalized to 0-1, then scaled)
	var/normalized_tension_bonus = clamp(tension_bonus / STORY_MAX_TENSION_BONUS, 0, 1)
	var/base_tension = normalized_tension_bonus * 30 * (1 - owner.adaptation_factor)  // Max 30 points from history

	// Core tension contributions (all normalized 0-1, then scaled appropriately)
	// Antagonist contribution: effectiveness + activity (both 0-1, max 40 points)
	var/antag_contrib_normalized = (snap.antag_effectiveness * 0.6 + snap.antag_activity_index * 0.4)
	var/antag_contrib = antag_contrib_normalized * 40

	// Integrity tension (already returns 0-50 range, normalized)
	var/integrity_tension = get_station_integrity_tension(inputs)

	// Health tension (already returns 0-35 range, normalized)
	var/health_tension = get_crew_health_tension(inputs)

	// Extra tension from qualitative factors (using normalized flags and ratios)
	var/extra_tension = 0

	// Antag coordination: use normalized teamwork value instead of boolean
	var/teamwork_norm = clamp((inputs.vault[STORY_VAULT_ANTAG_TEAMWORK] || 0) / 3.0, 0, 1)
	extra_tension += teamwork_norm * 8  // Max 8 points for coordination

	// Antag stealth: use normalized stealth value instead of boolean
	var/stealth_norm = clamp((inputs.vault[STORY_VAULT_ANTAG_STEALTH] || 0) / 3.0, 0, 1)
	extra_tension += stealth_norm * 6  // Max 6 points for stealth

	// Station vulnerability: use normalized strength instead of boolean
	var/vulnerability_norm = clamp(1 - snap.station_strength, 0, 1)
	extra_tension += vulnerability_norm * 8  // Max 8 points for vulnerability

	// Antag advantage ratio: normalized scale (1.0 = balanced, >1.0 = antag advantage)
	var/ratio_normalized = clamp((snap.ratio - 1.0) / 2.0, 0, 1)  // Scale: 1.0->0, 3.0->1.0
	extra_tension += ratio_normalized * 10  // Max 10 points for antag advantage

	// Population factor: use normalized population (lowpop = higher tension)
	var/crew_count = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 0
	var/normalized_crew_count = clamp(crew_count / 60.0, 0, 1)  // Normalize to max 60 players
	var/lowpop_factor = 1 - normalized_crew_count  // Inverse: fewer players = higher factor
	extra_tension += lowpop_factor * 12  // Max 12 points for low population

	snap.overall_tension = clamp(base_tension + antag_contrib + integrity_tension + extra_tension + health_tension, 0, 100)

	return snap

/// Returns normalized raw station strength from 0 to 100
/// Improved calculation that better reflects actual station capability
/datum/storyteller_balance/proc/get_station_strength(datum/storyteller_inputs/inputs, list/vault)
	PRIVATE_PROC(TRUE)

	var/crew_readiness = vault[STORY_VAULT_CREW_READINESS] || 0  // Readiness of the crew (0-3)
	var/avg_crew_weight = inputs.crew_weight() || STORY_BALANCER_PLAYER_WEIGHT  // Average weight per crew member
	var/security_count = vault[STORY_VAULT_SECURITY_COUNT] || 0
	var/security_strength = vault[STORY_VAULT_SECURITY_STRENGTH] || 0
	var/total_crew_count = inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] || 1

	// Weights adjusted for better balance
	var/weight_crew_capability = 0.4  // Combined weight and readiness (primary factor)
	var/weight_security = 0.35  // Security is important but not everything
	var/weight_crew_health = 0.15  // Crew health affects effectiveness
	var/weight_infrastructure = 0.10  // Station integrity matters

	// Crew capability: combines average weight with readiness
	// Normalize readiness (0-3) to 0-100 scale
	var/readiness_normalized = (crew_readiness / 3.0) * 100
	// Crew weight is already in a normalized scale, convert to 0-100 range
	// Assuming crew_weight ranges from ~5 to ~40 (typical values)
	var/weight_normalized = clamp(avg_crew_weight * 2.5, 0, 100)  // Scale to 0-100
	// Combined crew capability (weighted average)
	var/crew_capability = (weight_normalized * 0.6 + readiness_normalized * 0.4)

	// Security contribution: combines count and strength
	var/max_security_count = max(total_crew_count * 0.2, 20)  // ~20% of crew or 20, whichever is higher
	var/norm_security_count = min(security_count / max_security_count, 1.0) * 100
	var/norm_security_strength = (security_strength / 3.0) * 100
	// Security is effective when both count and quality are good
	var/security_contribution = (norm_security_count * 0.6 + norm_security_strength * 0.4)

	// Crew health contribution (from vault metrics)
	var/crew_health = inputs.vault[STORY_VAULT_AVG_CREW_HEALTH] || 100  // 0-100
	var/health_contribution = crew_health  // Already in 0-100 range

	// Infrastructure integrity contribution
	var/integrity = inputs.get_station_integrity() || 100  // 0-100
	var/infra_contribution = integrity  // Already in 0-100 range

	// Calculate total station strength (weighted sum)
	var/station_strength = \
		(crew_capability * weight_crew_capability) + \
		(security_contribution * weight_security) + \
		(health_contribution * weight_crew_health) + \
		(infra_contribution * weight_infrastructure)

	return clamp(station_strength, 0, 100)


/datum/storyteller_balance/proc/get_strength_multiplayer(datum/storyteller_inputs/inputs, list/vault)
	PRIVATE_PROC(TRUE)

	var/final_modificator = 1
	// First: research bonus
	if(vault[STORY_VAULT_RESEARCH_PROGRESS])
		if(vault[STORY_VAULT_RESEARCH_PROGRESS] <= STORY_VAULT_LOW_RESEARCH && owner.round_progression > STORY_ROUND_PROGRESSION_EARLY)
			final_modificator -= 0.2
		else if(vault[STORY_VAULT_RESEARCH_PROGRESS] <= STORY_VAULT_MODERATE_RESEARCH)
			final_modificator += 0.1
		else if(vault[STORY_VAULT_RESEARCH_PROGRESS] <= STORY_VAULT_HIGH_RESEARCH)
			final_modificator += 0.15
		else if(vault[STORY_VAULT_RESEARCH_PROGRESS] <= STORY_VAULT_ADVANCED_RESEARCH)
			final_modificator += 0.2

	if(vault[STORY_VAULT_RESOURCE_MINERALS] && vault[STORY_VAULT_RESOURCE_MINERALS] < 250)
		final_modificator -= 0.2

	if(vault[STORY_VAULT_RESOURCE_OTHER] && vault[STORY_VAULT_RESOURCE_OTHER] < 10000)
		final_modificator -= 0.4
	else if(vault[STORY_VAULT_RESOURCE_OTHER] && vault[STORY_VAULT_RESOURCE_OTHER] <= 40000)
		final_modificator += 0.2
	else if(vault[STORY_VAULT_RESOURCE_OTHER] && vault[STORY_VAULT_RESOURCE_OTHER] <= 70000)
		final_modificator += 0.4
	else if(vault[STORY_VAULT_RESOURCE_OTHER] && vault[STORY_VAULT_RESOURCE_OTHER] <= 100000)
		final_modificator += 0.9

	if(vault[STORY_VAULT_STATION_ALLIES])
		final_modificator += 0.6

	return final_modificator

/// Returns raw antagonist strength (0-100) based on vault metrics
/// Aggregates activity, kills, objectives, etc., with penalties for deaths/inactivity
/// Scaled to 0-100 for direct comparison with station_strength
/datum/storyteller_balance/proc/get_antagonist_strength(datum/storyteller_inputs/inputs, list/vault)
	PRIVATE_PROC(TRUE)

	if(inputs.antag_count() <= 0)
		return 0

	// Pull metrics from vault (0-3 unless noted)
	var/activity_level = vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || 0
	var/kills = vault[STORY_VAULT_ANTAG_KILLS] || 0
	var/objectives = vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] || 0
	var/disruption = vault[STORY_VAULT_ANTAG_DISRUPTION] || 0
	var/influence = vault[STORY_VAULT_ANTAG_INFLUENCE] || 0
	var/dead_ratio = vault[STORY_VAULT_ANTAG_DEAD_RATIO] || 0
	var/presence = vault[STORY_VAULT_ANTAGONIST_PRESENCE] || 0
	var/inactive_ratio = vault[STORY_VAULT_ANTAG_INACTIVE_RATIO] || 0
	var/intensity = vault[STORY_VAULT_ANTAG_INTENSITY] || 0
	var/teamwork = vault[STORY_VAULT_ANTAG_TEAMWORK] || 0
	var/stealth = vault[STORY_VAULT_ANTAG_STEALTH] || 0
	var/escalation = vault[STORY_VAULT_THREAT_ESCALATION] || 0

	var/weight_activity = 0.15
	var/weight_kills = 0.10
	var/weight_objectives = 0.15
	var/weight_disruption = 0.10
	var/weight_influence = 0.10
	var/weight_intensity = 0.10
	var/weight_teamwork = 0.05
	var/weight_escalation = 0.10
	var/weight_stealth = 0.05

	// Normalize to 0-1 (divide by 3 for 0-3 scales; inactive already 0-1)
	var/norm_activity = activity_level / 3
	var/norm_kills = kills / 3
	var/norm_objectives = objectives / 3
	var/norm_disruption = disruption / 3
	var/norm_influence = influence / 3
	var/norm_intensity = intensity / 3
	var/norm_teamwork = teamwork / 3
	var/norm_escalation = escalation / 3
	var/norm_stealth = stealth / 3
	var/norm_presence = presence / 3
	var/norm_dead = 1 - (dead_ratio / 3)  // Inverted: high deaths = low survival
	var/norm_inactive = 1 - inactive_ratio

	// Core strength: weighted sum of key metrics (0-1)
	var/core_strength = norm_activity * weight_activity + \
		norm_kills * weight_kills + \
		norm_objectives * weight_objectives + \
		norm_disruption * weight_disruption + \
		norm_influence * weight_influence + \
		norm_intensity * weight_intensity + \
		norm_teamwork * weight_teamwork + \
		norm_escalation * weight_escalation + \
		norm_stealth * weight_stealth

	// Modifiers (additive multipliers, properly scaled)
	var/presence_mod = norm_presence * 0.15  // Reduced weight for balance
	var/survival_mod = norm_dead * 0.20      // Reduced weight for balance
	var/activity_mod = norm_inactive * 0.25  // Reduced weight for balance

	// Combine core strength with modifiers (weighted sum, no arbitrary centering)
	var/overall_strength_norm = clamp(
		core_strength * 0.6 + \
		(core_strength * presence_mod) * 0.1 + \
		(core_strength * survival_mod) * 0.15 + \
		(core_strength * activity_mod) * 0.15,
		0, 1
	)

	// Relative scale: antag_count vs. player_count (ideal 5-20% antags; scale 0.5-2.0)
	var/relative_scale = clamp(inputs.antag_count() / max(inputs.player_count() * 0.1, 1), 0.5, 2.0)

	// Final raw strength: normalize * scale * 100
	var/final_strength = clamp(overall_strength_norm * relative_scale * 100, 0, 100)

	return final_strength



#define STORY_INTEGRITY_TENSION_WEIGHT_HULL 0.4    // Weight for hull_integrity in tension
#define STORY_INTEGRITY_TENSION_WEIGHT_INFRA 0.3   // Weight for infra_damage
#define STORY_INTEGRITY_TENSION_WEIGHT_POWER 0.3   // Weight for power_grid_strength
#define STORY_INTEGRITY_TENSION_MAX 50             // Max tension contribution (+ for damage)
#define STORY_INTEGRITY_TENSION_MIN -20            // Min tension (bonus for perfect state)


/// Returns tension contribution from station integrity (-20 to +50)
/// Based on hull, infra_damage, power; high damage → +tension (vulnerable station → escalate threats in planner)
/datum/storyteller_balance/proc/get_station_integrity_tension(datum/storyteller_inputs/inputs)
	PRIVATE_PROC(TRUE)

	var/tension = 0

	// Pull raw values from vault (0-100 for integrity/power, 0-3 for damage)
	var/hull_integrity = inputs.get_station_integrity() || 100
	var/infra_damage = inputs.vault[STORY_VAULT_INFRA_DAMAGE] || STORY_VAULT_NO_DAMAGE
	var/power_strength = inputs.vault[STORY_VAULT_POWER_GRID_STRENGTH] || 100
	var/power_damage = inputs.vault[STORY_VAULT_POWER_GRID_DAMAGE] || STORY_VAULT_POWER_GRID_NOMINAL


	var/norm_hull = 1 - (hull_integrity / 100)
	var/norm_infra = infra_damage / STORY_VAULT_CRITICAL_DAMAGE
	var/norm_power = 1 - (power_strength / 100)


	var/base_tension = (norm_hull * STORY_INTEGRITY_TENSION_WEIGHT_HULL * STORY_INTEGRITY_TENSION_MAX) + \
		(norm_infra * STORY_INTEGRITY_TENSION_WEIGHT_INFRA * STORY_INTEGRITY_TENSION_MAX) + \
		(norm_power * STORY_INTEGRITY_TENSION_WEIGHT_POWER * STORY_INTEGRITY_TENSION_MAX)


	if(infra_damage <= STORY_VAULT_NO_DAMAGE)
		tension += -5  // Bonus: perfect infra → lower tension → positive goals possible
	else if(infra_damage <= STORY_VAULT_MINOR_DAMAGE)
		tension += 5
	else if(infra_damage <= STORY_VAULT_MAJOR_DAMAGE)
		tension += 15
	else if(infra_damage <= STORY_VAULT_CRITICAL_DAMAGE)
		tension += 30

	if(power_damage <= STORY_VAULT_POWER_GRID_NOMINAL)
		tension += -5  // Bonus: full power → lower tension
	else if(power_damage <= STORY_VAULT_POWER_GRID_FAILURES)
		tension += 3
	else if(power_damage <= STORY_VAULT_POWER_GRID_DAMAGED)
		tension += 5
	else if(power_damage <= STORY_VAULT_POWER_GRID_CRITICAL)
		tension += 15

	tension += base_tension
	tension = clamp(tension, STORY_INTEGRITY_TENSION_MIN, STORY_INTEGRITY_TENSION_MAX)

	return tension

#undef STORY_INTEGRITY_TENSION_WEIGHT_HULL
#undef STORY_INTEGRITY_TENSION_WEIGHT_INFRA
#undef STORY_INTEGRITY_TENSION_WEIGHT_POWER
#undef STORY_INTEGRITY_TENSION_MAX
#undef STORY_INTEGRITY_TENSION_MIN

/datum/storyteller_balance/proc/get_resource_strength(list/vault)
	var/minerals = vault[STORY_VAULT_RESOURCE_MINERALS] || 0
	var/other = vault[STORY_VAULT_RESOURCE_OTHER] || 0
	return clamp((minerals / 1000 + other / 100000), 0, 1)


#define WOUNDING_CRITICAL_THRESHOLD 3

/datum/storyteller_balance/proc/get_crew_health_tension(datum/storyteller_inputs/inputs)
	PRIVATE_PROC(TRUE)
	var/avg_health_raw = inputs.get_entry(STORY_VAULT_AVG_CREW_HEALTH) || 100
	var/avg_wounds = inputs.get_entry(STORY_VAULT_AVG_CREW_WOUNDS) || 0
	var/diseases_level = inputs.get_entry(STORY_VAULT_CREW_DISEASES) || STORY_VAULT_NO_DISEASES
	var/dead_ratio_level = inputs.get_entry(STORY_VAULT_CREW_DEAD_RATIO) || STORY_VAULT_LOW_DEAD_RATIO
	var/weight_health = 0.4
	var/weight_wounds = 0.3
	var/weight_diseases = 0.2
	var/weight_dead = 0.1


	var/norm_health = clamp(1 - (avg_health_raw / 100), 0, 1)
	var/norm_wounds = clamp(avg_wounds / WOUNDING_CRITICAL_THRESHOLD, 0, 1)
	var/norm_diseases = clamp(diseases_level / STORY_VAULT_OUTBREAK, 0, 1)
	var/norm_dead = clamp(dead_ratio_level / STORY_VAULT_EXTREME_DEAD_RATIO, 0, 1)

	// Calculate base tension contribution (0-1 normalized, then scaled to 0-35)
	var/base_tension_normalized = (norm_health * weight_health) + \
		(norm_wounds * weight_wounds) + \
		(norm_diseases * weight_diseases) + \
		(norm_dead * weight_dead)

	// Scale normalized tension to 0-35 range
	var/base_tension = base_tension_normalized * 35

	// Dead ratio bonus: more impactful when many crew are dead
	var/bonus = norm_dead * 15
	base_tension += bonus
	return clamp(base_tension, 0, 35)

#undef WOUNDING_CRITICAL_THRESHOLD

// Snapshot datum
/datum/storyteller_balance_snapshot
	var/total_player_weight = 0
	var/total_antag_weight = 0
	var/ratio = 1.0
	/// Antag effectiveness (0-1; based on health, wounds, activity, influence, etc.)
	var/antag_effectiveness = 1.0
	/// Raw antag strength (0-100) for comparison
	var/antag_strength_raw = 0
	/// Station strength proxy (0-1; crew resilience, resources)
	var/station_strength = 1.0
	/// Raw station strength (0-100) for comparison
	var/station_strength_raw = 0
	/// Overall tension
	var/overall_tension = 50
	/// Resource strength
	var/resource_strength = 0
	/// Crew health index (0-1, 1 is worst)
	var/crew_health_index = 0
	/// Antag activity index (0-1)
	var/antag_activity_index = 0
	var/antag_coordinated
	var/antag_stealthy
	var/station_vulnerable
	/// Flags
	var/antag_inactive = FALSE
	var/antag_weak = FALSE
