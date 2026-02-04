/datum/view_data/proc/getScreenSize()
	var/pref_value = chief.prefs.read_preference(/datum/preference/choiced/widescreen)
	if(pref_value)
		return pref_value
	return SQUARE_VIEWPORT_SIZE
