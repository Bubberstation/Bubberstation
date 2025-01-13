// Used for printing dead bodies with the limbgrower
/mob/living/carbon/human/empty

/mob/living/carbon/human/empty/Initialize(mapload)
	. = ..()
	death()

	var/obj/item/organ/internal/brain/to_remove = get_organ_slot(ORGAN_SLOT_BRAIN)
	QDEL_NULL(to_remove)

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
