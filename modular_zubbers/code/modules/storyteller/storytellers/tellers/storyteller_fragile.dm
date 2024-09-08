/datum/storyteller/fragile
	name = "The Fragile"
	desc = "The Fragile will limit destructive, combat-focused, and chaotic events. You'll rarely see midround antagonist roles that usually cause it."
	welcome_text = "Handle with care!"

	event_repetition_multiplier = 0.5

	track_data = /datum/storyteller_data/tracks/fragile

	tag_multipliers = list(
		TAG_COMBAT = 0.5,
		TAG_DESTRUCTIVE = 0.1,
		TAG_CHAOTIC = 0.1
	)

/datum/storyteller_data/tracks/fragile
	var/threshold_mundane = 1200
	var/threshold_moderate = 1800
	var/threshold_major = 8000
	var/threshold_crewset = 3000
	var/threshold_ghostset = 8000
