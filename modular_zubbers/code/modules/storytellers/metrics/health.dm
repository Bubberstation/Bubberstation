// Threshold defines for health damage levels
#define HEALTH_LOW_THRESHOLD 70
#define HEALTH_DAMAGED_THRESHOLD 40
#define HEALTH_NORMAL_THRESHOLD 10

// Threshold defines for wounding levels
#define WOUNDING_CRITICAL_THRESHOLD 3
#define WOUNDING_MANY_THRESHOLD 2
#define WOUNDING_SOME_THRESHOLD 1

// Threshold defines for diseases ratio
#define DISEASES_OUTBREAK_THRESHOLD 0.5
#define DISEASES_MAJOR_THRESHOLD 0.25
#define DISEASES_MINOR_THRESHOLD 0.05

// Threshold defines for crew dead count
#define CREW_DEAD_MANY_THRESHOLD 15
#define CREW_DEAD_SOME_THRESHOLD 5
#define CREW_DEAD_FEW_THRESHOLD 0  // Greater than 0

// Threshold defines for antag dead count
#define ANTAG_DEAD_MANY_THRESHOLD 7
#define ANTAG_DEAD_SOME_THRESHOLD 3
#define ANTAG_DEAD_FEW_THRESHOLD 0  // Greater than 0

// Threshold defines for dead ratios
#define DEAD_RATIO_EXTREME_THRESHOLD 0.6
#define DEAD_RATIO_HIGH_THRESHOLD 0.3
#define DEAD_RATIO_MODERATE_THRESHOLD 0.1

/datum/storyteller_metric/crew_metrics
	name = "Crew health metric"


/datum/storyteller_metric/crew_metrics/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return inputs.player_count + inputs.antag_count > 0


