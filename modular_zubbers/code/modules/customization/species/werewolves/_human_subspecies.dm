/datum/species/human/werewolf
	name = "\improper Werehuman"
	id = SPECIES_WEREHUMAN
	inherent_traits = list(
		TRAIT_WEREWOLF,
		TRAIT_USES_SKINTONES,
	)
	damage_modifier = list(
		BRUTE = 1.25,
		BURN = 1.25,
	)
	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/werewolf

/datum/species/human/werewolf/get_species_description()
	return list(placeholder_description)

/datum/species/human/werewolf/get_species_lore()
	return list(placeholder_lore)

/datum/species/human/werewolf/create_pref_unique_perks()

/datum/species/human/werewolf/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#403729", update = FALSE) // brown
	human.set_hairstyle("Short Hair 80s", update = TRUE)

/mob/living/carbon/human/species/werehuman
	race = /datum/species/human/werewolf
