/datum/preference/name/syndicate
	explanation = "Syndicate name"
	group = "backup_human"
	savefile_key = "antag_name"

/datum/preference/name/syndicate/create_informed_default_value(datum/preferences/preferences)
	var/gender = preferences.read_preference(/datum/preference/choiced/gender)

	return generate_random_name(gender)
