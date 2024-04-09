/datum/antagonist/rev/head/equip_rev()
	var/mob/living/carbon/head_rev = owner.current
	if(!ishuman(head_rev))
		return
	. = ..()
	if(give_flash)
		var/obj/item/head_convert_device/hcd = new(head_rev)
		var/list/slots = list (
			"backpack" = ITEM_SLOT_BACKPACK,
			"left pocket" = ITEM_SLOT_LPOCKET,
			"right pocket" = ITEM_SLOT_RPOCKET
		)
		var/where = head_rev.equip_in_one_of_slots(hcd, slots, indirect_action = TRUE)
		if (!where)
			to_chat(head_rev, "The Syndicate were unfortunately unable to get you [hcd].")
		else
			to_chat(head_rev, "[hcd] in your [where] will help you to remove mindshields and force heads of staff to join your cause.")
