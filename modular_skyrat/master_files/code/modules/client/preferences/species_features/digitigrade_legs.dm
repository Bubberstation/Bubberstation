/// Legs
/datum/preference/choiced/digitigrade_legs
	savefile_key = "digitigrade_legs"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"


/datum/preference/choiced/digitigrade_legs/create_default_value()
	return NORMAL_LEGS


/datum/preference/choiced/digitigrade_legs/init_possible_values()
	return list(NORMAL_LEGS, DIGITIGRADE_LEGS)

/datum/preference/choiced/digitigrade_legs/is_accessible(datum/preferences/preferences)
	return ..() && is_usable(preferences)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns if feature value is usable.
 *
 * Arguments:
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/digitigrade_legs/proc/is_usable(datum/preferences/preferences)
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type

	return (savefile_key in species.get_features()) \
		&& species.digitigrade_customization == DIGITIGRADE_OPTIONAL

/datum/preference/choiced/digitigrade_legs/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences || !is_usable(preferences))
		return FALSE

	var/old_value = target.dna.features["legs"]
	if(value == old_value)
		return FALSE

	target.dna.features["legs"] = value

	if(value == DIGITIGRADE_LEGS)
		target.dna.species.try_make_digitigrade(target)
	else
		// This fucking sucks but initial doesnt do lists and we need to clear this out
		var/datum/species/cursed_species_we_need_for_a_list
		if(ispath(target.dna.species.type))
			cursed_species_we_need_for_a_list = new target.dna.species.type
		target.dna.species.bodypart_overrides = cursed_species_we_need_for_a_list.bodypart_overrides
	target.update_body()
	target.dna.species.replace_body(target,target.dna.species) // TODO: Replace this with something less stupidly expensive.
	return TRUE
