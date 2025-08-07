/obj/item/mod/core/protean
	name = "MOD protean core"
	icon_state = "mod-core-ethereal"
	desc = "If you see this, go scream at a coder and tell them how you managed to do this."

	/// We handle as many interactions as possible through the species datum
	/// The species handles cleanup on this
	var/datum/species/protean/linked_species

/obj/item/mod/core/protean/charge_source()
	if(isnull(linked_species))
		return
	if(isnull(linked_species.owner))
		return
	return linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)

/obj/item/mod/core/protean/charge_amount()
	var/obj/item/organ/stomach/protean/stomach = charge_source()
	var/obj/item/organ/brain/protean/brain = linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(stomach))
		return null
	if(brain.dead)
		return null
	return stomach.owner.nutrition

/obj/item/mod/core/protean/max_charge_amount()
	return NUTRITION_LEVEL_FULL

/// We don't charge in a standard way
/obj/item/mod/core/protean/add_charge(amount)
	return FALSE

/obj/item/mod/core/protean/subtract_charge(amount)
	return FALSE

/obj/item/mod/core/protean/check_charge(amount)
	var/obj/item/organ/stomach/protean/stomach = charge_source()
	var/obj/item/organ/brain/protean/brain = linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(stomach.owner.nutrition <= NUTRITION_LEVEL_STARVING)
		return FALSE
	if(!istype(brain) || brain.dead)
		return FALSE
	return TRUE

/obj/item/mod/core/protean/get_charge_icon_state()
	return charge_source() ? "0" : "missing"

/obj/item/mod/core/protean/get_chargebar_color()
	if(isnull(charge_amount()))
		return "transparent"
	switch(charge_amount())
		if (-INFINITY to NUTRITION_LEVEL_VERY_HUNGRY)
			return "bad"
		if(NUTRITION_LEVEL_VERY_HUNGRY to NUTRITION_LEVEL_FED)
			return "average"
		if(NUTRITION_LEVEL_FED to INFINITY)
			return "good"
