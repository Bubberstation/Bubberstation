/datum/round_event_control/aurora_caelus
	id = "aurora_caelus"
	name = "Aurora Caelus"
	description = "A beautiful aurora will light up the skies, bringing a calming effect to the crew.\
					This event is known to boost morale and reduce stress levels among station personnel."
	story_category = STORY_GOAL_GOOD
	tags = STORY_TAG_AFFECTS_CREW_MIND | STORY_TAG_DEESCALATION | STORY_TAG_WIDE_IMPACT
	typepath = /datum/round_event/aurora_caelus


/datum/round_event_control/aurora_caelus/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return inputs.antag_count() <= 0

/datum/round_event_control/aurora_caelus/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_WEIGHT + (inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT) * 0.3)

/datum/round_event/aurora_caelus
	allow_random = FALSE

/datum/round_event/aurora_caelus/__setup_for_storyteller(threat_points, ...)
	. = ..()
	end_when = (2 MINUTES) * (1 + round(threat_points / 200))


