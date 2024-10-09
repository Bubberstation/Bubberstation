/datum/job/security_medic
	alt_titles = list(
		"Security Medic",
		"Field Medic",
		"Security Corpsman",
		"Brig Physician",
		"Combat Medic",
	)

/datum/job/blueshield/New()
	alt_titles |= list(
		"Henchman",
	)
	. = ..()

/datum/job/orderly/New()
	alt_titles |= list(
		"Medical Attendant",
		"Medical Support Technician",
	)
	. = ..()
