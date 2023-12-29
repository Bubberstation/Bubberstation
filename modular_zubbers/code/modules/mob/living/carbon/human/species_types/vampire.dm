/datum/species/vampire/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	to_chat(target, span_warning("Your vampire features have been removed, your nature as a bloodsucker abates the lesser vampirism curse."))
	humanize_organs(target, current_species)

/datum/species/vampire/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)
