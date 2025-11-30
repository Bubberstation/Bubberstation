// Used for printing dead protean bodies
/mob/living/carbon/human/species/protean/empty

/mob/living/carbon/human/species/protean/empty/Initialize(mapload)
	. = ..()
	var/obj/item/organ/heart/to_remove_heart = get_organ_slot(ORGAN_SLOT_HEART) //No free parts for Proteans.
	QDEL_NULL(to_remove_heart)

	src.adjust_brute_loss(250) //Death is not apart of our species, so we must take another approach for vessels. (This will not kill them, but leave them in a state in which a head maybe entered, in which the vessel will turn into a MODSuit)

	var/obj/item/organ/brain/to_remove_brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	QDEL_NULL(to_remove_brain)
