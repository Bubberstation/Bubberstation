
#define STORY_RESEARCH_ADVANCED_THRESHOLD 50
#define STORY_RESEARCH_HIGH_THRESHOLD 30
#define STORY_RESEARCH_MODERATE_THRESHOLD 15

// Metric for station research level: analyzes R&D progress (points, unlocked nodes, tiers)
// Outputs to vault: research_progress 0-3 (low/moderate/high/advanced) for balancer modifiers
/datum/storyteller_metric/research_level
	name = "Research level check"

/datum/storyteller_metric/research_level/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return SSresearch.initialized && length(SSresearch.techweb_nodes) > 0

/datum/storyteller_metric/research_level/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	..()

	var/datum/techweb/station_tech
	for(var/datum/techweb/web in SSresearch.techwebs)
		if(istype(web, /datum/techweb/science))
			station_tech = web
			break

	if(!station_tech)
		inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] = STORY_VAULT_LOW_RESEARCH
		return


	var/unlocked_nodes = length(station_tech.researched_nodes)
	var/total_nodes = length(SSresearch.techweb_nodes)

	if(total_nodes <= 0)
		inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] = STORY_VAULT_LOW_RESEARCH
		return


	var/unlocked_percent = (unlocked_nodes / total_nodes) * 100


	var/progress_level = 0
	if(unlocked_percent >= STORY_RESEARCH_ADVANCED_THRESHOLD)
		progress_level = STORY_VAULT_ADVANCED_RESEARCH
	else if(unlocked_percent >= STORY_RESEARCH_HIGH_THRESHOLD)
		progress_level = STORY_VAULT_HIGH_RESEARCH
	else if(unlocked_percent >= STORY_RESEARCH_MODERATE_THRESHOLD)
		progress_level = STORY_VAULT_MODERATE_RESEARCH
	else
		progress_level = STORY_VAULT_LOW_RESEARCH

	inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] = progress_level


#undef STORY_RESEARCH_ADVANCED_THRESHOLD
#undef STORY_RESEARCH_HIGH_THRESHOLD
#undef STORY_RESEARCH_MODERATE_THRESHOLD
