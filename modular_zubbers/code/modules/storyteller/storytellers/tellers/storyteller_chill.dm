/datum/storyteller/chill
	name = "The Chill"
	desc = "The Chill will be light on events compared to other storytellers, especially so on ones involving combat, destruction, or chaos. Best for more chill rounds."
	welcome_text = "If you vote for this storyteller on Ice Box, you have no originality."

	track_data = /datum/storyteller_data/chill

	guarantees_roundstart_crewset = FALSE
	tag_multipliers = list(
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1
	)
	antag_divisor = 32

/datum/storyteller_data/chill
	var/threshold_mundane = 900
	var/threshold_moderate = 2700
	var/threshold_major = 10000
	var/threshold_crewset = 2400
