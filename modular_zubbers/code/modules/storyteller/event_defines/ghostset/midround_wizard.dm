/datum/round_event_control/wizard_midround
	name = "Spawn Wizard (Midround)"
	category = EVENT_CATEGORY_ENTITIES
	description = "Spawns a wizard."
	typepath = /datum/round_event/ghost_role/wizard

	weight = 0 // Disabled for now, feel free to enable this later or run it for events.
	min_players = 50
	max_occurrences = 1

	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS

	dynamic_should_hijack = TRUE

	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_OUTSIDER_ANTAG, TAG_CHAOTIC)

/datum/round_event/ghost_role/wizard
	minimum_required = 1
	role_name = ROLE_WIZARD_MIDROUND
	fakeable = FALSE
