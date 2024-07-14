/obj/item/organ/external/taur_body/serpentine/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	organ_owner.RemoveElement(/datum/element/footstep)
	organ_owner.AddElement(/datum/element/footstep, FOOTSTEP_MOB_SNAKE, 15, -6)

/obj/item/organ/external/taur_body/serpentine/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	organ_owner.RemoveElement(/datum/element/footstep)
	organ_owner.AddElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 0.6, -6)

	return ..()

