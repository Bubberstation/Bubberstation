/datum/storyteller/gamer
	name = "Gamer (High Chaos)"
	desc = "The Gamer will try to create the most combat focused events, while trying to avoid purely destructive ones. \
	More combat-focused and frequent events than the Default, but stays ordered to avoid creating a hellshift."
	welcome_text = "Welcome to the Gamer storyteller. Now with 50% more ahelps!"

	storyteller_type = STORYTELLER_TYPE_INTENSE
	track_data = /datum/storyteller_data/tracks/heavy
	guarantees_roundstart_crewset = TRUE
	antag_divisor = 5
	tag_multipliers = list(
		TAG_COMBAT = 1.5,
		TAG_DESTRUCTIVE = 0.7,
		TAG_CHAOTIC = 1.3,
		TAG_BIG_THREE = 1.1,
	)

/datum/storyteller_data/tracks/heavy
	threshold_moderate = 1300
	threshold_major = 4000
	threshold_ghostset = 6000
