//New honorifics

/datum/id_trim/job/blueshield
	job = /datum/job/blueshield
	honorifics = list("Agent")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/chaplain/New()
	job = /datum/job/chaplain
	honorifics += list("Father", "Mother")
	return ..()

/datum/id_trim/job/corrections_officer
	job = /datum/job/corrections_officer
	honorifics = list("Officer")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/curator
	job = /datum/job/curator
	honorifics = list("Professor", "Prof.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/geneticist
	job = /datum/job/geneticist
	honorifics = list("Researcher")

/datum/id_trim/job/head_of_personnel
	job = /datum/job/head_of_personnel
	honorifics = list("Personnel Officer", "Officer")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/head_of_security/New()
	job = /datum/job/head_of_security
	honorifics += list("Sheriff", "Commander")
	return ..()

/datum/id_trim/job/nanotrasen_consultant
	job = /datum/job/nanotrasen_consultant
	honorifics = list("Representative", "Consultant", "Rep.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
