/datum/storyteller/chill
	name = "Chill (Low Chaos)"
	desc = "Light on events with reduced weighting of destructive, combat-focused, and chaotic events. Lower crew-to-antag ratio and no roundstart antag selection."
	welcome_text = "Handle with care!"

	storyteller_type = STORYTELLER_TYPE_CALM
	track_data = /datum/storyteller_data/tracks/light
	guarantees_roundstart_crewset = FALSE
	antag_divisor = 16
	tag_multipliers = list(
		TAG_COMBAT = 0.5,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1,
		TAG_BIG_THREE = 0,
	)

/datum/storyteller_data/tracks/light
	threshold_mundane = 1400
	threshold_moderate = 2400
	threshold_major = 10000
	threshold_crewset = 3200
	threshold_ghostset = 8000
