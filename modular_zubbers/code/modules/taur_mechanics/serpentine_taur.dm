/obj/item/organ/external/taur_body/serpentine/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	// These args must be the same as the args used to add the basic human footstep!
	organ_owner.RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	organ_owner.AddElement(/datum/element/footstep, FOOTSTEP_MOB_SNAKE, 15, -6)

/obj/item/organ/external/taur_body/serpentine/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	organ_owner.RemoveElement(/datum/element/footstep,  FOOTSTEP_MOB_SNAKE, 15, -6)
	organ_owner.AddElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)

	return ..()

