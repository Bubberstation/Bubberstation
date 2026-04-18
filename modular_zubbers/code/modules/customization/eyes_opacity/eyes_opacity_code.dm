/datum/preference/numeric/eyes_opacity
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "eyes_opacity"
	maximum = 255
	minimum = 0

/datum/preference/numeric/eyes_opacity/create_default_value()
	return maximum


/datum/preference/numeric/eyes_opacity/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences || is_visible(target, preferences))
		return FALSE
	var/obj/item/organ/eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	eyes.eyes_opacity = value
	return TRUE

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	species = new species

	return (savefile_key in species.get_features())

/datum/preference/numeric/eyes_opacity/apply_to_human(mob/living/carbon/human/target), value, datum/preferences/preferences)
	if(!preferences || !is_visible(target, preferences))
		return FALSE
	var/obj/item/organ/eyes = target.get_organ_slo
		return TRUE

///
/datum/preference/flag/eyes_opacity/

/datum/preference/eyes_opacity/create_default_value()
	return (255)
