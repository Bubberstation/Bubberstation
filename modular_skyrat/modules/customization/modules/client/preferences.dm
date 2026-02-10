/// Cleans up any invalid languages. Typically happens on language renames and codedels.
/datum/preferences/proc/sanitize_languages()
	var/species_type = read_preference(/datum/preference/choiced/species)
	var/datum/species/species = GLOB.species_prototypes[species_type]
	var/list/whitelist = species.language_prefs_whitelist

	var/languages_edited = FALSE
	var/list/to_remove = list()

	for (var/lang_path in languages)
		if (!lang_path)
			to_remove += lang_path
			continue

		var/datum/language/language_prototype = GLOB.language_datum_instances[lang_path]
		// Path no longer exists
		if (isnull(language_prototype))
			to_remove += lang_path
			continue

		// If it's a secret language, ensure it's allowed
		if (language_prototype.secret && whitelist && isnull(whitelist[lang_path]))
			to_remove += lang_path

	// Only modify list once
	if (length(to_remove))
		languages -= to_remove
		languages_edited = TRUE

	return languages_edited

/// Cleans any quirks that should be hidden, or just simply don't exist from quirk code.
/datum/preferences/proc/sanitize_quirks()
	var/quirks_edited = FALSE
	for(var/datum/quirk/quirk as anything in all_quirks)
		if(!quirk || !(quirk in SSquirks.quirks))
			all_quirks.Remove(quirk)
			quirks_edited = TRUE
			continue

		quirk = SSquirks.quirks[quirk]
		// Explanation for this is above.
		if(!quirk || initial(quirk.hidden_quirk))
			all_quirks.Remove(quirk)
			quirks_edited = TRUE

	return quirks_edited
