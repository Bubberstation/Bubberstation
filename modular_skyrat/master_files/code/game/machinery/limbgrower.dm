/obj/machinery/limbgrower/Initialize(mapload)
	categories += list(
		SPECIES_FELINE,
		SPECIES_HEMOPHAGE,
		SPECIES_TAJARAN,
		SPECIES_TESHARI,
		SPECIES_SHADEKIN,
		SPECIES_SNAIL
	)
	return ..()

// Used for printing dead bodies with the limbgrower
/mob/living/carbon/human/empty

/mob/living/carbon/human/empty/Initialize(mapload)
	. = ..()
	death()

	var/obj/item/organ/brain/to_remove = get_organ_slot(ORGAN_SLOT_BRAIN)
	QDEL_NULL(to_remove)
