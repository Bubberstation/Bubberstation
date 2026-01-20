/datum/storyteller_metric/antagonist_activity
	name = "Antagonist Activity"

/datum/storyteller_metric/antagonist_activity/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return inputs.antag_count() > 0

/datum/storyteller_metric/antagonist_activity/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/total_lifetime = 0
	var/total_kills = 0
	var/alive_antags = 0
	var/total_weight = 0
	var/total_influence = 0

	for(var/datum/antagonist/antag in GLOB.antagonists)
		var/datum/mind/M = antag.owner
		if(!M?.current || !isliving(M.current))
			continue
		var/datum/component/antag_metric_tracker/T = M.GetComponent(/datum/component/antag_metric_tracker)
		if(M.current.stat != DEAD)
			alive_antags++
			var/weight = antag.get_weight()
			total_weight += weight
			total_influence += weight * antag.get_effectivity()

		if(!T)
			continue
		total_lifetime += T.lifetime
		total_kills += T.kills

	inputs.set_entry(STORY_VAULT_ANTAG_WEIGHT, total_weight ? total_weight / max(1, alive_antags) : 0)
	inputs.set_entry(STORY_VAULT_ANTAG_INFLUENCE, total_weight ? total_influence / total_weight : 0)
	inputs.set_entry(STORY_VAULT_ANTAGONIST_PRESENCE, alive_antags >= 3 ? 3 : (alive_antags >= 1 ? 1 : 0))
	..()
