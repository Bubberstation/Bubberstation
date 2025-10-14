// Balance subsystem for storyteller
// Analyzes antagonist quantity, effectiveness (e.g., health, activity from metrics), and ratio to station strength (e.g., crew resilience, resources).
// Inspired by RimWorld's threat adaptation: balances player/antag weights to prevent one-sided dominance, influencing goal selection (e.g., boost weak antags).
// Snapshot captures current state for planner use.

/datum/storyteller_balance
	var/datum/storyteller/owner

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

/datum/storyteller_balance/New(_owner)
	owner = _owner
	..()

// Create a snapshot of current balance state based on storyteller inputs and vault
/datum/storyteller_balance/proc/make_snapshot(datum/storyteller_inputs/inputs)
	var/datum/storyteller_balance_snapshot/snap = new




	return snap



/datum/storyteller_balance/proc/get_station_strength(datum/storyteller_inputs/inputs, list/vault)




// Snapshot datum
/datum/storyteller_balance_snapshot
	var/total_player_weight = 0
	var/total_antag_weight = 0
	var/ratio = 1.0
	/// Antag effectiveness (0-1; based on health, wounds, activity, influence, etc.)
	var/antag_effectiveness = 1.0
	/// Station strength proxy (0-1; crew resilience, resources)
	var/station_strength = 1.0
	/// Overall tension (0-100; derived from ratio for mood/planner use)
	var/overall_tension = 50
	/// Resource strength (0-1)
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
