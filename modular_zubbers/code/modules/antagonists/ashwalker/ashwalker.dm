/mob/living/carbon/human/species/lizard/ashwalker
	faction = list(FACTION_ASHWALKER)

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/carbon_target, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	carbon_target.faction |= FACTION_ASHWALKER
