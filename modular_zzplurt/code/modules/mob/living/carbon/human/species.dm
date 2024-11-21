/datum/species/New()
	var/list/extra_offset_features = list(
		OFFSET_UNDERWEAR = list(0,0),
		OFFSET_SOCKS = list(0,0),
		OFFSET_SHIRT = list(0,0),
		OFFSET_WRISTS = list(0,0)
	)
	LAZYADD(offset_features, extra_offset_features)
	. = ..()

/datum/species/handle_body(mob/living/carbon/human/species_human)
	. = ..()

	//Underwear, Undershirts, & Socks

	var/dummy_test = istype(species_human, /mob/living/carbon/human/dummy) && (usr?.client?.prefs.preview_pref == PREVIEW_PREF_NAKED || usr?.client?.prefs.preview_pref == PREVIEW_PREF_NAKED_AROUSED) //hacky af but it works
	var/list/obj/item/clothing/underwear/worn_underwear = list()

	if(!HAS_TRAIT(species_human, TRAIT_NO_UNDERWEAR) && !dummy_test)
		if(species_human.underwear && species_human.underwear != "Nude" && !(species_human.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear = SSaccessories.underwear_list[species_human.underwear]
			if(underwear && !species_human.w_underwear)
				var/obj/item/clothing/underwear/briefs/briefs_obj = new underwear.briefs_obj(species_human)
				species_human.equip_to_slot_or_del(briefs_obj, ITEM_SLOT_UNDERWEAR)
				worn_underwear += briefs_obj

		if(species_human.bra && species_human.bra != "Nude" && !(species_human.underwear_visibility & UNDERWEAR_HIDE_BRA))
			var/datum/sprite_accessory/bra/bra = SSaccessories.bra_list[species_human.bra]
			if(bra && !species_human.w_bra)
				var/obj/item/clothing/underwear/shirt/bra/bra_obj = new bra.bra_obj(species_human)
				species_human.equip_to_slot_or_del(bra_obj, ITEM_SLOT_BRA)
				worn_underwear += bra_obj

		if(species_human.undershirt && !species_human.undershirt != "Nude" && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt = SSaccessories.undershirt_list[species_human.undershirt]
			if(undershirt && !species_human.w_shirt)
				var/obj/item/clothing/underwear/shirt/shirt_obj = new undershirt.shirt_obj(species_human)
				species_human.equip_to_slot_or_del(shirt_obj, ITEM_SLOT_SHIRT)
				worn_underwear += shirt_obj

		if(species_human.socks && species_human.num_legs >= 2 && !(mutant_bodyparts["taur"]) && !species_human.socks != "Nude" && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks = SSaccessories.socks_list[species_human.socks]
			if(socks && !species_human.w_socks)
				var/obj/item/clothing/underwear/socks/socks_obj = new socks.socks_obj(species_human)
				species_human.equip_to_slot_or_del(socks_obj, ITEM_SLOT_SOCKS)
				worn_underwear += socks_obj

		//Make sure character creation knows it's an inventory object
		if(istype(species_human, /mob/living/carbon/human/dummy))
			for(var/obj/item/clothing/underwear/underwear_obj in worn_underwear)
				if(QDELETED(underwear_obj))
					continue
				underwear_obj.item_flags |= IN_INVENTORY
