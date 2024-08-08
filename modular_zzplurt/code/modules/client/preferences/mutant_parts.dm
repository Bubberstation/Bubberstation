/datum/preference/toggle/mutant_toggle/mandibles
	savefile_key = "mandibles_toggle"
	relevant_mutant_bodypart = "mandibles"

/datum/preference/choiced/mutant_choice/mandibles
	savefile_key = "feature_mandibles"
	relevant_mutant_bodypart = "mandibles"
	type_to_check = /datum/preference/toggle/mutant_toggle/mandibles
	default_accessory_type = /datum/sprite_accessory/arachnid_mandibles/none

/datum/preference/tri_color/mandibles_color
	savefile_key = "mandibles_color"
	relevant_mutant_bodypart = "mandibles"
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	type_to_check = /datum/preference/toggle/mutant_toggle/mandibles



/datum/preference/toggle/mutant_toggle/spinneret
	savefile_key = "spinneret_toggle"
	relevant_mutant_bodypart = "spinneret"

/datum/preference/choiced/mutant_choice/spinneret
	savefile_key = "feature_spinneret"
	relevant_mutant_bodypart = "spinneret"
	type_to_check = /datum/preference/toggle/mutant_toggle/spinneret
	default_accessory_type = /datum/sprite_accessory/arachnid_mandibles/none

/datum/preference/tri_color/spinneret_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "spinneret_color"
	relevant_mutant_bodypart = "spinneret"
	type_to_check = /datum/preference/toggle/mutant_toggle/spinneret



/datum/preference/toggle/mutant_toggle/arachnid_legs
	savefile_key = "arachnid_legs_toggle"
	relevant_mutant_bodypart = "arachnid_legs"

/datum/preference/choiced/mutant_choice/arachnid_legs
	savefile_key = "feature_arachnid_legs"
	relevant_mutant_bodypart = "arachnid_legs"
	type_to_check = /datum/preference/toggle/mutant_toggle/arachnid_legs
	default_accessory_type = /datum/sprite_accessory/arachnid_legs/none

/datum/preference/tri_color/arachnid_legs_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "arachnid_legs_color"
	relevant_mutant_bodypart = "arachnid_legs"
	type_to_check = /datum/preference/toggle/mutant_toggle/spinneret
