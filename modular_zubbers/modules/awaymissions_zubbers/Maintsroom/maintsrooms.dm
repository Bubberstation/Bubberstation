/area/awaymission/caves/maintsroom
	name = "maintsroom"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE
	area_flags = NOTELEPORT

/area/awaymission/caves/maintsroom/deeper
	name = "deeper"
	icon_state = "away3"
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_ENVIRONMENT_CAVE

/area/awaymission/caves/maintsroom/deeper/biome1
	name = "Valley of madness"
	icon_state = "away4"
	mood_bonus = -30
	mood_message = "I NEED TO GET OUT OF HERE."

/area/awaymission/caves/maintsroom/deeper/biome2
	name = "Valley of anomalies"
	icon_state = "awaycontent5"
	mood_bonus = 2
	mood_message = "I made it out of the valley!"

/area/awaymission/caves/maintsroom/deeper/biome3
	name = "Empty nothing"
	icon_state = "awaycontent6"
	ambience_index = AMBIENCE_GENERIC
	sound_environment = SOUND_ENVIRONMENT_NONE

/area/awaymission/caves/maintsroom/gaming_spatial
	name = "Empty nothing"
	icon_state = "awaycontent7"
	ambience_index = AMBIENCE_GAMING
	sound_environment = SOUND_ENVIRONMENT_NONE
