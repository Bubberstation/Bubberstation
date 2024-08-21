/datum/storyteller/peaceful
	name = "The Chill"
	desc = "The Chill will be light on events compared to other storytellers, especially so on ones involving combat, destruction, or chaos. Best for more chill rounds."
	welcome_text = "If you vote for this storyteller on icebox, you have no originality."
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 0.7,
		EVENT_TRACK_MAJOR = 0.7,
		EVENT_TRACK_ROLESET = 0.7,
		EVENT_TRACK_OBJECTIVES = 1,
		)
	guarantees_roundstart_roleset = FALSE
	tag_multipliers = list(
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1
	)
	antag_divisor = 32

/datum/controller/subsystem/gamemode/set_storyteller(...)
	if(SSmapping.config.map_name == "Ice Box Station")
		welcome_text = "Voting for The Chill on Ice Box? Really?"
	. = ..()
