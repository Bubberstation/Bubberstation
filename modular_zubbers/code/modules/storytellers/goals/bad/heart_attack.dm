/datum/round_event_control/heart_attack
	id = "heart_attack"
	name = "Induce Heart Attack"
	description = "Cause a crew member to suffer a sudden heart attack."
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_TARGETS_INDIVIDUALS, STORY_TAG_REQUIRES_MEDICAL, STORY_TAG_TRAGIC)
	typepath = /datum/round_event/heart_attack

	min_players = 5
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC


/datum/round_event_control/heart_attack/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	generate_candidates()
	. = ..()

/datum/round_event/heart_attack
	STORYTELLER_EVENT

/datum/round_event/heart_attack/__setup_for_storyteller(threat_points, ...)
	. = ..()
	quantity = min(5, threat_points / 1000)

/datum/round_event/heart_attack/__start_for_storyteller()
	var/datum/round_event_control/heart_attack/heart_control = control
	victims += heart_control.heart_attack_candidates
	heart_control.heart_attack_candidates.Cut()

	while(quantity > 0 && length(victims))
		if(attack_heart())
			quantity--

