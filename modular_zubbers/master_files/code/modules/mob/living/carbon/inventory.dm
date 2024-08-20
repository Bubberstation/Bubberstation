//ERP slot item checker

/mob/living/carbon/human/proc/get_erp_slots()
	return list(
		wear_vagina,
		wear_penis,
		wear_anus,
		wear_nipples,
		)

/mob/living/carbon/get_item_by_erp_slot(slot_id)
	switch(slot_id)
		if(LEWD_SLOT_VAGINA)
			return wear_vagina
		if(LEWD_SLOT_PENIS)
			return wear_penis
		if(LEWD_SLOT_ANUS)
			return wear_anus
		if(LEWD_SLOT_NIPPLES)
			return wear_nipples

	return ..()

/mob/living/carbon/get_erp_slot_by_item(obj/item/looking_for)
	if(looking_for == wear_vagina)
		return LEWD_SLOT_VAGINA
	if(looking_for == wear_penis)
		return LEWD_SLOT_PENIS
	if(looking_for == wear_anus)
		return LEWD_SLOT_ANUS
	if(looking_for == wear_nipples)
		return LEWD_SLOT_NIPPLES

	return ..()
