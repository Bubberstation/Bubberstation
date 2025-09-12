/datum/quirk
	// Is this quirk hidden from TGUI / the character preferences window?
	var/hidden_quirk = FALSE
	/// Blacklist of species for this quirk
	var/list/species_blacklist = null
	/// Whitelist of species for this quirk
	var/list/species_whitelist = null

/datum/quirk/is_species_appropriate(datum/species/mob_species)
	if(LAZYLEN(species_blacklist) && (mob_species.id in species_blacklist))
		return FALSE
	if(LAZYLEN(species_whitelist) && !(mob_species.id in species_whitelist))
		return FALSE
	return ..()
