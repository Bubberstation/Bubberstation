/datum/round_event_control/brain_trauma
	id = "brain_trauma"
	name = "Induce Brain Trauma"
	description = "Cause a crew members to suffer a sudden brain trauma."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_INDIVIDUALS
	typepath = /datum/round_event/brain_trauma

	min_players = 5
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC

/datum/round_event/brain_trauma
	STORYTELLER_EVENT

	var/maximum_targets = 1

/datum/round_event/brain_trauma/__setup_for_storyteller(threat_points, ...)
	. = ..()
	if(threat_points < STORY_THREAT_LOW)
		maximum_targets = 1
	else if(threat_points < STORY_THREAT_MODERATE)
		maximum_targets = 2
	else if(threat_points < STORY_THREAT_HIGH)
		maximum_targets = 3
	else if(threat_points < STORY_THREAT_EXTREME)
		maximum_targets = 4
	else
		maximum_targets = 5

/datum/round_event/brain_trauma/__start_for_storyteller()
	for(var/i = 0 to maximum_targets)
		start()
