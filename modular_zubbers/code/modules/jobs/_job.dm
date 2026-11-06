/datum/job
	/// The job's outfit that will be assigned for Vox
	var/vox_outfit = null
	/// The job's outfit that will be assigned for Akula
	var/akula_outfit = null
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null
	/// Whether the ID of the job can be tagged as an intern at all
	var/can_be_intern = TRUE
	/// Whether the job uses its own EXP to define the internship status
	var/internship_use_self_exp_type = FALSE
	/// How much does this job raise the storytellers antag cap by?
	var/sec_antag_cap = 0
	///With this set to TRUE, the loadout will be applied before a job clothing will be
	var/no_dresscode
	//Whether the job can use the loadout system
	var/loadout = TRUE
	//List of banned quirks in their names(dont blame me, that's how they're stored), players can't join as the job if they have the quirk. Associative for the purposes of performance
	var/list/banned_quirks
	/// List of banned augments
	var/list/banned_augments
	/// Whether or not a hand is required
	var/is_hand_required = FALSE
	///A list of slots that can't have loadout items assigned to them if no_dresscode is applied, used for important items such as ID, PDA, backpack and headset
	var/list/blacklist_dresscode_slots
	//Whitelist of allowed species for this job. If not specified then all roundstart races can be used. Associative with TRUE
	var/list/species_whitelist
	//Blacklist of species for this job.
	var/list/species_blacklist
	// BUBBER TODO - Change this mess of required languages - the vast majority of jobs have required languages
	// set to `null`, with a few distinct ones actually having it set. It might be a good idea
	// to revert that.
	/// Which languages does the job require, associative to UNDERSTOOD_LANGUAGE or (UNDERSTOOD_LANGUAGE | SPOKEN_LANGUAGE)
	var/list/required_languages = list(/datum/language/common = (UNDERSTOOD_LANGUAGE | SPOKEN_LANGUAGE))

/datum/job/proc/has_banned_quirk(datum/preferences/pref)
	if(!pref) //No preferences? We'll let you pass, this time (just a precautionary check,you dont wanna mess up gamemode setting logic)
		return FALSE
	if(banned_quirks)
		for(var/Q in pref.all_quirks)
			if(banned_quirks[Q])
				var/exception = RESTRICTED_QUIRKS_EXCEPTIONS[Q]
				if (!exception || !pref.all_quirks.Find(exception))
					return TRUE
	return FALSE

/datum/job/proc/has_banned_species(datum/preferences/pref)
	var/species_type = pref.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	var/my_id = species.id
	if(species_whitelist && !species_whitelist[my_id])
		return TRUE
	else if(!(my_id in get_selectable_species()))
		return TRUE
	if(species_blacklist && species_blacklist[my_id])
		return TRUE
	return FALSE

/datum/job/proc/has_banned_augment(datum/preferences/pref)
	if(!pref)
		return FALSE

	if(!banned_augments)
		return FALSE

	var/list/player_augments = pref.augments
	for(var/key in player_augments)
		if(player_augments[key] in banned_augments)
			return TRUE

	return FALSE

/datum/job/proc/has_enough_hands(datum/preferences/pref)
	if(!pref)
		return TRUE

	var/list/player_augments = pref.augments
	var/is_missing_left_arm = player_augments["Left Arm"] == /obj/item/bodypart/arm/left/self_destruct
	var/is_missing_right_arm = player_augments["Right Arm"] == /obj/item/bodypart/arm/right/self_destruct

	if(is_hand_required && is_missing_left_arm && is_missing_right_arm)
		return FALSE

	return TRUE

/datum/job/proc/has_required_languages(datum/preferences/pref)
	if(!required_languages)
		return TRUE

	for(var/datum/language/lang as anything in required_languages)
		//Doesnt have language, or the required "level" is too low (understood, while needing spoken)
		if((!pref.languages[lang] || pref.languages[lang] < required_languages[lang]))
			return FALSE
	return TRUE
