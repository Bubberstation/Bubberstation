// Misc

//Security

/datum/job/blueshield
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE

/datum/job/corrections_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE

// Command

/datum/job/nanotrasen_consultant
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

//Silicon
/datum/job/ai
	loadout = FALSE

/datum/job/cyborg
	loadout = FALSE

// MEDICAL

/datum/job/geneticist
	required_languages = null

/datum/job/virologist
	required_languages = null // damara dent-head

// Nanotrasen Fleet
/datum/job/fleetmaster
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/operations_inspector
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/deck_crew
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/bridge_officer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE
