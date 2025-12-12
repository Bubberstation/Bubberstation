/datum/species/proc/allows_food_preferences()
	return TRUE

/**
 * Returns a list of strings representing features this species has.
 *
 * Used by the preferences UI to know what buttons to show.
 */
/datum/species/proc/get_features()
	var/cached_features = GLOB.features_by_species[type]
	if (!isnull(cached_features))
		return cached_features

	var/list/features = list()
	var/list/mut_organs = get_organs()

	for (var/preference_type in GLOB.preference_entries)
		var/datum/preference/preference = GLOB.preference_entries[preference_type]

		if ( \
			(preference.relevant_mutant_bodypart in GLOB.default_mutant_bodyparts[name]) \
			|| (preference.relevant_inherent_trait in inherent_traits) \
			|| (preference.relevant_head_flag && check_head_flags(preference.relevant_head_flag)) \
			|| (preference.relevant_organ in mut_organs) \
		)
			features += preference.savefile_key

	GLOB.features_by_species[type] = features

	return features


/datum/species/proc/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	return

/datum/species/create_pref_traits_perks()
	. = ..()

	if (TRAIT_WATER_BREATHING in inherent_traits)
		. += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_FISH,
			SPECIES_PERK_NAME = "Waterbreathing",
			SPECIES_PERK_DESC = "[plural_form] can breathe in water, making pools a lot safer to be in!",
		))
