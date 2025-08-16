/datum/species/lizard
	mutant_bodyparts = list()
	mutant_organs = list()
	payday_modifier = 1.0

/datum/species/lizard/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Smooth", TRUE),
		"snout" = list("Sharp + Light", TRUE),
		"spines" = list("Long + Membrane", TRUE),
		"frills" = list("Short", TRUE),
		"horns" = list("Curled", TRUE),
		"body_markings" = list("Light Belly", TRUE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
	)

/datum/species/lizard/ashwalker/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts["spines"] = list("None", TRUE)
	return default_parts

/datum/species/lizard/silverscale/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts["spines"] = list("None", TRUE)
	return default_parts

/datum/species/lizard/randomize_features()
	var/list/features = ..()
	var/main_color = "#[random_color()]"
	var/second_color
	var/third_color
	var/random = rand(1,3)
	switch(random)
		if(1) //First random case - all is the same
			second_color = main_color
			third_color = main_color
		if(2) //Second case, derrivatory shades, except there's no helpers for that and I dont feel like writing them
			second_color = main_color
			third_color = main_color
		if(3) //Third case, more randomisation
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = third_color
	return features

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#009999")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Simple", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Aquatic", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.features["legs"] = "Normal Legs"
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)

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

/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/lizard/ashwalker
	always_customizable = TRUE
	language_prefs_whitelist = list(/datum/language/ashtongue)
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_MUTANT_COLORS,
		TRAIT_TACKLING_TAILED_DEFENDER,
	)

//Ashwalkers, the primitive lizards that inhabit Indecipheres
/datum/species/lizard/ashwalker/create_pref_language_perk()
	var/list/to_add = list()
	// Holding these variables so we can grab the exact names for our perk.
	var/datum/language/common_language = /datum/language/ashtongue

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "comment",
		SPECIES_PERK_NAME = "Native Speaker",
		SPECIES_PERK_DESC = "Ashwalkers can only speak [initial(common_language.name)]. \
			It is rare, but not impossible, for an Ashwalker to learn another language."
	))

	return to_add

/datum/species/lizard/ashwalker/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#990000")
	. = ..(lizard, lizard_color)

//Silverscales, a pirate faction of lizards that have... well, silver scales
/datum/species/lizard/silverscale/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#eeeeee")
	lizard.eye_color_left = "#0000a0"
	lizard.eye_color_right = "#0000a0"
	. = ..(lizard, lizard_color)
