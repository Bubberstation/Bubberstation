/datum/storyteller_goal/execute_event/mass_hallucination
	id = "mass_hallucination"
	name = "Mass Hallucination"
	desc = "All crewmembers start to hallucinate the same thing."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_AFFECTS_CREW_MIND
	event_path = /datum/round_event/mass_hallucination

	required_population = 2
	base_weight = STORY_GOAL_BASE_WEIGHT * 0.7
