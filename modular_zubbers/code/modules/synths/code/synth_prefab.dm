/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

/mob/living/carbon/human/species/synth/empty

/mob/living/carbon/human/species/synth/empty/Initialize(mapload)
	. = ..()
	death_sound = null
	death()

	for(var/obj/item/organ/internal/brain/B in organs)
		B.Remove(src)
		QDEL_NULL(B)
	initial(death_sound)
