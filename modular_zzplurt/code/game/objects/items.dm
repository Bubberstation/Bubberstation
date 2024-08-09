/obj/item
	// Extra inventory
	var/hide_underwear_examine = FALSE

	var/extra_slot_flags = NONE

/obj/item/update_slot_icon()
	. = ..()
	if(!ismob(loc))
		return
	var/mob/owner = loc
	var/flags = extra_slot_flags
	// Extra inventory
	if((flags & ITEM_SLOT_UNDERWEAR) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_underwear()
	if((flags & ITEM_SLOT_SOCKS) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_socks()
	if((flags & ITEM_SLOT_SHIRT) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_shirt()
	if((flags & ITEM_SLOT_BRA) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_bra()
	if((flags & ITEM_SLOT_EARS_RIGHT) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_ears_extra()
	if((flags & ITEM_SLOT_WRISTS) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_wrists()
	//
