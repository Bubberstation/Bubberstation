/datum/species/dullahan
	outfit_important_for_life = /datum/outfit/dullahan

/datum/species/dullahan/get_species_description()
	return list("An angry spirit, hanging onto the land of the living for \
		unfinished business. Or that's what the books say. They're quite nice \
		when you get to know them.",)

/datum/species/dullahan/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "horse-head",
		SPECIES_PERK_NAME = "Headless and Horseless",
		SPECIES_PERK_DESC = "Dullahans must lug their head around in their arms, though \
			the hard-headed kind oft perch it back on their necks out of habit or \
			convenience, with the risk of it falling off at any moment.",
	))

	return to_add
