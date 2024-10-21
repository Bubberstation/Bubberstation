/datum/species/xeno
	mutant_organs = list()
	heatmod = 1
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION
	)
	species_language_holder = /datum/language_holder/xeno_hybrid

/datum/species/xeno/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "Darkvision",
		SPECIES_PERK_DESC = "Xenomorph Hybrids inherit their pure cousin's ability to see in the dark, to a lesser degree."
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "Sharp Claws",
		SPECIES_PERK_DESC = "Xenomorph Hybrids possess sharp claws and talons."
	))

	return to_add
