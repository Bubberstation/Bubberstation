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
		in pure Xenomorph hives. All of this unfortunately culminates into a degree of prejudice and fear from other \
		races for their origins as parasites, regardless of if the Hybrid in question is even capable of infesting other living creatures.",
	)

/datum/species/xeno/get_species_lore()
	return list(
		"Xenomorph Hybrids are a species of creature hybridized with xenomorph genes, most often humans, but in increasing numbers, various other species have also received treatments. \
		They tend to stand taller than their original species, with notably longer lifespans, and sharp claws regardless of if their original species had them. \
		They lack a true organized society, mostly fitting in small numbers into spaces where their original species would inhabit. Some hybrids can pass, others cannot and are more stigmatized. \
		They tend to lack social skills, being notably quieter than their galactic counterparts, and can get overstimulated due to their extremely keen senses, \
		but with experience, most hybrids can easily do away with this problem and fit well into the social spaces they are brought into. If you can forgive the teeth.",

		"Hybrids were first documented as part of a Nanotrasen research project on the Xenomorph genome, originally \
		meant to produce super-soldiers. Efforts to do so have been enthusiastic, but not particularly impactful. \
		Another initiative that has produced hybrids is Operation Chimera, the Solar Bureau of Intelligence's \
		interesting and desperate plan to use the xenomorphs' ability to bond with others \
		to turn a bioweapon	into a species that could be controlled. Time was short for solutions \
		as a xenomorph infestation had begun to take over multiple independent worlds in the Ombrux sector, threatening the interior, \
		and... it didn't really work. That said, the infestation has been stalled as a result of effective orbital bombardment.",


		"These days, Xenomorph hybrids are in an odd place, rejected both by society and the species that created them. \
		Nanotrasen's xenoscience division offers an acclimitization program for these outcasts, \
		marking the beginnings of integration. In this slow drive to acceptance, they find comfort in their shared hive.",
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
