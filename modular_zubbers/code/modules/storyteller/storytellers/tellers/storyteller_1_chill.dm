/datum/storyteller/chill
	name = "Chill (Low Chaos)"
	desc = "Do you find antags too stressful? Dislike the 'game' part of the video game? Boy do we have something for you! \
	Calm with a touch of PvE to prevent Nothing-Ever-Happens induced insanity."
	welcome_text = "Vote Result: Initiate Crew Transfer."

	track_data = /datum/storyteller_data/tracks/chill

	guarantees_roundstart_crewset = FALSE
	tag_multipliers = list(
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1,
		TAG_PVE = 0.5,
	)
	antag_divisor = 32
	storyteller_type = STORYTELLER_TYPE_CALM

/datum/storyteller_data/tracks/chill
	threshold_mundane = 1800
	threshold_moderate = 2000
	threshold_major = 16000
	threshold_crewset = 3600
	threshold_ghostset = 9000
