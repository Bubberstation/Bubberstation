/datum/quirk
	// Is this quirk hidden from TGUI / the character preferences window?
	var/hidden_quirk = FALSE
	/// List of species that this quirk is valid for, or empty if it's valid for all species. Only use species ids here.
	var/list/species_whitelist = list()
	var/list/species_blacklist = list()

/datum/quirk/is_species_appropriate(datum/species/mob_species)
	if(length(species_whitelist))
		if(!(initial(mob_species.id) in species_whitelist))
			return FALSE
	if(length(species_blacklist))
		if(initial(mob_species.id) in species_blacklist)
			return FALSE

	. = ..()
