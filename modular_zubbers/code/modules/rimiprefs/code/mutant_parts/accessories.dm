/// Head Accessories - Unless more get added, this is only able to be applied for one person, a donator only thing

/datum/preference/toggle/mutant_toggle/head_acc
	savefile_key = "head_acc_toggle"
	relevant_mutant_bodypart = "head_acc"

/datum/preference/toggle/mutant_toggle/head_acc/is_accessible(datum/preferences/preferences)
	var/ckeycheck = preferences?.parent?.ckey == "whirlsam"
	return ckeycheck && ..(preferences)

/datum/preference/choiced/mutant/head_acc
	savefile_key = "feature_head_acc"
	relevant_mutant_bodypart = "head_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/head_acc

/datum/preference/mutant_color/head_acc
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "head_acc_color"
	relevant_mutant_bodypart = "head_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/head_acc

/datum/preference/emissive_toggle/head_acc
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "head_acc_emissive"
	relevant_mutant_bodypart = "head_acc"

/// Neck Accessories - Same as head_acc

/datum/preference/toggle/mutant_toggle/neck_acc
	savefile_key = "neck_acc_toggle"
	relevant_mutant_bodypart = "neck_acc"

/datum/preference/toggle/mutant_toggle/neck_acc/is_accessible(datum/preferences/preferences)
	var/ckeycheck = preferences?.parent?.ckey == "whirlsam"
	return ckeycheck && ..(preferences)

/datum/preference/choiced/mutant/neck_acc
	savefile_key = "feature_neck_acc"
	relevant_mutant_bodypart = "neck_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/neck_acc

/datum/preference/mutant_color/neck_acc
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "neck_acc_color"
	relevant_mutant_bodypart = "neck_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/neck_acc

/datum/preference/emissive_toggle/neck_acc
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "neck_acc_emissive"
	relevant_mutant_bodypart = "neck_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/neck_acc
