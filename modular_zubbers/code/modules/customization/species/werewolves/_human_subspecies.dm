/datum/species/human/werewolf
	name = "\improper Werehuman"
	id = SPECIES_WEREHUMAN
	inherent_traits = list(
		TRAIT_WEREWOLF,
		TRAIT_MUTANT_COLORS, // More customization options.
	)
	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/werewolf

/datum/species/human/werewolf/get_species_description()
	return list(placeholder_description)

/datum/species/human/werewolf/get_species_lore()
	return list(placeholder_lore)

/datum/species/human/werewolf/create_pref_unique_perks()

/datum/species/human/werewolf/prepare_human_for_preview(mob/living/carbon/human/werewolf)
	var/main_color = "#e8b59b" // Caucasian3 / Peach
	werewolf.dna.features["mcolor"] = main_color
	werewolf.set_haircolor("#403729", update = FALSE) // brown
	werewolf.set_hairstyle("Short Hair 80s", update = TRUE)

/mob/living/carbon/human/species/werehuman
	race = /datum/species/human/werewolf
