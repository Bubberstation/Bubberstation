/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

// Used for printing dead synth bodies
/mob/living/carbon/human/species/synth/empty

/mob/living/carbon/human/species/synth/empty/Initialize(mapload)
	. = ..()
	var/old_death_sound
	death_sound = null // We don't need them screaming
	death()

	for(var/obj/item/organ/internal/brain/B in organs)
		B.Remove(src)
		QDEL_NULL(B)

	death_sound = old_death_sound // Now they can die loudly again
