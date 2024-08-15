/datum/preference/toggle/use_tgui_player_panel
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "use_tgui_player_panel"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/use_tgui_player_panel/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return is_admin(preferences.parent)
