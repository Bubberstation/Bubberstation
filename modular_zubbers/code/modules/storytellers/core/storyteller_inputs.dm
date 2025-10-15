
// Inputs datum to hold sampled data from the station
// This structure packages analysis results from the analyzer for use in planner (global goal and subgoals branching)
// and balancer (player vs. antagonist weights). It supports decision-making for event planning, goal progress,
// and mood-influenced adjustments. Expanded to include more metrics for comprehensive station analysis.
/datum/storyteller_inputs
	/// Total computed value of the station (atoms + infrastructure, used for goal weighting)
	var/station_value = 0
	/// Total weight of non-antagonist crew members (influences balancer for event difficulty)
	var/crew_weight = 0
	/// Total weight of antagonist players
	var/antag_weight = 0
	/// Number of active players (living, non-observer)
	var/player_count = 0
	/// Number of active antagonists
	var/antag_count = 0
	/// Antagonist-to-crew ratio (float, e.g., 0.2 for 20% antags)
	var/antag_crew_ratio = 0
	/// Bitflags for station states/tendencies (e.g., STATION_HIGH_THREAT | STATION_LOW_RESOURCES)
	/// Set by analyzer based on thresholds
	var/station_states
	/// Detailed station state datum, count of floor, walls and e.t.c default updates one time per 10 minutes
	var/datum/station_state/station_state

	/// Vault: Associative list for unique/custom values (keyed by defines like STORY_VALUE_POWER)
	/// Stores dynamic metrics not fitting standard vars, e.g., department-specific values or event-specific data.
	/// check _storyteller.dm defines for examples
	var/list/vault = list()


/datum/storyteller_inputs/proc/get_station_integrity()
	return min(PERCENT(GLOB.start_state.score(station_state)), 100)
