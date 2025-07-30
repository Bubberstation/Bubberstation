//New honorifics

/datum/id_trim/job/blueshield/New()
	job = /datum/job/blueshield
	honorifics = list("Agent")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/chaplain/New()
	job = /datum/job/chaplain
	honorifics += list("Father", "Mother")
	return ..()

/datum/id_trim/job/corrections_officer/New()
	job = /datum/job/corrections_officer
	honorifics = list("Officer")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/curator/New()
	job = /datum/job/curator
	honorifics = list("Professor", "Prof.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/geneticist/New()
	job = /datum/job/geneticist
	honorifics = list("Researcher")
	return ..()

/datum/id_trim/job/head_of_personnel/New()
	job = /datum/job/head_of_personnel
	honorifics = list("Personnel Officer", "Officer")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/head_of_security/New()
	job = /datum/job/head_of_security
	honorifics += list("Sheriff", "Commander")
	return ..()

/datum/id_trim/job/nanotrasen_consultant/New()
	job = /datum/job/nanotrasen_consultant
	honorifics = list("Representative", "Consultant", "Rep.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()
