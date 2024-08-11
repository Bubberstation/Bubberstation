/datum/species/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, ignore_equipped, indirect_action)
	//if we're not trying to equip it to an extra slot
	if(!(slot & ITEM_SLOT_EXTRA))
		return ..()

	if((no_equip_flags & slot) && (no_equip_flags & ITEM_SLOT_EXTRA) && !(I.is_mod_shell_component() && (modsuit_slot_exceptions & slot))) // SKYRAT EDIT ADDITION - ORIGINAL: if(no_equip_flags & slot)
		if(!I.species_exception || !is_type_in_list(src, I.species_exception))
			return FALSE

	// if there's an item in the slot we want, fail
	if(!ignore_equipped)
		if(H.get_item_by_slot(slot))
			return FALSE

	// this check prevents us from equipping something to a slot it doesn't support, WITH the exceptions of storage slots (pockets, suit storage, and backpacks)
	// we don't require having those slots defined in the item's slot_flags, so we'll rely on their own checks further down
	if(!(I.extra_slot_flags & (slot & ~ITEM_SLOT_EXTRA)))
		return FALSE

	switch(slot)
		if(ITEM_SLOT_WRISTS)
			if(H.num_hands < 2)
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_UNDERWEAR)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_SOCKS)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_SHIRT)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_BRA)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)

	return FALSE //Unsupported slot
