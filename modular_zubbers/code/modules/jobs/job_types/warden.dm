/datum/job/warden
	// I've been told sec should be played before warden by the original comment when modularising
	// Don't personally agree because warden is a good learning role with none of the combat robustness requirements
	// Feel free to remove this if you ever decide so
	// ~Waterpig
	exp_required_type_department = EXP_TYPE_SECURITY
	rpg_title = "Beefeater"
	alt_titles = list(
		"Warden",
		"Armory Superintendent",
		"Brig Sergeant",
		"Brig Sentry",
		"Brig Governor",
		"Deputy Commissioner of Security",
		"Dispatch Officer",
		"Deputy Commissioner",
		"Jailer",
		"Master-at-Arms",
	)
	sec_antag_cap = 1
	akula_outfit = /datum/outfit/akula/security_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE
