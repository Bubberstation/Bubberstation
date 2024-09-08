/obj/item/organ/external/antennae

/obj/item/organ/external/antennae/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(ismoth(organ_owner))
		ADD_TRAIT(organ_owner, TRAIT_REAGENT_SCANNER, ORGAN_TRAIT)

/obj/item/organ/external/antennae/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	REMOVE_TRAIT(organ_owner, TRAIT_REAGENT_SCANNER, ORGAN_TRAIT)
