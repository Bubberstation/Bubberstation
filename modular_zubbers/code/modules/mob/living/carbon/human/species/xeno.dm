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

/datum/species/xeno/get_species_description()
	return list(
		"A 'Xenomorph Hybrid' is a loose designation for a wide variety of creatures with predominantly \
		Xenomorph-like characteristics, rather than a specific species in its own right. As Xenomorphs themselves are \
		parasitic hybridisations of many different 'host' species, the main distinguishing factors between a regular \
		Xenomorph and a Hybrid are a more humanoid body shape and stature with alien features, inert or defective hive \
		organs, and a less murderous demeanor. These are not the only documented differences, though they are the most frequent.",

		"Their manner of creation just as wildly varies, from lab-grown experiments to unusual genetic malformations \
		in pure Xenomorph hives. All of this unfortunately culminates into a degree of prejudice and fear from  other \
		races for their origins as parasites, regardless of if the Hybrid in question is even capable of infesting other living creatures.",
	)

/datum/species/xeno/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "eye",
		SPECIES_PERK_NAME = "Darkvision",
		SPECIES_PERK_DESC = "Xenomorph Hybrids inherit the ability to see in the dark from pure Xenomorphs, albiet to a less powerful degree."
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "Sharp Claws",
		SPECIES_PERK_DESC = "Xenomorph Hybrids possess sharp claws and talons."
	))

	return to_add
