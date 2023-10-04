/datum/strippable_item/mob_item_slot/mask/get_alternate_action(atom/source, mob/user)
	var/mob/living/carbon/human/S = source
	if(!istype(S) || !istype(S.get_organ_slot(ORGAN_SLOT_BRAIN), /obj/item/organ/internal/brain/synth))
		return null
	return null
