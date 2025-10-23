// Override file for handling additional effects.
// For now, we're just adding an override for blood vomiting.
/mob/living/carbon/vomit(vomit_flags, vomit_type, lost_nutrition, distance, purge_ratio)

	// Override to make hemos vomit blood when they vomit.
	var/obj/item/organ/stomach/stomach = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!(vomit_flags & MOB_VOMIT_BLOOD) && HAS_TRAIT(stomach, TRAIT_STOMACH_BLOOD_VOMIT))
		vomit_flags |= MOB_VOMIT_BLOOD

	. = ..()
