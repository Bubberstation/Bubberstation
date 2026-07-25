
/**
 * Builds and returns a list of strings in accordance with the species names that an outfit has resprites for.
 *
 * This builds up a full set of /datum/data/vending_products from the product list of the vending machine type
 * Arguments:
 * * icon_state - The iconstate of the item. Usually, call this by the second argument, item.icon_state
 * * obj/item - The item path that we'll operate on, to check for refits.
 */
/proc/check_for_refits(icon_state, obj/item/referenced_item)
	var/list/available_refits = list()
	var/list/supported_species = list(
		SPECIES_TESHARI,
		SPECIES_VOX,
		SPECIES_VOX_PRIMALIS
	)

	var/refit_path
	var/item_slot
	var/list/icons_in_refit_path
	switch (initial(referenced_item.slot_flags))
		if (ITEM_SLOT_ICLOTHING)
			item_slot = "UNIFORM"
		if (ITEM_SLOT_OCLOTHING)
			item_slot = "SUIT"
		if (ITEM_SLOT_BELT)
			item_slot = "BELT"
		if (ITEM_SLOT_GLOVES)
			item_slot = "GLOVES"
		if (ITEM_SLOT_HEAD)
			item_slot = "HEAD"
		if (ITEM_SLOT_EARS)
			item_slot = "EARS"
		if (ITEM_SLOT_NECK)
			item_slot = "NECK"
		if (ITEM_SLOT_MASK)
			item_slot = "MASK"
		if (ITEM_SLOT_EYES)
			item_slot = "GLASSES"
		if (ITEM_SLOT_FEET)
			item_slot = "SHOES"
		else
			return list()
	for(var/cur_species in supported_species)
		if(cur_species==SPECIES_VOX_PRIMALIS) // Why was this named like this?
			cur_species = "better_vox"
		// Oh this is awful but its the only way from what I'm seeing.
		var/wornicon = "[referenced_item]:worn_icon_[cur_species]"
		if(!isnull(wornicon)) // If the species has a worn icon set here, count it too.
			refit_path = "modular_skyrat/master_files/icons/mob/clothing/species/[cur_species]/[item_slot].dmi"
			if(!fexists(refit_path))
				break
			icons_in_refit_path = icon_states(refit_path)
			if(icons_in_refit_path.Find(icon_state))
				available_refits += cur_species
		else
			available_refits += cur_species // We found a worn icon and it wasn't null, this is supported.

	return available_refits
