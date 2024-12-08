/datum/id_trim/syndicom/Interdyne/engineer
	assignment = "Interdyne Engineer"
	trim_state = "trim_stationengineer"
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_ENG
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_MEDICAL, ACCESS_ENGINE_EQUIP)
	big_pointer = FALSE
	pointer_color = null

/datum/id_trim/syndicom/Interdyne/cargo
	assignment = "Interdyne Stock Manager"
	trim_state = "trim_cargotechnician"
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_CARG
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_MEDICAL, ACCESS_CARGO)
	big_pointer = FALSE
	pointer_color = null

/datum/id_trim/syndicom/Interdyne/geneticist
	assignment = "Interdyne Geneticist"
	trim_state = "trim_geneticist"
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_GEN
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_MEDICAL, ACCESS_GENETICS)
	big_pointer = FALSE
	pointer_color = null

/datum/id_trim/syndicom/Interdyne/chemist
	assignment = "Interdyne Chemist"
	trim_state = "trim_chemist"
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_CHEM
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_MEDICAL, ACCESS_PHARMACY)
	big_pointer = FALSE
	pointer_color = null

/datum/id_trim/syndicom/Interdyne/doctor
	assignment = "Interdyne Doctor"
	trim_state = "trim_medicaldoctor"
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_MEDICAL, ACCESS_SURGERY)
	big_pointer = FALSE
	pointer_color = null

/datum/id_trim/syndicom/Interdyne/medicaldirector
	assignment = "Interdyne Medical Director"
	trim_state = "trim_medicaldoctor"
	department_color = COLOR_SYNDIE_RED_HEAD
	subdepartment_color = COLOR_SYNDIE_RED_HEAD
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE_HEAD
	access = list(ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER, ACCESS_ROBOTICS, ACCESS_MEDICAL, ACCESS_SURGERY)
	big_pointer = TRUE
	pointer_color = COLOR_SYNDIE_RED_HEAD
