// Inputs datum to hold sampled data from the station
// This structure packages analysis results from the analyzer for use in planner (global goal and subgoals branching)
// and balancer (player vs. antagonist weights). It supports decision-making for event planning, goal progress,
// and mood-influenced adjustments. Expanded to include more metrics for comprehensive station analysis.
/datum/storyteller_inputs
	/// Total computed value of the station (atoms + infrastructure, used for goal weighting)
	var/station_value = 0
	/// Detailed station state datum, count of floor, walls and e.t.c default updates one time per 10 minutes
	var/datum/station_state/station_state
	/// Vault: Associative list for unique/custom values (keyed by defines like STORY_VALUE_POWER)
	/// Stores dynamic metrics not fitting standard vars, e.g., department-specific values or event-specific data.
	/// check _storyteller.dm defines for examples
	var/list/vault = list()


/datum/storyteller_inputs/proc/get_station_integrity()
	return station_state ? min(PERCENT(GLOB.start_state.score(station_state)), 100) : 100


/datum/storyteller_inputs/proc/player_count()
	return get_entry(STORY_VAULT_CREW_ALIVE_COUNT) ? get_entry(STORY_VAULT_CREW_ALIVE_COUNT) : 0


/datum/storyteller_inputs/proc/antag_count()
	return get_entry(STORY_VAULT_ANTAG_ALIVE_COUNT) ? get_entry(STORY_VAULT_ANTAG_ALIVE_COUNT) : 0


/datum/storyteller_inputs/proc/crew_weight()
	return get_entry(STORY_VAULT_CREW_WEIGHT) ? get_entry(STORY_VAULT_CREW_WEIGHT) : 0

/datum/storyteller_inputs/proc/get_crew_weight_normalized()
	return crew_weight() / player_count()

/datum/storyteller_inputs/proc/antag_weight()
	return get_entry(STORY_VAULT_ANTAG_WEIGHT) ? get_entry(STORY_VAULT_ANTAG_WEIGHT) : 0

/datum/storyteller_inputs/proc/antag_weight_normalized()
	return antag_weight() / antag_count()

/datum/storyteller_inputs/proc/antag_crew_ratio()
	var/crew_weight = crew_weight() ? crew_weight() : 1
	var/antag_weight = antag_weight() ? antag_weight() : 1
	return antag_weight / crew_weight

/datum/storyteller_inputs/proc/get_entry(name)
	if(vault)
		return vault[name]
	return null

/datum/storyteller_inputs/proc/set_entry(name, value)
	if(vault)
		if(value)
			vault[name] = value
		else
			vault += name
