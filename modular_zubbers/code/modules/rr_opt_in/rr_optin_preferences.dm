/datum/preference/toggle/be_round_removed
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "be_round_removed"

/datum/preference/toggle/be_round_removed/create_default_value()
	return CONFIG_GET(flag/rr_opt_level_default)

/datum/preference/toggle/be_round_removed/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return (CONFIG_GET(flag/use_rr_opt_in_preferences))

/datum/preference/toggle/be_round_removed/deserialize(input, datum/preferences/preferences)
	if (!CONFIG_GET(flag/use_rr_opt_in_preferences))
		return CONFIG_GET(flag/rr_opt_level_default)

	return ..()

/datum/preference/toggle/be_round_removed/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
