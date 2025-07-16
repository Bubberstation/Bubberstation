/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	. = ..()
	if(preferences.parent.is_vetted)
		return TRUE
	ASYNC
		SSplayer_ranks.is_vetted(preferences.parent, admin_bypass = FALSE)


/datum/preference/toggle/erp/is_accessible(datum/preferences/preferences)
	. = ..()
	if(preferences.parent.is_vetted)
		return TRUE

	ASYNC
		SSplayer_ranks.is_vetted(preferences.parent, admin_bypass = FALSE)

