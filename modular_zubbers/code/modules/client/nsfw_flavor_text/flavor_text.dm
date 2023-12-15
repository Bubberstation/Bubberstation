/datum/preference/text/flavor_text_nsfw
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text_nsfw"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/flavor_text_nsfw/create_default_value()
	return ""

/datum/preference/text/flavor_text_nsfw/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/flavor_text_nsfw/silicon
	savefile_key = "silicon_flavor_text_nsfw"

/datum/preference/choiced/show_nsfw_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "show_flavor_text_nsfw"

/datum/preference/choiced/show_nsfw_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/show_nsfw_flavor_text/init_possible_values()
	return list("Always On", "Nude Only", "Never")

/datum/preference/choiced/show_nsfw_flavor_text/create_default_value()
	return "Nude Only"
