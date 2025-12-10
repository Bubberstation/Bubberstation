//New honorifics

/datum/id_trim/job/blueshield
	job = /datum/job/blueshield
	honorifics = list("Agent", "ESS", "CPO", "CSS")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/chaplain/New()
	job = /datum/job/chaplain
	honorifics += list("Father", "Mother", "Preacher", "Rabbi", "Imam", "Monk", "Nun", "Oracle", "Pontifex", "Magister", "High Priest", "High Priestess", "Cleric")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/corrections_officer
	job = /datum/job/corrections_officer
	honorifics = list("Officer", "Corrections Officer", "C.O.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/curator
	job = /datum/job/curator
	honorifics = list("Professor", "Prof.", "Curator", "Archivist", "Librarian", "Historian", "PhD")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/geneticist
	job = /datum/job/geneticist
	honorifics = list("Researcher", "D.Sc.", "Geneticist")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/head_of_personnel
	job = /datum/job/head_of_personnel
	honorifics = list("Personnel Officer", "Executive Officer", "Head of Personnel", "HoP")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/head_of_security/New()
	job = /datum/job/head_of_security
	honorifics += list("Commissioner", "Chief Constable", "Sheriff", "Security Commander", "S.CMDR.", "HoS")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/nanotrasen_consultant
	job = /datum/job/nanotrasen_consultant
	honorifics = list("Advisor", "Consultant", "Representative", "Rep.", "Interest Officer", "Liason")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/captain/New()
	job = /datum/job/captain
	honorifics += list("Facility Director", "Station Commander", "Commander", "CMDR.", "Site Manager")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/cook/chef/New()
	job = /datum/job/cook
	honorifics += list("Sous-Chef", "Junior Chef", "Tavern Chef", "Confectionist", "Pastry Chef", "All-American")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/quartermaster/New()
	job = /datum/job/quartermaster
	honorifics += list("Deck Chief", "Logistics Coordinator", "Supply Foreman", "Union Requisitions Officer", "Supervisor", "QM")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/research_director/New()
	job = /datum/job/research_director
	honorifics += list("Head Researcher", "Administrator", "RD")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/scientist/New()
	job = /datum/job/scientist
	honorifics += list("Analyst", "D.Sc.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/security_officer/New()
	job = /datum/job/security_officer
	honorifics += list("Security Specialist", "Guard", "Security Officer", "Constable", "Trooper", "Deputy")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/warden/New()
	job = /datum/job/warden
	honorifics += list("Warden", "Sergeant", "Sgt.", "Master-at-Arms", "Superintendent")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/station_engineer/New()
	job = /datum/job/station_engineer
	honorifics += list("Technician")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/chief_engineer/New()
	job = /datum/job/chief_engineer
	honorifics += list("Chief Engineer", "Engineering Foreman", "CE")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/cargo_technician/New()
	job = /datum/job/cargo_technician
	honorifics += list("Associate")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()
