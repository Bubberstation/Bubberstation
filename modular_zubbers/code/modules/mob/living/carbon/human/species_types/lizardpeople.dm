
/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)
