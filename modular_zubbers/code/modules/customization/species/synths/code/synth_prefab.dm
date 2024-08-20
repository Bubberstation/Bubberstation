/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

// Used for printing dead synth bodies
/mob/living/carbon/human/species/synth/empty

/mob/living/carbon/human/species/synth/empty/Initialize(mapload)
	. = ..()
	var/old_death_sound = death_sound // You can't do this with initial() as the death sound is set after by the species datum
	death_sound = null // We don't need them screaming
	death()

	var/obj/item/organ/internal/brain/to_remove = get_organ_slot(ORGAN_SLOT_BRAIN)
	QDEL_NULL(to_remove)

	death_sound = old_death_sound // Now they can die loudly again
