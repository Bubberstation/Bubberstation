/datum/preference/toggle/mutant_toggle/mandibles
	savefile_key = "mandibles_toggle"
	relevant_mutant_bodypart = "mandibles"

/*
//ive been sitting at this shit for a literal day
//if you care to figure out how to make these appear for arachnids, be my guest
//i dont
/datum/preference/toggle/mutant_toggle/mandibles/is_accessible(datum/preferences/preferences)
	SHOULD_CALL_PARENT(FALSE)
	return preferences.read_preference(/datum/preference/choiced/species) == /datum/species/arachnid || preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
*/

/datum/preference/choiced/mutant_choice/mandibles
	savefile_key = "feature_mandibles"
	relevant_mutant_bodypart = "mandibles"
	type_to_check = /datum/preference/toggle/mutant_toggle/mandibles
	default_accessory_type = /datum/sprite_accessory/arachnid_mandibles/none

/datum/preference/color/mutant/mandibles_color
	savefile_key = "mandibles_color"
	relevant_mutant_bodypart = "mandibles"
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER



/datum/preference/toggle/mutant_toggle/spinneret
	savefile_key = "spinneret_toggle"
	relevant_mutant_bodypart = "spinneret"

//ditto here
/*
/datum/preference/toggle/mutant_toggle/spinneret/is_accessible(datum/preferences/preferences)
	SHOULD_CALL_PARENT(FALSE)
	return preferences.read_preference(/datum/preference/choiced/species) == /datum/species/arachnid || preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
*/

/datum/preference/choiced/mutant_choice/spinneret
	savefile_key = "feature_spinneret"
	relevant_mutant_bodypart = "spinneret"
	type_to_check = /datum/preference/toggle/mutant_toggle/spinneret
	default_accessory_type = /datum/sprite_accessory/arachnid_mandibles/none

/datum/preference/color/mutant/spinneret_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "spinneret_color"
	relevant_mutant_bodypart = "spinneret"



/datum/preference/toggle/mutant_toggle/arachnid_legs
	savefile_key = "arachnid_legs_toggle"
	relevant_mutant_bodypart = "arachnid_legs"

/*
//ditto here
/datum/preference/toggle/mutant_toggle/arachnid_legs/is_accessible(datum/preferences/preferences)
	SHOULD_CALL_PARENT(FALSE)
	return preferences.read_preference(/datum/preference/choiced/species) == /datum/species/arachnid || preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
*/

/datum/preference/choiced/mutant_choice/arachnid_legs
	savefile_key = "feature_arachnid_legs"
	relevant_mutant_bodypart = "arachnid_legs"
	type_to_check = /datum/preference/toggle/mutant_toggle/arachnid_legs
	default_accessory_type = /datum/sprite_accessory/arachnid_legs/none

/datum/preference/color/mutant/arachnid_legs_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "arachnid_legs_color"
	relevant_mutant_bodypart = "arachnid_legs"
