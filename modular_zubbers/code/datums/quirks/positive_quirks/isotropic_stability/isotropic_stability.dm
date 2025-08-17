/datum/quirk/isotropic_stability
	name = "Isotropic Stability"
	desc = "Nuka Cola lovers rejoice! Radiation burns are 75% less likely to occur, and you can become irradiated without vomiting, mutating, or losing hair. Being irradiated only causes toxin damage when you remain near sources of dangerous radiation, but is twice as damaging."
	value = 6
	medical_record_text = "Patient's body is highly resistant to radiation poisoning."
	icon = FA_ICON_ATOM
	// Blacklisted for species which are already immune to radiation
	species_blacklist = list(
		SPECIES_ANDROID,
		SPECIES_SYNTH,
		SPECIES_PLASMAMAN,
		SPECIES_ZOMBIE,
		SPECIES_GHOUL,
		SPECIES_PROTEAN,
		SPECIES_SKELETON,
		SPECIES_SHADOW,
		SPECIES_GOLEM,
		SPECIES_NIGHTMARE,
		SPECIES_MUTANT,
	)

/datum/quirk/isotropic_stability/add(client/client_source)
	quirk_holder.add_traits(list(
		TRAIT_RAD_RESISTANCE,
		TRAIT_BYPASS_EARLY_IRRADIATED_CHECK,
	), QUIRK_TRAIT)

/datum/quirk/isotropic_stability/remove(client/client_source)
	quirk_holder.remove_traits(list(
		TRAIT_RAD_RESISTANCE,
		TRAIT_BYPASS_EARLY_IRRADIATED_CHECK,
	), QUIRK_TRAIT)
