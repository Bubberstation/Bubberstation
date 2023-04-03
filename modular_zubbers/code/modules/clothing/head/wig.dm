/obj/item/clothing/head/wig
	var/obj/item/clothing/head/head_accessory
	var/mutable_appearance/head_accessory_MA

	var/overlay_on = FALSE

	var/mob/living/carbon/holder
	var/item_path

/obj/item/clothing/head/wig/attackby(obj/item/attachment, mob/living/user)
	. = ..()
	//Checks if the item is in the list of items available
	for(var/type in HEAD_ACCESSORIES_PATHS)	
		if(istype(attachment, type))
			item_path = type
			break

	if(item_path && !head_accessory)
		add_head_accessory(attachment)
	else
		to_chat(user, span_notice("You can't put \the [attachment.name] on the head of \the [holder.name]"))
		return

/obj/item/clothing/head/wig/proc/add_head_accessory(obj/item/clothing/attachment)
	//Get the mutable_appearance ready
	head_accessory_MA = mutable_appearance(attachment.worn_icon)
	head_accessory_MA.icon_state = attachment.icon_state
	attachment.forceMove(src) //Put the item in the wig

	if(holder)
		holder.add_overlay(head_accessory_MA)
		overlay_on = TRUE

	head_accessory = attachment

/obj/item/clothing/head/wig/attack_hand_secondary(mob/user)
	..()
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(head_accessory)
		remove_head_accessory(user)

/obj/item/clothing/head/wig/proc/remove_head_accessory(mob/user)
	user.put_in_active_hand(head_accessory)

	head_accessory = null
	item_path = null

	if(holder)
		holder.cut_overlay(head_accessory_MA)
		overlay_on = FALSE

	head_accessory_MA = null

/obj/item/clothing/head/wig/equipped(user, slot)
	. = ..()

	if(!(slot_flags & slot))
		return

	holder = user

	if(head_accessory && !overlay_on)
		holder.add_overlay(head_accessory_MA)
		overlay_on = TRUE

/obj/item/clothing/head/wig/dropped(mob/user)
	if(holder && overlay_on)
		holder.cut_overlay(head_accessory_MA)
		overlay_on = FALSE

	holder = null
	. = ..()
