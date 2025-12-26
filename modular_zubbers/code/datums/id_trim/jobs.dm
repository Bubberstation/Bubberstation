//New honorifics

/datum/id_trim/job/blueshield
	job = /datum/job/blueshield
	honorifics = list("Agent", "ESS", "CPO", "CSS")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/chaplain/New()
	job = /datum/job/chaplain
	honorifics += list("Father", "Mother", "Preacher", "Rabbi", "Imam", "Monk", "Nun", "Oracle", "Pontifex", "Magister", "High Priest", "High Priestess", "Cleric")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/corrections_officer
	job = /datum/job/corrections_officer
	honorifics = list("Officer", "Corrections Officer", "C.O.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/curator
	job = /datum/job/curator
	honorifics = list("Professor", "Prof.", "Curator", "Archivist", "Librarian", "Historian")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/geneticist
	job = /datum/job/geneticist
	honorifics = list("Researcher", "Geneticist", "Doctor", "Dr.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/head_of_personnel
	job = /datum/job/head_of_personnel
	honorifics = list("Personnel Officer", "Executive Officer", "Head of Personnel", "EO", "HOP")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/head_of_security/New()
	job = /datum/job/head_of_security
	honorifics += list("Commissioner", "Chief Constable", "Sheriff", "Security Commander", "S.CMDR.", "HOS")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/nanotrasen_consultant
	job = /datum/job/nanotrasen_consultant
	honorifics = list("Advisor", "Consultant", "Representative", "Rep.", "Interest Officer", "Liason")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/captain/New()
	job = /datum/job/captain
	honorifics += list("Facility Director", "Station Commander", "Commander", "CMDR.", "Site Manager")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/cook/chef/New()
	job = /datum/job/cook
	honorifics += list("Sous-Chef", "Junior Chef", "Tavern Chef", "Confectionist", "Pastry Chef", "All-American")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/quartermaster/New()
	job = /datum/job/quartermaster
	honorifics += list("Deck Chief", "Logistics Coordinator", "Supply Foreman", "Union Requisitions Officer", "Supervisor")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/research_director/New()
	job = /datum/job/research_director
	honorifics += list("Head Researcher", "Administrator", "RD", "Chief Science Officer", "CSO")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/scientist/New()
	job = /datum/job/scientist
	honorifics += list("Analyst", "Doctor", "Dr.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/security_medic
	job = /datum/job/security_medic
	honorifics = list("Line Medic", "Squad Physician", "Medical Specialist", "Support Specialist", "Doc.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/security_officer/New()
	job = /datum/job/security_officer
	honorifics += list("Security Specialist", "Guard", "Security Officer", "Constable", "Trooper", "Deputy", "Cadet")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/warden/New()
	job = /datum/job/warden
	honorifics += list("Warden", "Sergeant", "Sgt.", "Master-at-Arms", "Superintendent")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/station_engineer/New()
	job = /datum/job/station_engineer
	honorifics += list("Technician")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/chief_engineer/New()
	job = /datum/job/chief_engineer
	honorifics += list("Chief Engineer", "Engineering Foreman", "CE")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/cargo_technician/New()
	job = /datum/job/cargo_technician
	honorifics += list("Associate")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/medical_doctor/New()
	job = /datum/job/doctor
	honorifics += list("M.D.", "G.P.", "Physician", "Nurse", "Resident", "Intern", "Resident Physician", "Resident Nurse", "Resident Intern")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/paramedic/New()
	job = /datum/job/paramedic
	honorifics += list("Paramedic", "Emergency Medical Technician", "First Responder", "E.M.T.")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
	return ..()

/datum/id_trim/job/orderly/
	job = /datum/job/orderly
	honorifics = list("Guard", "Medical Attendant", "Medical Support Officer", "Medical Technician")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/shaft_miner
	job = /datum/job/shaft_miner
	honorifics = list("Miner", "Excavator", "Junior Miner", "Dredger", "Rockbreaker", "Prospector", "Spelunker", "Apprentice Miner", "Drill Technician", "Contract Miner", "Field Scout")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/assistant/
	job = /datum/job/assistant
	honorifics = list("Assistant", "Mr.", "Ms.", "Mrs.", "Miss", "Crewmember", "Crewmate")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/bartender/
	job = /datum/job/bartender
	honorifics = list("Bartender", "Barkeep", "Barmaid", "Barman", "Barwoman", "Barperson")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/bitrunner/
	job = /datum/job/bitrunner
	honorifics = list("Runner", "BDT", "DRS", "ND", "UB", "Junior Runner")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/botanist/
	job = /datum/job/botanist
	honorifics = list("Botanist", "Gardener", "Landscaper")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/job/coroner/
	job = /datum/job/coroner
	honorifics = list("Coroner", "Medical Examiner", "Medical Investigator", "Forensic Pathologist", "Funeral Director", "Mortician", "Undertaker")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE
