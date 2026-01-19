/datum/preference/text/flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["flavor_text"] = value

/datum/preference/text/silicon_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN
	// This does not get a apply_to_human proc, this is read directly in silicon/robot/examine.dm

/datum/preference/text/silicon_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE // To prevent the not-implemented runtime

/datum/preference/text/ooc_notes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ooc_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/ooc_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ooc_notes"] = value

/datum/preference/text/custom_species
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_species"
	maximum_value_length = 100

/datum/preference/text/custom_species/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["custom_species"] = value

/datum/preference/text/custom_species/is_accessible(datum/preferences/preferences)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	if(species_type)
		if(initial(species_type.lore_protected))
			return FALSE
	return ..()

/datum/preference/text/taste
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_taste"
	maximum_value_length = 100

/datum/preference/text/taste/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["taste"] = value
	return FALSE

/datum/preference/text/smell
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_smell"
	maximum_value_length = 100

/datum/preference/text/smell/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["smell"] = value
	return FALSE

/datum/preference/text/custom_species_lore
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_species_lore"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/custom_species_lore/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["custom_species_lore"] = value

/datum/preference/text/custom_species_lore/is_accessible(datum/preferences/preferences)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	if(species_type)
		if(initial(species_type.lore_protected))
			return FALSE
	return ..()


// RP RECORDS REJUVINATION - All of these are handled in datacore, so we dont apply it to the human.
/datum/preference/text/general
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "general_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/general/create_default_value()
	return "PERSONAL INFORMATION \n\ Name: \n\ Species: \n\ Physical Description: Height, weight, visible age \n\ Birthdate: \n\ Homeworld: \n\ Preferred Language: \n\ Spoken Languages: \n\ Contact Info: Home, next of kin, phone number"

/datum/preference/text/general/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/medical
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "medical_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/medical/create_default_value()
	return "PHYSICAL EVALUATIONS \n\ \n\ PSYCHOLOGICAL EVALUATIONS \n\ \n\ MEDICATION HISTORY \n\ \n\ SURGICAL HISTORY \n\ \n\ DOCTOR NOTES:"

/datum/preference/text/medical/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/security
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "security_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/security/create_default_value()
	return "EDUCATION \n\ \n\ EMPLOYMENT HISTORY \n\ Employed since: \n\ CRIMINAL HISTORY \n\ \n\ Loyalty Rating: \n\ Pressure Points: points used to control crewmember \n\ \n\ CASEWORKER NOTES:"

/datum/preference/text/security/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
