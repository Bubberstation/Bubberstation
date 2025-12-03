// Threshold defines for health damage levels (avg damage per alive)
#define HEALTH_LOW_THRESHOLD 70      // High damage → low health level
#define HEALTH_DAMAGED_THRESHOLD 40  // Medium damage
#define HEALTH_NORMAL_THRESHOLD 10   // Low damage

// Threshold defines for wounding levels (avg wounds per alive)
#define WOUNDING_CRITICAL_THRESHOLD 3  // Many wounds
#define WOUNDING_MANY_THRESHOLD 2
#define WOUNDING_SOME_THRESHOLD 1

// Threshold defines for diseases ratio (infected / alive crew)
#define DISEASES_OUTBREAK_THRESHOLD 0.5   // High infection
#define DISEASES_MAJOR_THRESHOLD 0.25
#define DISEASES_MINOR_THRESHOLD 0.05

// Threshold defines for crew dead count (absolute dead)
#define CREW_DEAD_MANY_THRESHOLD 15  // Many dead
#define CREW_DEAD_SOME_THRESHOLD 5
#define CREW_DEAD_FEW_THRESHOLD 0    // Greater than 0

// Threshold defines for antag dead count (absolute dead)
#define ANTAG_DEAD_MANY_THRESHOLD 7   // Many dead antags
#define ANTAG_DEAD_SOME_THRESHOLD 3
#define ANTAG_DEAD_FEW_THRESHOLD 0    // Greater than 0

// Threshold defines for dead ratios (dead / total)
#define DEAD_RATIO_EXTREME_THRESHOLD 0.6  // Extreme losses
#define DEAD_RATIO_HIGH_THRESHOLD 0.3
#define DEAD_RATIO_MODERATE_THRESHOLD 0.1


