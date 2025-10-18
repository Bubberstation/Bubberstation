/datum/storyteller_goal/execute_random_event/bad
	id = "execute_bad_random_event"
	name = "Execute Bad Random Event"
	desc = "Triggers a random negative event from the SSevents event pool."
	children = list()
	category = STORY_GOAL_BAD
	event_path = STORY_TAG_ESCALATION | STORY_TAG_CHAOTIC

	possible_events = list(
		/datum/round_event_control/falsealarm,
		/datum/round_event_control/space_dust,
		/datum/round_event_control/communications_blackout,
	)
