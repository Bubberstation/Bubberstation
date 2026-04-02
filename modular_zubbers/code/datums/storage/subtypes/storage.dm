/datum/storage/can_insert(obj/item/to_insert, mob/user, messages = TRUE, force = STORAGE_NOT_LOCKED)
	if(QDELETED(to_insert) || !istype(to_insert))
		return FALSE

	//stops you from putting stuff like off-hand thingy inside. Hologram storages can accept only hologram items
	if(to_insert.item_flags & ABSTRACT)
		return FALSE
	if(parent.flags_1 & HOLOGRAM_1)
		if(!(to_insert.flags_1 & HOLOGRAM_1))
			return FALSE
	else if(to_insert.flags_1 & HOLOGRAM_1)
		return FALSE

	if(locked > force)
		if(messages && user)
			user.balloon_alert(user, "closed!")
		return FALSE

	if((to_insert == parent) || (to_insert == real_location))
		return FALSE

	if(to_insert.w_class > max_specific_storage)
		if(!is_type_in_typecache(to_insert, exception_hold))
			if(messages && user)
				user.balloon_alert(user, "too big!")
			return FALSE
		if(exception_max <= get_exception_count())
			if(messages && user)
				user.balloon_alert(user, "no room!")
			return FALSE

	if(real_location.contents.len >= max_slots)
		if(messages && user && !silent_for_user)
			user.balloon_alert(user, "no room!")
		return FALSE

	if(to_insert.w_class + get_total_weight() > max_total_storage)
		if(messages && user && !silent_for_user)
			user.balloon_alert(user, "no room!")
		return FALSE

	var/can_hold_it = isnull(can_hold) || is_type_in_typecache(to_insert, can_hold) || is_type_in_typecache(to_insert, exception_hold)
	var/cant_hold_it = is_type_in_typecache(to_insert, cant_hold)
	var/trait_says_no = HAS_TRAIT(to_insert, TRAIT_NO_STORAGE_INSERT)
	if(!can_hold_it || cant_hold_it || trait_says_no)
		if(messages && user)
			user.balloon_alert(user, "can't hold!")
		return FALSE

	if(HAS_TRAIT(to_insert, TRAIT_NODROP) && (to_insert.item_flags & IN_INVENTORY))
		if(messages && user)
			user.balloon_alert(user, "stuck on your hand!")
		return FALSE

	// this is valid if the container our location is being held in is a storage item
	var/datum/storage/bigger_fish = parent.loc.atom_storage
	if(bigger_fish && bigger_fish.max_specific_storage < max_specific_storage)
		if(messages && user)
			user.balloon_alert(user, "[LOWER_TEXT(parent.loc.name)] is in the way!")
		return FALSE

	if(isitem(parent))
		var/obj/item/item_parent = parent
		var/datum/storage/smaller_fish = to_insert.atom_storage
		if(smaller_fish && !allow_big_nesting && to_insert.w_class >= item_parent.w_class)
			if(messages && user)
				user.balloon_alert(user, "too big!")
			return FALSE

	return TRUE
