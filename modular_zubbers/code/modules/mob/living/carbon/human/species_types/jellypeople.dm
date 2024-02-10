
/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	// regenerate_organs with replace doesn't seem to automatically remove invalid organs unfortunately
	var/obj/item/organ/heart = target.get_organ_slot(ORGAN_SLOT_HEART)
	heart.Remove(target)
	normalize_organs()
