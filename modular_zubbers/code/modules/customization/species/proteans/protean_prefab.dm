/mob/living/carbon/human/species/protean
	race = /datum/species/protean

// Used for printing dead protean bodies
/mob/living/carbon/human/species/protean/empty

/mob/living/carbon/human/species/synth/protean/Initialize(mapload)
	. = ..()
	var/old_death_sound = death_sound // You can't do this with initial() as the death sound is set after by the species datum
	death_sound = null // We don't need them screaming
	death()

	var/obj/item/organ/stomach/protean/to_remove = get_organ_slot(ORGAN_SLOT_STOMACH) //No free parts for Proteans.
	QDEL_NULL(to_remove)

	var/obj/item/organ/heart/protean/to_remove = get_organ_slot(ORGAN_SLOT_HEART) //No free parts for Proteans.
	QDEL_NULL(to_remove)

	var/obj/item/organ/brain/protean/to_remove = get_organ_slot(ORGAN_SLOT_BRAIN)
	QDEL_NULL(to_remove)

	death_sound = old_death_sound // Now they can die loudly again
