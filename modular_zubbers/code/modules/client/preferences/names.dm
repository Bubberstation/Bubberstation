/datum/preference/name/antag
	explanation = "Antagonist name"
	group = "antag"
	savefile_key = "antag_name"

/datum/preference/name/antag/create_informed_default_value(datum/preferences/preferences)
	var/gender = preferences.read_preference(/datum/preference/choiced/gender)

	return random_unique_name(gender)
