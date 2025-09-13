/datum/species/lizard
	name = "Tiziran Lizardperson"
	//renames Lizardpeople to Tizirans for clarity.

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
		"Tiziran bodies are clad in thick scale, known for their constitution and resilience to higher temperatures. \
		They frequently have horns, and frills, the latter of which tend to be wider in females. \
		They generally grow higher than humans, being six to seven feet tall on average, and tend to grow tall before they grow wide. \
		This means younger Tizirans are typically thinner than their human counterparts, and stop growing later in life.",

		"The imperial motto, \"Oath and Scale,\" is often used to emphasize community, and their sense of community tends to define how a Tiziran acts. \
		This gives them a surprising amount in common with their companions in the CIN, the Teshari. Tizirans often seek out community first. \
		Chest and tail thumping is often used to emphasize sincerity or honesty. They tend to hiss when angry, displeased or threatened. \
		Tizirans tend to decorate their bodies, particularly frills and horns, in similar fashion to human tattoos and piercings, \
		to symbolize important events and allegiances. They often value physicality and action over words, making them put less cultural emphasis on fashion.",

		"Tizirans have a militaristic culture that once conquered large swathes of territory \
		before their capital of Zagoskeld was turned to a glass canyon by Federation plasma ships, ending the Coalition War. \
		Their territory has since reduced in size, but is one of the faster growing economies of the modern age. \
		The colony of Kesa'aresz, once a Tiziran fortress world, is now where the majority of Federation lizards vote and hail from.",

		"In the modern day, many Tizirans have to deal with stigma and stereotypes based around their former jingoism, \
		which has led to a cultural renaissance of Tiziran artists, writers and philosophers in the past half-century.",
	)

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#FFA756")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.features["mcolor2"] = "#DE893A"
	lizard.dna.features["mcolor3"] = "#DE893A"
	lizard.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Drake", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Neck Frills (New)", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.features["legs"] = "Normal Legs"
	lizard.set_facial_hairstyle("Lizard Tongue Flick")
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)
