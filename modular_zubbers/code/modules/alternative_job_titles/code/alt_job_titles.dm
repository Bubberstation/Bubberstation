/datum/job/security_medic
	alt_titles = list(
		"Security Medic",
		"Field Medic",
		"Security Corpsman",
		"Brig Physician",
		"Combat Medic",
		"Special Operations Medic",
	)

/datum/job/orderly/New()
	alt_titles |= list(
		"Medical Attendant",
		"Medical Support Technician",
	)
	. = ..()

//New titles for Blacksmith
/datum/job/blacksmith
	alt_titles = list(
		"Ithastrist",
		"Metalurgist",
		"Metal Worker",
		"Metalsmith",
		"Forge Artisan",
		"Forgemaster",
		"Weaponsmith",
		"Armorsmith",
	)

/datum/job/paramedic/New()
	alt_titles |= list(
		"Body Retrieval Specialist",
	)
	. = ..()
