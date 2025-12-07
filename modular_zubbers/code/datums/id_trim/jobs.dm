//New honorifics

/datum/id_trim/job/blueshield
	job = /datum/job/blueshield
	honorifics = list("Agent", "ESS", "CPO", "CSS")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/chaplain/New()
	job = /datum/job/chaplain
	honorifics += list("Father", "Mother", "Preacher", "Rabbi", "Imam", "Monk", "Nun", "Oracle", "Pontifex", "Magister", "High Priest", "High Priestess", "Cleric")
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
	honorifics += list("Commissioner", "Chief Constable", "Sheriff", "Security Commander", "S.CMDR.")
	return ..()

/datum/id_trim/job/nanotrasen_consultant
	job = /datum/job/nanotrasen_consultant
	honorifics = list("Advisor", "Consultant", "Representative", "Rep.", "Interest Officer", "Liason")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/captain
	job = /datum/job/captain
	honorifics = list("Facility Director", "Station Commander", "Commander", "CMDR.", "Site Manager")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/cook/chef
	job = /datum/job/cook
	honorifics = list("Sous-Chef", "Junior Chef", "Tavern Chef", "Confectionist", "Pastry Chef", "All-American")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/quartermaster
	job = /datum/job/quartermaster
	honorifics = list("Deck Chief", "Logistics Coordinator", "Supply Foreman", "Union Requisitions Officer", "Supervisor")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/research_director
	job = /datum/job/research_director
	honorifics = list("Head Researcher", "Administrator")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/security_officer
	job = /datum/job/security_officer
	honorifics = list("Security Specialist", "Guard", "Security Officer", "Constable")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/warden
	job = /datum/job/warden
	honorifics = list("Warden", "Sergeant", "Sgt.", "Lieutenant", "Lt.", "Master-at-Arms", "Superintendent")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/station_engineer
	job = /datum/job/station_engineer
	honorifics = list("Technician")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/research_director
	job = /datum/job/research_director
	honorifics = list("Head Researcher", "Administrator")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/chief_engineer
	job = /datum/job/chief_engineer
	honorifics = list("Chief Engineer", "Engineering Foreman",)
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/cargo_technician
	job = /datum/job/cargo_technician
	honorifics = list("Associate")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/atmospheric_technician
	job = /datum/job/atmospheric_technician
	honorifics = list("Technician")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