/datum/storyteller_metric/crew_metrics/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/crew_health_level = STORY_VAULT_HEALTH_HEALTHY
	var/antag_health_level = STORY_VAULT_HEALTH_HEALTHY
	var/crew_wounding_level = STORY_VAULT_NO_WOUNDS
	var/antag_wounding_level = STORY_VAULT_NO_WOUNDS
	var/crew_diseases_level = STORY_VAULT_NO_DISEASES
	var/crew_dead_count_level = STORY_VAULT_NO_DEAD
	var/crew_dead_ratio_level = STORY_VAULT_LOW_DEAD_RATIO
	var/antag_dead_count_level = STORY_VAULT_NO_DEAD
	var/antag_dead_ratio_level = STORY_VAULT_LOW_DEAD_RATIO

	// Counters for alive
	var/alive_crew_count = 0
	var/alive_antag_count = 0
	var/total_crew_damage = 0
	var/total_antag_damage = 0
	var/total_crew_wounds = 0
	var/total_antag_wounds = 0
	var/total_infected_crew = 0

	for(var/mob/living/M in GLOB.alive_player_list)
		var/is_antag = M.mind?.has_antag_datum() || FALSE
		var/tot_damage = M.get_total_damage()
		var/tot_wounds = 0
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			tot_wounds = length(C.all_wounds)
			if(!is_antag && length(C.diseases))
				total_infected_crew++

		if(is_antag)
			alive_antag_count++
			total_antag_damage += tot_damage
			total_antag_wounds += tot_wounds
		else
			alive_crew_count++
			total_crew_damage += tot_damage
			total_crew_wounds += tot_wounds

	// Counters for dead
	var/dead_crew_count = 0
	var/dead_antag_count = 0
	for(var/mob/living/M in GLOB.dead_player_list)
		var/is_antag = M.mind?.has_antag_datum() || FALSE
		if(is_antag)
			dead_antag_count++
		else
			dead_crew_count++

	// Calculate totals
	var/total_crew = alive_crew_count + dead_crew_count
	var/total_antag = alive_antag_count + dead_antag_count

	// Calculate health levels
	if(alive_crew_count > 0)
		var/avg_crew_damage = total_crew_damage / alive_crew_count
		if(avg_crew_damage >= HEALTH_LOW_THRESHOLD)
			crew_health_level = STORY_VAULT_HEALTH_LOW
		else if(avg_crew_damage >= HEALTH_DAMAGED_THRESHOLD)
			crew_health_level = STORY_VAULT_HEALTH_DAMAGED
		else if(avg_crew_damage >= HEALTH_NORMAL_THRESHOLD)
			crew_health_level = STORY_VAULT_HEALTH_NORMAL
		else
			crew_health_level = STORY_VAULT_HEALTH_HEALTHY
	else
		crew_health_level = STORY_VAULT_HEALTH_HEALTHY  // Default if no alive crew

	if(alive_antag_count > 0)
		var/avg_antag_damage = total_antag_damage / alive_antag_count
		if(avg_antag_damage >= HEALTH_LOW_THRESHOLD)
			antag_health_level = STORY_VAULT_HEALTH_LOW
		else if(avg_antag_damage >= HEALTH_DAMAGED_THRESHOLD)
			antag_health_level = STORY_VAULT_HEALTH_DAMAGED
		else if(avg_antag_damage >= HEALTH_NORMAL_THRESHOLD)
			antag_health_level = STORY_VAULT_HEALTH_NORMAL
		else
			antag_health_level = STORY_VAULT_HEALTH_HEALTHY
	else
		antag_health_level = STORY_VAULT_HEALTH_HEALTHY

	// Calculate wounding levels
	if(alive_crew_count > 0)
		var/avg_crew_wounds = total_crew_wounds / alive_crew_count
		if(avg_crew_wounds >= WOUNDING_CRITICAL_THRESHOLD)
			crew_wounding_level = STORY_VAULT_CRITICAL_WOUNDED
		else if(avg_crew_wounds >= WOUNDING_MANY_THRESHOLD)
			crew_wounding_level = STORY_VAULT_MANY_WOUNDED
		else if(avg_crew_wounds >= WOUNDING_SOME_THRESHOLD)
			crew_wounding_level = STORY_VAULT_SOME_WOUNDED
		else
			crew_wounding_level = STORY_VAULT_NO_WOUNDS
	else
		crew_wounding_level = STORY_VAULT_NO_WOUNDS

	if(alive_antag_count > 0)
		var/avg_antag_wounds = total_antag_wounds / alive_antag_count
		if(avg_antag_wounds >= WOUNDING_CRITICAL_THRESHOLD)
			antag_wounding_level = STORY_VAULT_CRITICAL_WOUNDED
		else if(avg_antag_wounds >= WOUNDING_MANY_THRESHOLD)
			antag_wounding_level = STORY_VAULT_MANY_WOUNDED
		else if(avg_antag_wounds >= WOUNDING_SOME_THRESHOLD)
			antag_wounding_level = STORY_VAULT_SOME_WOUNDED
		else
			antag_wounding_level = STORY_VAULT_NO_WOUNDS
	else
		antag_wounding_level = STORY_VAULT_NO_WOUNDS

	// Calculate diseases level (crew only)
	if(alive_crew_count > 0)
		var/infected_ratio = total_infected_crew / alive_crew_count
		if(infected_ratio >= DISEASES_OUTBREAK_THRESHOLD)
			crew_diseases_level = STORY_VAULT_OUTBREAK
		else if(infected_ratio >= DISEASES_MAJOR_THRESHOLD)
			crew_diseases_level = STORY_VAULT_MAJOR_DISEASES
		else if(infected_ratio >= DISEASES_MINOR_THRESHOLD)
			crew_diseases_level = STORY_VAULT_MINOR_DISEASES
		else
			crew_diseases_level = STORY_VAULT_NO_DISEASES
	else
		crew_diseases_level = STORY_VAULT_NO_DISEASES

	// Calculate dead count levels
	if(dead_crew_count > CREW_DEAD_MANY_THRESHOLD)
		crew_dead_count_level = STORY_VAULT_MANY_DEAD
	else if(dead_crew_count > CREW_DEAD_SOME_THRESHOLD)
		crew_dead_count_level = STORY_VAULT_SOME_DEAD
	else if(dead_crew_count > CREW_DEAD_FEW_THRESHOLD)
		crew_dead_count_level = STORY_VAULT_FEW_DEAD
	else
		crew_dead_count_level = STORY_VAULT_NO_DEAD

	if(dead_antag_count > ANTAG_DEAD_MANY_THRESHOLD)
		antag_dead_count_level = STORY_VAULT_MANY_DEAD
	else if(dead_antag_count > ANTAG_DEAD_SOME_THRESHOLD)
		antag_dead_count_level = STORY_VAULT_SOME_DEAD
	else if(dead_antag_count > ANTAG_DEAD_FEW_THRESHOLD)
		antag_dead_count_level = STORY_VAULT_FEW_DEAD
	else
		antag_dead_count_level = STORY_VAULT_NO_DEAD

	// Calculate dead ratio levels
	var/crew_dead_ratio = (total_crew > 0) ? (dead_crew_count / total_crew) : 0
	if(crew_dead_ratio > DEAD_RATIO_EXTREME_THRESHOLD)
		crew_dead_ratio_level = STORY_VAULT_EXTREME_DEAD_RATIO
	else if(crew_dead_ratio > DEAD_RATIO_HIGH_THRESHOLD)
		crew_dead_ratio_level = STORY_VAULT_HIGH_DEAD_RATIO
	else if(crew_dead_ratio > DEAD_RATIO_MODERATE_THRESHOLD)
		crew_dead_ratio_level = STORY_VAULT_MODERATE_DEAD_RATIO
	else
		crew_dead_ratio_level = STORY_VAULT_LOW_DEAD_RATIO

	var/antag_dead_ratio = (total_antag > 0) ? (dead_antag_count / total_antag) : 0
	if(antag_dead_ratio > DEAD_RATIO_EXTREME_THRESHOLD)
		antag_dead_ratio_level = STORY_VAULT_EXTREME_DEAD_RATIO
	else if(antag_dead_ratio > DEAD_RATIO_HIGH_THRESHOLD)
		antag_dead_ratio_level = STORY_VAULT_HIGH_DEAD_RATIO
	else if(antag_dead_ratio > DEAD_RATIO_MODERATE_THRESHOLD)
		antag_dead_ratio_level = STORY_VAULT_MODERATE_DEAD_RATIO
	else
		antag_dead_ratio_level = STORY_VAULT_LOW_DEAD_RATIO

	// Store in vault
	inputs.vault[STORY_VAULT_CREW_HEALTH] = crew_health_level
	inputs.vault[STORY_VAULT_ANTAG_HEALTH] = antag_health_level
	inputs.vault[STORY_VAULT_CREW_WOUNDING] = crew_wounding_level
	inputs.vault[STORY_VAULT_ANTAG_WOUNDING] = antag_wounding_level
	inputs.vault[STORY_VAULT_CREW_DISEASES] = crew_diseases_level
	inputs.vault[STORY_VAULT_CREW_ALIVE_LEVEL] = crew_dead_count_level
	inputs.vault[STORY_VAULT_CREW_DEAD_RATIO] = crew_dead_ratio_level
	inputs.vault[STORY_VAULT_ANTAG_ALIVE_LEVEL] = antag_dead_count_level
	inputs.vault[STORY_VAULT_ANTAG_DEAD_RATIO] = antag_dead_ratio_level


	inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] = alive_crew_count
	inputs.vault[STORY_VAULT_ANTAG_ALIVE_COUNT] = alive_antag_count
	inputs.vault[STORY_VAULT_CREW_DEAD_COUNT] = dead_crew_count
	inputs.vault[STORY_VAULT_ANTAG_DEAD_COUNT] = dead_antag_count

	..()

#undef HEALTH_LOW_THRESHOLD
#undef HEALTH_DAMAGED_THRESHOLD
#undef HEALTH_NORMAL_THRESHOLD
#undef WOUNDING_CRITICAL_THRESHOLD
#undef WOUNDING_MANY_THRESHOLD
#undef WOUNDING_SOME_THRESHOLD
#undef DISEASES_OUTBREAK_THRESHOLD
#undef DISEASES_MAJOR_THRESHOLD
#undef DISEASES_MINOR_THRESHOLD
#undef CREW_DEAD_MANY_THRESHOLD
#undef CREW_DEAD_SOME_THRESHOLD
#undef CREW_DEAD_FEW_THRESHOLD
#undef ANTAG_DEAD_MANY_THRESHOLD
#undef ANTAG_DEAD_SOME_THRESHOLD
#undef ANTAG_DEAD_FEW_THRESHOLD
#undef DEAD_RATIO_EXTREME_THRESHOLD
#undef DEAD_RATIO_HIGH_THRESHOLD
#undef DEAD_RATIO_MODERATE_THRESHOLD
