
/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/lizard/get_species_description()
	return list(
	"Tizirans (known as Lizardpeople in Federation spaces) are a lizard-like species that once possessed a vast empire.",
	"They mainly eat raw meat, fish, mushrooms and nuts. Spicy foods cause their bodies to break out in boils. \
	They are cold-blooded due to their dry and arid homeworld, and their bodies are unable to cope with truly extreme temperatures.",
	)

/datum/species/lizard/get_species_lore()
	return list(
		"Tizirans (known as Lizardpeople in Federation spaces) have a militaristic culture that once conquered large swathes of territory \
		before their capital of Zagoskeld was turned to a glass canyon by Federation plasma ships, ending the Coalition War. \
		Their territory has since reduced in size, but is one of the faster growing economies of the modern age. \
		The colony of Kesa'aresz, once a Tiziran fortress world, is now where the majority of Federation lizards vote and hail from.",

		"In the modern day, many Tizirans have to deal with stigma and stereotypes based around their martial culture, \
		which has led to a boom of Tiziran artists, writers and philosophers in the past half-century.",

		"Tiziran bodies are clad in thick scale, known for their constitution and resilience. \
		They frequently have horns, and frills, signs of a good warrior, the latter of which tend to be wider in females. \
		They generally grow higher than humans, being six to seven feet tall on average, and tend to grow tall before they grow wide. \
		This means younger Tizirans are typically thinner than their human counterparts, and stop growing later in life."
	)
