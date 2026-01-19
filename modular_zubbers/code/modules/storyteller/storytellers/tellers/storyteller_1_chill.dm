/datum/storyteller/chill
	name = "Chill (Low Chaos)"
	desc = "The Chill will be light on events compared to other storytellers, especially so on ones involving combat, destruction, or chaos. \
	The least hectic storyteller of all, while still having some spice. Best for RP-focused rounds with a few events sprinkled in."
	welcome_text = "If you vote for this storyteller on Ice Box, you have no originality."

	track_data = /datum/storyteller_data/tracks/chill

	guarantees_roundstart_crewset = FALSE
	tag_multipliers = list(
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1
	)
	antag_divisor = 32
	storyteller_type = STORYTELLER_TYPE_CALM

/datum/storyteller_data/tracks/chill
	threshold_mundane = 1800
	threshold_moderate = 2700
	threshold_major = 16000
	threshold_crewset = 3200
	threshold_ghostset = 20000
