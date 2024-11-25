/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	. = ..()
	if(.)
		if(!SSplayer_ranks.is_vetted(preferences.parent, admin_bypass = FALSE))
			return FALSE
	return .

/datum/preference/toggle/erp/is_accessible(datum/preferences/preferences)
	. = ..()
	if(.)
		if(!SSplayer_ranks.is_vetted(preferences.parent, admin_bypass = FALSE))
			return FALSE
	return .
