/// Any quirk that adds a cyber implant/organ gets blacklisted due to the curskin organ rejection.

/datum/quirk/tin_man
	species_blacklist = list(/datum/species/lycan, /datum/species/human/cursekin)

/datum/quirk/prosthetic_organ
	species_blacklist = list(/datum/species/lycan, /datum/species/human/cursekin)

/datum/quirk/transhumanist
	species_blacklist = list(/datum/species/lycan, /datum/species/human/cursekin)

/// Blacklisting entombed as well as I can see issues coming from it.
/datum/quirk/equipping/entombed
	species_blacklist = list(/datum/species/lycan, /datum/species/human/cursekin)
