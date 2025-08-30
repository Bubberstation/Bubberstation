/datum/species/human/cursekin
	name = "\improper Cursekin"
	id = SPECIES_CURSEKIN
	inherent_traits = list(
		TRAIT_LYCAN,
		TRAIT_MUTANT_COLORS, // More customization options.
	)
	mutantbrain = /obj/item/organ/brain/lycan
	var/lycanthropy_species = /datum/species/lycan

/datum/species/human/cursekin/get_species_description()
	return list(
		"Less of a species and more of a collective group of people sharing the same curse, the origins of the cursekin are largely \
		unknown, however, many differing cultures seem to have their own names and mythologies behind the affliction, granting credence \
		to the belief the curse has been around for quite some time.",
		"The main traits shared by everyone afflicted are their transformations into a far more bestial form, and their body's rejection \
		of anything inorganic. Those suffering from the curse seem to have varying levels of control over if and when they transform."
	)

/datum/species/human/cursekin/get_species_lore()
	return list(placeholder_lore)

/datum/species/human/cursekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "robot",
			SPECIES_PERK_NAME = "Inorganic rejection",
			SPECIES_PERK_DESC = "The curse afflicting the cursekin prevents their bodies from being augmented with cybernetic organs \
			or implants."
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "moon",
			SPECIES_PERK_NAME = "Lycan transformation",
			SPECIES_PERK_DESC = "Due to the curse, cursekin are capable of transforming into lycans, taking on all of the perks and \
			drawbacks of that form.",
		),
	)

	return to_add

/datum/species/human/cursekin/prepare_human_for_preview(mob/living/carbon/human/cursekin)
	var/main_color = "#362d23"
	var/secondary_color = "#9c5852"
	var/tertiary_color = "#CCF6E2"
	cursekin.set_species(lycanthropy_species)
	cursekin.dna.features["mcolor"] = main_color
	cursekin.dna.features["mcolor2"] = secondary_color
	cursekin.dna.features["mcolor3"] = tertiary_color
	cursekin.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	cursekin.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	cursekin.dna.features["legs"] = "Digitigrade Legs"
	regenerate_organs(cursekin, src, visual_only = TRUE)
	cursekin.update_body(TRUE)

/mob/living/carbon/human/species/cursekin
	race = /datum/species/human/cursekin

/datum/species/human/cursekin/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	gainer.AddElement(/datum/element/inorganic_rejection)

/datum/species/human/cursekin/on_species_loss(mob/living/carbon/human/loser, datum/species/new_species, pref_load)
	. = ..()
	loser.RemoveElement(/datum/element/inorganic_rejection)
