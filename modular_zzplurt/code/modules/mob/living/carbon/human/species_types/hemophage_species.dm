/datum/species/hemophage/New()
	// Remove traits
	inherent_traits -= list(
		TRAIT_NOBREATH,
		TRAIT_OXYIMMUNE,
		TRAIT_VIRUSIMMUNE,
	)

	// Restore lungs
	mutantlungs = /datum/species::mutantlungs

	// Disable veteran restriction
	veteran_only = FALSE

	// Return original
	. = ..()

// Called when a mob gains this species
/datum/species/hemophage/on_species_gain(mob/living/carbon/human/human_target, datum/species/old_species, pref_load)
	. = ..()

	// Add profane penalties
	human_target.AddElementTrait(TRAIT_CHAPEL_WEAKNESS, SPECIES_HEMOPHAGE, /datum/element/chapel_weakness)
	human_target.AddElementTrait(TRAIT_HOLYWATER_WEAKNESS, SPECIES_HEMOPHAGE, /datum/element/holywater_weakness)

// Called when a mob loses this species
/datum/species/hemophage/on_species_loss(mob/living/carbon/human/human_target, datum/species/new_species, pref_load)
	. = ..()

	// Remove profane penalties
	REMOVE_TRAIT(human_target, TRAIT_CHAPEL_WEAKNESS, SPECIES_HEMOPHAGE)
	REMOVE_TRAIT(human_target, TRAIT_HOLYWATER_WEAKNESS, SPECIES_HEMOPHAGE)
