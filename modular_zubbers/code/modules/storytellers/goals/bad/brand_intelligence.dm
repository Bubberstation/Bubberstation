/datum/storyteller_goal/execute_event/brand_intelligence
	id = "brand_intelligence"
	name = "Brand Intelligence"
	desc = "A vending machine has become self-aware and is aggressively marketing its products to the crew.\
			This event can lead to increased stress levels among personnel if not addressed promptly."
	children = list()
	category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES
	event_path = /datum/round_event/brand_intelligence

	required_population = 5
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED

/datum/round_event/brand_intelligence
	allow_random = FALSE
