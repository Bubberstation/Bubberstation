/datum/quirk
	// Is this quirk hidden from TGUI / the character preferences window?
	var/hidden_quirk = FALSE
	/// List of species that this quirk is valid for, or empty if it's valid for all species. Only use species ids here.
	var/list/species_whitelist = list()

/datum/quirk/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE)
	if(!can_add(new_holder))
		CRASH("Attempted to add quirk to holder that can't have it.")
	. = ..()

/// Returns true if the quirk is valid for the target, call parent so qurk_species_whitelist can be checked.
/datum/quirk/proc/can_add(mob/target)
	SHOULD_CALL_PARENT(TRUE)
	if(length(species_whitelist))
		if(!ishuman(target))
			return FALSE
		var/mob/living/carbon/human = target
		if(!(human?.dna.species.id in species_whitelist))
			return FALSE
	return TRUE
