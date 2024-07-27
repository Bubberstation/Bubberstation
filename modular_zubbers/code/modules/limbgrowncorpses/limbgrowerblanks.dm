// Used for printing dead bodies with the limbgrower
/mob/living/carbon/human/empty

/mob/living/carbon/human/empty/Initialize(mapload)
	. = ..()
	var/old_death_sound = death_sound // You can't do this with initial() as the death sound is set after by the species datum
	death_sound = null // We don't need them screaming
	death()

	var/obj/item/organ/internal/brain/B = get_organ_slot(ORGAN_SLOT_BRAIN)
	if(B)
		B.Remove(src)
		QDEL_NULL(B)

	death_sound = old_death_sound // Now they can die loudly again

/datum/design/wholehuman
	name = "Blank body"
	id = "blankhuman"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 600)
	build_path = /mob/living/carbon/human/empty
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)

/datum/design/humanoidbrain
	name = "Blank brain"
	id = "blankbrain"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 100)
	build_path = /obj/item/organ/internal/brain
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)
