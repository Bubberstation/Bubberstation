/datum/quirk
	// Is this quirk hidden from TGUI / the character preferences window?
	var/hidden_quirk = FALSE
	/// Blacklist of species for this quirk
	var/list/species_blacklist = null
	/// Whitelist of species for this quirk
	var/list/species_whitelist = null

/datum/quirk/item_quirk
	/// If TRUE, giving an item to our holder will instead delete it. Used for quirk reapplying.
	var/item_giving_paused = FALSE
	/// if TRUE, item_giving_paused is ignored.
	var/always_spawn_item = FALSE

/datum/quirk/proc/set_item_giving_paused(new_value)
	return

/datum/quirk/item_quirk/set_item_giving_paused(new_value)
	item_giving_paused = new_value

/datum/quirk/is_species_appropriate(datum/species/mob_species)
	if(LAZYLEN(species_blacklist) && (mob_species.id in species_blacklist))
		return FALSE
	if(LAZYLEN(species_whitelist) && !(mob_species.id in species_whitelist))
		return FALSE
	return ..()
