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

/datum/job/proc/has_required_languages(datum/preferences/pref)
	if(!required_languages)
		return TRUE

	for(var/datum/language/lang as anything in required_languages)
		//Doesnt have language, or the required "level" is too low (understood, while needing spoken)
		if((!pref.languages[lang] || pref.languages[lang] < required_languages[lang]))
			return FALSE
	return TRUE
