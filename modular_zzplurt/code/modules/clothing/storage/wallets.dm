/obj/item/storage/wallet/tailbag
	name = "tailbag"
	desc = "A bag for holding small items. It fastens around the base of the tail."
	icon = 'modular_zzplurt/icons/obj/storage.dmi'
	worn_icon = 'modular_zzplurt/icons/obj/clothing/glasses.dmi' // Sorry for that
	worn_icon_state = "nothing" // Sorry for that
	icon_state = "tailbag"

/obj/item/storage/wallet/refreshID()
	LAZYCLEARLIST(combined_access)

	front_id = null
	var/winning_tally = 0
	var/is_magnetic_found = FALSE
	for(var/obj/item/card/id/id_card in contents)
		// Certain IDs can forcibly jump to the front so they can disguise other cards in wallets. Chameleon/Agent ID cards are an example of this.
		if(!is_magnetic_found && HAS_TRAIT(id_card, TRAIT_MAGNETIC_ID_CARD))
			is_magnetic_found = TRUE

		if(!is_magnetic_found)
			var/card_tally = SSid_access.tally_access(id_card, ACCESS_FLAG_COMMAND)
			if(card_tally > winning_tally)
				winning_tally = card_tally

		LAZYINITLIST(combined_access)
		combined_access |= id_card.access

	if(ishuman(loc))
		var/mob/living/carbon/human/wearing_human = loc
		if(wearing_human.wear_id == src)
			wearing_human.sec_hud_set_ID()

	update_label()
	update_appearance(UPDATE_ICON)
	update_slot_icon()


/obj/item/storage/wallet/tailbag/Initialize()
	. = ..()
	atom_storage.max_slots = 6
	atom_storage.can_hold += typecacheof(list( // Extra items that can go in tailbags, more than wallets
	/obj/item/restraints/handcuffs,
	/obj/item/assembly/flash,
	/obj/item/laser_pointer,
	/obj/item/modular_computer/pda,
	/obj/item/pai_card
	))