// Metric for crew/antag health: analyzes damage, wounds, diseases, deaths (levels 0-3 + raw avgs)
// Outputs to vault: health/wounding/diseases/dead levels + counts/avgs for balancer tension/goal selection
/datum/storyteller_metric/crew_metrics
	name = "Crew health metric"

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

	var/alive_crew_count = 0
	var/alive_antag_count = 0
	var/total_crew_damage = 0
	var/total_antag_damage = 0
	var/total_crew_wounds = 0
	var/total_antag_wounds = 0
	var/total_infected_crew = 0

	for(var/mob/living/living in get_alive_crew(FALSE))  // Assume helper: alive station crew/antags
		var/is_antag = living.is_antag() || FALSE
		var/tot_damage =living.get_total_damage()  // Brute/burn/tox/oxy sum
		var/tot_wounds = 0
		if(iscarbon(living))
			var/mob/living/carbon/carbon = living
			tot_wounds = length(carbon.all_wounds)
			if(!is_antag && length(carbon.diseases))
				total_infected_crew++

		if(is_antag)
			alive_antag_count++
			total_antag_damage += tot_damage
			total_antag_wounds += tot_wounds
		else
			alive_crew_count++
			total_crew_damage += tot_damage
			total_crew_wounds += tot_wounds

	var/dead_crew_count = 0
	var/dead_antag_count = 0
	for(var/mob/living/living in get_dead_crew(FALSE))
		var/is_antag = living.is_antag() || FALSE
		if(is_antag)
			dead_antag_count++
		else
			dead_crew_count++


	var/total_crew = max(alive_crew_count + dead_crew_count, 1)  // Avoid div0
	var/total_antag = max(alive_antag_count + dead_antag_count, 1)
	var/avg_crew_health_raw = alive_crew_count > 0 ? clamp(100 - (total_crew_damage / alive_crew_count), 0, 100) : 100  // Inverted damage to health %
	var/avg_antag_health_raw = alive_antag_count > 0 ? clamp(100 - (total_antag_damage / alive_antag_count), 0, 100) : 100
	var/avg_crew_wounds = alive_crew_count > 0 ? (total_crew_wounds / alive_crew_count) : 0
	var/avg_antag_wounds = alive_antag_count > 0 ? (total_antag_wounds / alive_antag_count) : 0


	// Health thresholds: check from lowest (worst) to highest (best)
	// HEALTH_NORMAL_THRESHOLD=10, HEALTH_DAMAGED_THRESHOLD=40, HEALTH_LOW_THRESHOLD=70
	if(avg_crew_health_raw <= HEALTH_NORMAL_THRESHOLD)
		crew_health_level = STORY_VAULT_HEALTH_NORMAL
	else if(avg_crew_health_raw <= HEALTH_DAMAGED_THRESHOLD)
		crew_health_level = STORY_VAULT_HEALTH_DAMAGED
	else if(avg_crew_health_raw <= HEALTH_LOW_THRESHOLD)
		crew_health_level = STORY_VAULT_HEALTH_LOW
	else
		crew_health_level = STORY_VAULT_HEALTH_HEALTHY

	if(avg_antag_health_raw <= HEALTH_NORMAL_THRESHOLD)
		antag_health_level = STORY_VAULT_HEALTH_NORMAL
	else if(avg_antag_health_raw <= HEALTH_DAMAGED_THRESHOLD)
		antag_health_level = STORY_VAULT_HEALTH_DAMAGED
	else if(avg_antag_health_raw <= HEALTH_LOW_THRESHOLD)
		antag_health_level = STORY_VAULT_HEALTH_LOW
	else
		antag_health_level = STORY_VAULT_HEALTH_HEALTHY

	// Wounding levels (avg wounds)
	if(avg_crew_wounds >= WOUNDING_CRITICAL_THRESHOLD)
		crew_wounding_level = STORY_VAULT_CRITICAL_WOUNDED
	else if(avg_crew_wounds >= WOUNDING_MANY_THRESHOLD)
		crew_wounding_level = STORY_VAULT_MANY_WOUNDED
	else if(avg_crew_wounds >= WOUNDING_SOME_THRESHOLD)
		crew_wounding_level = STORY_VAULT_SOME_WOUNDED
	else
		crew_wounding_level = STORY_VAULT_NO_WOUNDS

	if(avg_antag_wounds >= WOUNDING_CRITICAL_THRESHOLD)
		antag_wounding_level = STORY_VAULT_CRITICAL_WOUNDED
	else if(avg_antag_wounds >= WOUNDING_MANY_THRESHOLD)
		antag_wounding_level = STORY_VAULT_MANY_WOUNDED
	else if(avg_antag_wounds >= WOUNDING_SOME_THRESHOLD)
		antag_wounding_level = STORY_VAULT_SOME_WOUNDED
	else
		antag_wounding_level = STORY_VAULT_NO_WOUNDS

	// Diseases level (crew only, ratio)
	var/infected_ratio = alive_crew_count > 0 ? (total_infected_crew / alive_crew_count) : 0
	if(infected_ratio >= DISEASES_OUTBREAK_THRESHOLD)
		crew_diseases_level = STORY_VAULT_OUTBREAK
	else if(infected_ratio >= DISEASES_MAJOR_THRESHOLD)
		crew_diseases_level = STORY_VAULT_MAJOR_DISEASES
	else if(infected_ratio >= DISEASES_MINOR_THRESHOLD)
		crew_diseases_level = STORY_VAULT_MINOR_DISEASES
	else
		crew_diseases_level = STORY_VAULT_NO_DISEASES

	// Dead count levels (absolute)
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

	// Dead ratio levels (dead / total)
	var/crew_dead_ratio = (dead_crew_count / total_crew)
	if(crew_dead_ratio > DEAD_RATIO_EXTREME_THRESHOLD)
		crew_dead_ratio_level = STORY_VAULT_EXTREME_DEAD_RATIO
	else if(crew_dead_ratio > DEAD_RATIO_HIGH_THRESHOLD)
		crew_dead_ratio_level = STORY_VAULT_HIGH_DEAD_RATIO
	else if(crew_dead_ratio > DEAD_RATIO_MODERATE_THRESHOLD)
		crew_dead_ratio_level = STORY_VAULT_MODERATE_DEAD_RATIO
	else
		crew_dead_ratio_level = STORY_VAULT_LOW_DEAD_RATIO

	var/antag_dead_ratio = (dead_antag_count / total_antag)
	if(antag_dead_ratio > DEAD_RATIO_EXTREME_THRESHOLD)
		antag_dead_ratio_level = STORY_VAULT_EXTREME_DEAD_RATIO
	else if(antag_dead_ratio > DEAD_RATIO_HIGH_THRESHOLD)
		antag_dead_ratio_level = STORY_VAULT_HIGH_DEAD_RATIO
	else if(antag_dead_ratio > DEAD_RATIO_MODERATE_THRESHOLD)
		antag_dead_ratio_level = STORY_VAULT_MODERATE_DEAD_RATIO
	else
		antag_dead_ratio_level = STORY_VAULT_LOW_DEAD_RATIO

	inputs.set_entry(STORY_VAULT_CREW_HEALTH, crew_health_level)
	inputs.set_entry(STORY_VAULT_ANTAG_HEALTH, antag_health_level)
	inputs.set_entry(STORY_VAULT_CREW_WOUNDING, crew_wounding_level)
	inputs.set_entry(STORY_VAULT_ANTAG_WOUNDING, antag_wounding_level)
	inputs.set_entry(STORY_VAULT_CREW_DISEASES, crew_diseases_level)
	inputs.set_entry(STORY_VAULT_CREW_ALIVE_LEVEL, crew_dead_count_level)
	inputs.set_entry(STORY_VAULT_CREW_DEAD_RATIO, crew_dead_ratio_level)
	inputs.set_entry(STORY_VAULT_ANTAG_ALIVE_LEVEL, antag_dead_count_level)
	inputs.set_entry(STORY_VAULT_ANTAG_DEAD_RATIO, antag_dead_ratio_level)

	inputs.set_entry(STORY_VAULT_AVG_CREW_HEALTH, avg_crew_health_raw)
	inputs.set_entry(STORY_VAULT_AVG_ANTAG_HEALTH, avg_antag_health_raw)
	inputs.set_entry(STORY_VAULT_AVG_CREW_WOUNDS, avg_crew_wounds)
	inputs.set_entry(STORY_VAULT_AVG_ANTAG_WOUNDS, avg_antag_wounds)


	// Counts (alive/dead)
	inputs.set_entry(STORY_VAULT_CREW_ALIVE_COUNT, alive_crew_count)
	inputs.set_entry(STORY_VAULT_ANTAG_ALIVE_COUNT, alive_antag_count)
	inputs.set_entry(STORY_VAULT_CREW_DEAD_COUNT, dead_crew_count)
	inputs.set_entry(STORY_VAULT_ANTAG_DEAD_COUNT, dead_antag_count)

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
