
/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs()
	