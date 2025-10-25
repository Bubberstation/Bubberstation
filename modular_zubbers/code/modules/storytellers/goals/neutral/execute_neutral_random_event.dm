/datum/storyteller_goal/execute_random_event/neutral
	id = "execute_bad_random_event"
	name = "Execute Bad Random Event"
	desc = "Triggers a random negative event from the SSevents event pool."
	children = list()
	category = STORY_GOAL_NEUTRAL
	event_path = STORY_TAG_CHAOTIC

	possible_events = list(
		/datum/round_event_control/bureaucratic_error,
		/datum/round_event_control/fake_virus,
		/datum/round_event_control/grey_tide,
		/datum/round_event_control/grid_check,
		/datum/round_event_control/mass_hallucination,
		/datum/round_event_control/mice_migration,
	)
