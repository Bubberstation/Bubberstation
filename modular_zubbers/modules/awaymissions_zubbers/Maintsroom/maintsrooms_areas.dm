/area/awaymission/caves/maintsroom
	name = "maintsroom"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE
	area_flags = NOTELEPORT

/area/awaymission/caves/maintsroom/deeper
	name = "deeper"
	icon_state = "away3"
	ambience_index = AMBIENCE_WASTE
	sound_environment = SOUND_ENVIRONMENT_CAVE
	min_ambience_cooldown = 41 SECONDS
	max_ambience_cooldown = 42 SECONDS

/area/awaymission/caves/maintsroom/deeper/biome1
	name = "Valley of madness"
	icon_state = "away4"
	mood_bonus = -30
	mood_message = "I NEED TO GET OUT OF HERE."

/area/awaymission/caves/maintsroom/deeper/biome2
	name = "Valley of anomalies"
	icon_state = "awaycontent5"
	mood_bonus = 1
	mood_message = "A massive weight is off my shoulders!"

/area/awaymission/caves/maintsroom/deeper/biome3
	name = "Empty nothing"
	icon_state = "awaycontent6"
	ambience_index = AMBIENCE_GENERIC
	sound_environment = SOUND_ENVIRONMENT_NONE
	mood_bonus = 1
	mood_message = "Things are far calmer here."

/area/awaymission/caves/maintsroom/gaming_spatial
	name = "Gamer den"
	icon_state = "awaycontent8"
	ambience_index = AMBIENCE_GAMING
	sound_environment = SOUND_ENVIRONMENT_NONE
	min_ambience_cooldown = 59 SECONDS
	max_ambience_cooldown = 60 SECONDS

/area/awaymission/caves/maintsroom/lobby_spatial
	name = "serene lobby"
	icon_state = "awaycontent9"
	ambience_index = AMBIENCE_MAINTSROOMLOBBY
	sound_environment = SOUND_ENVIRONMENT_NONE
	min_ambience_cooldown = 114 SECONDS
	max_ambience_cooldown = 115 SECONDS

/area/awaymission/caves/maintsroom/vapor_spatial
	name = "vaporwave"
	icon_state = "awaycontent10"
	ambience_index = AMBIENCE_MAINTSROOMVAPOR
	sound_environment = SOUND_ENVIRONMENT_NONE
	min_ambience_cooldown = 132 SECONDS
	max_ambience_cooldown = 133 SECONDS

/area/awaymission/caves/maintsroom/gambling
	name = "gambling hall"
	icon_state = "awaycontent11"
	ambience_index = AMBIENCE_GAMBLING
	sound_environment = SOUND_ENVIRONMENT_NONE
	min_ambience_cooldown = 31 SECONDS
	max_ambience_cooldown = 32 SECONDS
