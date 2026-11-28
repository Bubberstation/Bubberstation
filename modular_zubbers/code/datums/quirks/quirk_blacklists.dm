// Any quirk that adds a cyber implant/organ gets blacklisted due to the curskin organ rejection.
// Entombed messes with transformations and proteans, custom organs on proteans can cause them to break
// And the primitives should not have these either

/datum/quirk/tin_man
	species_blacklist = list(SPECIES_LYCAN, SPECIES_CURSEKIN, SPECIES_LIZARD_ASH, SPECIES_FELINE_PRIMITIVE)

/datum/quirk/prosthetic_organ
	species_blacklist = list(SPECIES_LYCAN, SPECIES_CURSEKIN, SPECIES_PROTEAN, SPECIES_LIZARD_ASH, SPECIES_FELINE_PRIMITIVE)

/datum/quirk/transhumanist
	species_blacklist = list(SPECIES_LYCAN, SPECIES_CURSEKIN, SPECIES_LIZARD_ASH, SPECIES_FELINE_PRIMITIVE)

/datum/quirk/equipping/entombed
	species_blacklist = list(SPECIES_LYCAN, SPECIES_CURSEKIN, SPECIES_PROTEAN, SPECIES_LIZARD_ASH, SPECIES_FELINE_PRIMITIVE)
