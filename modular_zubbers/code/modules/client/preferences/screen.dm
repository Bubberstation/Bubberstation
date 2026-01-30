// Replaces the toggle preference with a dropdown
/datum/preference/choiced/widescreen
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "viewport_size"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/widescreen/init_possible_values()
	return list(
		SQUARE_VIEWPORT_SIZE,
		WIDESCREEN_VIEWPORT_SIZE,
		EXTRAWIDESCREEN_VIEWPORT_SIZE,
	)

/datum/preference/choiced/widescreen/create_default_value()
	return WIDESCREEN_VIEWPORT_SIZE

/datum/preference/choiced/widescreen/compile_constant_data()
	var/list/data = ..()

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = list(
		SQUARE_VIEWPORT_SIZE = "Square (15x15)",
		WIDESCREEN_VIEWPORT_SIZE = "Widescreen (19x15)",
		EXTRAWIDESCREEN_VIEWPORT_SIZE = "Ultrawide (21x15)",
	)

	return data

/datum/preference/choiced/widescreen/apply_to_client(client/client, value)
	client.view_size?.setDefault(VIEWPORT_USE_PREF)
