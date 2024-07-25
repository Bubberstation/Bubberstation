
/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	// regenerate_organs with replace doesn't seem to automatically remove invalid organs unfortunately
	normalize_organs()


/datum/species/jelly/get_species_description()
	return list("Jellypeople are a strange and alien species with three eyes, made entirely out of gel.",)
