// Misc
/datum/job/assistant
	no_dresscode = TRUE
	blacklist_dresscode_slots = list(ITEM_SLOT_EARS,ITEM_SLOT_BELT,ITEM_SLOT_ID,ITEM_SLOT_BACK) //headset, PDA, ID, backpack are important items
	required_languages = null

//Security

/datum/job/detective
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE

/datum/job/blueshield
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE

/datum/job/corrections_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE

// Command
/datum/job/captain
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/nanotrasen_consultant
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/head_of_security
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)
	is_hand_required = TRUE

/datum/job/chief_medical_officer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/chief_engineer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Paraplegic" = TRUE)
	is_hand_required = TRUE

/datum/job/research_director
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/head_of_personnel
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE

/datum/job/quartermaster
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

/datum/job/curator
	required_languages = null

/datum/job/janitor
	required_languages = null

/datum/job/orderly
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/science_guard
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/customs_agent
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/mime
	required_languages = null

/datum/job/clown
	required_languages = null

/datum/job/bouncer
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/barber
	required_languages = null

/datum/job/bartender
	required_languages = null

/datum/job/chaplain
	required_languages = null

// ENGINEERING

/datum/job/station_engineer
	required_languages = null

/datum/job/atmospheric_technician
	required_languages = null

/datum/job/engineering_guard
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

// CARGO

/datum/job/shaft_miner
	required_languages = null

/datum/job/blacksmith
	required_languages = null

/datum/job/customs_agent
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

// SCIENCE

/datum/job/scientist
	required_languages = null

/datum/job/roboticist
	required_languages = null

/datum/job/science_guard
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
