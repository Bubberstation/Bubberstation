/datum/storyteller_metric/antagonist_activity
	name = "Antagonist Activity Aggregation"

/datum/storyteller_metric/antagonist_activity/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return inputs.antag_count() > 0

/datum/storyteller_metric/antagonist_activity/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/total_damage = 0
	var/total_activity = 0
	var/total_effective_activity = 0
	var/total_burst_activity = 0
	var/total_kills = 0
	var/total_objectives = 0
	var/total_disruption = 0
	var/total_influence = 0
	var/alive_antags = 0
	var/inactive_count = 0
	var/teamwork_score = 0
	var/stealth_score = 0


	var/list/threat_scores = list()
	var/major_threat = "none"
	var/threat_escalation = 0


	var/list/to_check = GLOB.antagonists.Copy()
	var/list/minds_to_check = list()

	for(var/datum/antagonist/antag in to_check)
		if(!(antag.owner in minds_to_check))
			minds_to_check += antag.owner

	for(var/datum/mind/antag_mind in minds_to_check)
		if(!antag_mind.current || antag_mind.current.stat == DEAD)
			continue
		var/datum/component/antag_metric_tracker/tracker = antag_mind.GetComponent(/datum/component/antag_metric_tracker)
		if(!tracker)
			continue

		total_damage += tracker.damage_dealt
		total_activity += tracker.activity_time
		total_effective_activity += tracker.effective_activity_time
		total_burst_activity += tracker.burst_activity
		total_kills += tracker.kills
		total_objectives += tracker.objectives_completed
		total_disruption += tracker.disruption_score
		total_influence += tracker.influence_score
		alive_antags += 1

		// Inactivity heuristic: Improved with burst check
		var/act_index = clamp(tracker.effective_activity_time / max(1, world.time / STORY_ACTIVITY_TIME_SCALE), 0, 1)
		if(act_index < STORY_INACTIVITY_ACT_INDEX_THRESHOLD && tracker.kills <= 0 && \
			tracker.objectives_completed <= 0 && tracker.burst_activity == 0)

			inactive_count++

		// New: Per-antag contributions to new metrics
		if(antag_mind.antag_datums && length(antag_mind.antag_datums))
			for(var/datum/antagonist/antag in antag_mind.antag_datums)
				var/eff = antag.get_effectivity()
				var/weight = antag.get_weight()
				var/threat_type = antag.type
				threat_scores[threat_type] += (eff * weight)  // Aggregate per type

				// Teamwork: If in team, check shared progress
				var/datum/team/team = antag.get_team()
				if(team)
					teamwork_score += (tracker.objectives_completed / max(1, team.members.len))  // Shared efficiency

				// Stealth: Objectives / disruption ratio
				stealth_score += clamp(tracker.objectives_completed / max(1, tracker.disruption_score / 10), 0, 1)

	if(alive_antags > 0)
		// Improved activity score: Use effective time, add burst weight
		var/avg_damage = total_damage / alive_antags
		var/avg_activity = total_effective_activity / max(1, world.time / STORY_ACTIVITY_TIME_SCALE)
		var/burst_factor = clamp(total_burst_activity / max(1, alive_antags), 0, 1) * 2  // Double weight for bursts
		var/activity_score = (avg_damage / STORY_DAMAGE_SCALE) + (avg_activity * STORY_ACTIVITY_TIME_SCALE) + (total_kills * 1.5) + (total_objectives * 2.5) + total_disruption / STORY_DISRUPTION_SCALE + total_influence / STORY_INFLUENCE_SCALE + burst_factor
		var/activity_level = clamp(activity_score / max(inputs.player_count() * STORY_ACTIVITY_CREW_SCALE, 1), 0, 3)

		var/highest_threat_score = 0
		for(var/threat_type in threat_scores)
			var/score = threat_scores[threat_type]
			if(score > highest_threat_score)
				highest_threat_score = score
				major_threat = threat_type
		threat_escalation = clamp(total_burst_activity / max(1, total_activity), 0, 3)

		inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] = activity_level
		inputs.vault[STORY_VAULT_ANTAG_KILLS] = clamp(total_kills / max(inputs.player_count() * 0.05, 1), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] = clamp(total_objectives / min(alive_antags, STORY_OBJECTIVES_CAP), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_DISRUPTION] = clamp(total_disruption / max(1, alive_antags), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_INFLUENCE] = clamp(total_influence / max(1, alive_antags), 0, 3)

		var/dead_count = inputs.antag_count() - alive_antags
		inputs.vault[STORY_VAULT_ANTAG_DEAD_RATIO] = clamp((dead_count / max(1, inputs.antag_count())) * 3, 0, 3)
		inputs.vault[STORY_VAULT_ANTAGONIST_PRESENCE] = clamp(alive_antags >= 4 ? 3 : (alive_antags >= 2 ? 2 : 1), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_INACTIVE_RATIO] = (inactive_count / alive_antags)
		inputs.vault[STORY_VAULT_ANTAG_INTENSITY] = clamp(activity_score / alive_antags, 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_TEAMWORK] = clamp(teamwork_score / alive_antags, 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_STEALTH] = clamp(stealth_score / alive_antags, 0, 3)
		inputs.vault[STORY_VAULT_MAJOR_THREAT] = major_threat
		inputs.vault[STORY_VAULT_THREAT_ESCALATION] = threat_escalation
	..()
