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

/datum/job/chief_medical_officer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/head_of_personnel
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

//Silicon
/datum/job/ai
	loadout = FALSE

/datum/job/cyborg
	loadout = FALSE

// BUBBER TODO - Change this mess of required languages
//Service
/datum/job/cook
	required_languages = null

/datum/job/botanist
	required_languages = null

/datum/job/janitor
	required_languages = null

/datum/job/orderly
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/mime
	required_languages = null

/datum/job/clown
	required_languages = null

/datum/job/bouncer
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

// MEDICAL

/datum/job/chemist
	required_languages = null

/datum/job/doctor
	required_languages = null

/datum/job/paramedic
	required_languages = null

/datum/job/geneticist
	required_languages = null

/datum/job/virologist
	required_languages = null // damara dent-head

/datum/job/orderly
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

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
