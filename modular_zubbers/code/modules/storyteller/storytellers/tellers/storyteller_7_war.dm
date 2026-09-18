/datum/storyteller/npc_war
	name = "LV3 Events (Hostile NPCs)"
	desc = "This storyteller heavily prioritizes spawning in NPC antagonists to keep combat roles active in-round. Player antagonists have the same incidence rate."
	welcome_text = "WAR! HOO! What is it good for? Absolutely NOTHING!"

	tag_multipliers = list(
		TAG_NPC_ANTAG = 4, //fuck em
	)
	population_min = 35
	storyteller_type = STORYTELLER_TYPE_INTENSE

	guarantees_roundstart_crewset = TRUE

	track_data = /datum/storyteller_data/tracks/npc_war

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.6,
		EVENT_TRACK_MODERATE = 0.8,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_CREWSET = 1,
		EVENT_TRACK_GHOSTSET = 0
	)
	event_repetition_multiplier = 1

/datum/storyteller_data/tracks/npc_war
	threshold_mundane = 1200
	threshold_moderate = 1600
	threshold_major = 3000
	threshold_crewset = 2400
	threshold_ghostset = 6000
