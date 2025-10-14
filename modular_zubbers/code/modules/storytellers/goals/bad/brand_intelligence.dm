/datum/storyteller_goal/execute_event/brand_intelligence
	id = "brand_intelligence"
	name = "Brand Intelligence"
	desc = "A vending machine has become self-aware and is aggressively marketing its products to the crew.\
			This event can lead to increased stress levels among personnel if not addressed promptly."
	children = list()
	category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES
	event_path = /datum/round_event/brand_intelligence

	requierd_population = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED

/datum/storyteller_goal/execute_event/brand_intelligence/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_WEIGHT + (vault[STORY_VAULT_CREW_ALIVE_COUNT] * 0.2) + (storyteller.threat_points * 0.01)

/datum/storyteller_goal/execute_event/brand_intelligence/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_PRIORITY + (storyteller.threat_points * 0.05)

/datum/round_event/brand_intelligence
	allow_random = FALSE
