// In PREFS 1 - Togglable stuff
/datum/preference/toggle/custom_blood_color
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_blood_color"
	default_value = FALSE

/datum/preference/toggle/custom_blood_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE

// In PREFS 2 - Color of Blood itself
/datum/preference/color/blood_color
	priority = PREFERENCE_PRIORITY_SPECIES
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blood_color"

/datum/preference/color/blood_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.species.exotic_blood_color = value

	//Might cause issues, remove if so
	for(var/obj/item/organ/organ in target.organs)
		if(!IS_ROBOTIC_ORGAN(organ))
			organ.blood_dna_info = target.get_blood_dna_list()
			organ.forensics?.blood_DNA["color"] = value

	return TRUE

/datum/preference/color/blood_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/custom_blood_color)

/datum/preference/color/create_default_value()
	return BLOOD_COLOR_STANDARD
