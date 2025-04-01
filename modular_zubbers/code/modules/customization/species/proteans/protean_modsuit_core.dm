/obj/item/mod/core/protean
	name = "MOD protean core"
	icon_state = "mod-core-ethereal"
	desc = "If you see this, go scream at a coder and tell them how you managed to do this."

	/// We handle as many interactions as possible through the species datum
	/// The species handles cleanup on this
	var/datum/species/protean/linked_species

/obj/item/mod/core/protean/charge_source()
	if(isnull(linked_species))
		CRASH("[type] does not have a linked species: [linked_species]")
	if(isnull(linked_species.owner))
		CRASH("[linked_species] does not have an owner.")
	return linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)

/obj/item/mod/core/protean/charge_amount()
	var/obj/item/organ/stomach/protean/stomach = charge_source()
	if(!istype(stomach))
		return
	return round(stomach.metal)

/obj/item/mod/core/protean/max_charge_amount()
	return PROTEAN_STOMACH_FULL

/// We don't charge in a standard way
/obj/item/mod/core/protean/add_charge(amount)
	return FALSE

/obj/item/mod/core/protean/subtract_charge(amount)
	return FALSE

/obj/item/mod/core/protean/check_charge(amount)
	return FALSE

/obj/item/mod/core/protean/get_charge_icon_state()
	return charge_source() ? "0" : "missing"
