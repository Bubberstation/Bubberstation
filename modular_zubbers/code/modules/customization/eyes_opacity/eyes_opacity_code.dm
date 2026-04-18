/datum/preference/numeric/eyes_opacity
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "eyes_opacity"
	maximum = 255
	minimum = 0

/datum/preference/numeric/eyes_opacity/create_default_value()
	return maximum


/datum/preference/numeric/eyes_opacity/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences)
		return FALSE
	var/obj/item/organ/eyes/eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	eyes.eyes_opacity = value
	return TRUE
