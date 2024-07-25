/obj/item
	// Extra inventory
	var/hide_underwear_examine = FALSE

/obj/item/update_slot_icon()
	. = ..()
	if(!ismob(loc))
		return
	var/mob/owner = loc
	var/flags = slot_flags
	// Extra inventory
	if(flags & ITEM_SLOT_UNDERWEAR)
		owner.update_worn_underwear()
	if(flags & ITEM_SLOT_SOCKS)
		owner.update_worn_socks()
	if(flags & ITEM_SLOT_SHIRT)
		owner.update_worn_shirt()
	if(flags & ITEM_SLOT_BRA)
		owner.update_worn_bra()
	if(flags & ITEM_SLOT_EARS)
		owner.update_worn_ears_extra()
	if(flags & ITEM_SLOT_WRISTS)
		owner.update_worn_wrists()
	//
