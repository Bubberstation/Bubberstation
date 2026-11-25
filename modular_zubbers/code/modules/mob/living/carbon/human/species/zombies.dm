/datum/species/zombie/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"snout" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
		"horns" = list("None", FALSE),
		"spines" = list("None", FALSE),
		"frills" = list("None", FALSE),
	)

/datum/status_effect/zombie
	/// Should the victim get zombie husked, this is essentially only here for HFZ species
	var/should_husk_victim = TRUE

/datum/status_effect/zombie/uninfected
	should_husk_victim = FALSE
