
/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/lizard/get_species_description()
	return list("Tizirans (known as Lizardpeople in Federation spaces) are a militaristic species that once conquered large swathes of territory \
		before their capital was turned to a glass canyon by Federation plasma ships, ending the Coalition War. \
		The colony of Kesa'aresz, once a Tiziran fortress world, is now where the majority of Federation lizards vote and hail from. \
		Their bodies are clad in thick scale, known for their constitution and resilience against high temperatures.\
		They frequently have horns, and frills, as these are signs of a good warrior, the latter of which tend to be wider in females.\
		Tizirans generally grow higher than humans, being six to seven feet tall on average, and grow tall before they grow wide.\
		They have a critical weakness in their coldbloodedness, their bodies unable to cope with truly extreme temperatures.\
		The Tiziran diet consists of raw meat, fish, mushrooms, and nuts of various types. Spicy foods cause their bodies to break out in boils.\
		In the modern day, many Tizirans have to deal with stigma and stereotypes based around their martial culture,\
		which has led to a boom of Tiziran artists, writers and philosophers in the past half-century.")
