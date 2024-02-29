/datum/species/abductor/lesser
	id = SPECIES_ABDUCTOR_STATION
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
	)

/datum/species/abductor/lesser/get_physical_attributes()
	return "Abductors do not need to breathe, eat, do not have blood, a heart, stomach, or lungs and cannot be infected by human viruses. \
		Their chunky tridactyl hands make it hard to operate human equipment."

