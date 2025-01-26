/// Enables the choice of background in the character preview menu
/datum/preference/choiced/bgstate
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "bgstate"
	savefile_identifier = PREFERENCE_PLAYER
	should_generate_icons = FALSE

GLOBAL_LIST_INIT(bgstate_options, list(
	"000" = "Pure Black",
	"midgrey" = "Grey",
	"FFF" = "Pure White",
	"white" = "White Tiles",
	"plasteel" = "Tiles",
	"dark" = "Dark Tiles",
	"plating" = "Plating",
	"reinforced" = "Reinforced Plating",
	))

/datum/preference/choiced/bgstate/create_default_value()
	return "000"

/datum/preference/choiced/bgstate/init_possible_values()
	return GLOB.bgstate_options

//backgrounds
/datum/preferences
	var/mutable_appearance/character_background
	var/icon/bgstate = (player.client?.prefs?.read_preference(/datum/preference/choiced/bgstate))

