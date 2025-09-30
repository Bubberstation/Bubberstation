/datum/controller/subsystem/job
	chain_of_command = list(
			JOB_CAPTAIN = 1,
			JOB_HEAD_OF_PERSONNEL = 2,
			JOB_RESEARCH_DIRECTOR = 3,
			JOB_CHIEF_MEDICAL_OFFICER = 4,
			JOB_CHIEF_ENGINEER = 5,
			JOB_QUARTERMASTER = 6,
			JOB_NT_REP = 7,
			JOB_HEAD_OF_SECURITY = 8,
			JOB_BLUESHIELD = 9,
			JOB_BRIDGE_ASSISTANT = 10,
			JOB_VETERAN_ADVISOR = 11,
			JOB_WARDEN = 12,
			JOB_CLOWN = 13, //I was going to have them be above Warden, but the Clown being Unluck 13 is too poetic to ignore.
			JOB_BOUNCER = 14, //Not sure of the ordering here, I don't think sec/sec like jobs should be near the Captaincy but I also think a joe-schmoe getting it is kinda weird.
			JOB_SCIENCE_GUARD = 15,
			JOB_ORDERLY = 16,
			JOB_ENGINEERING_GUARD = 17,
			JOB_CUSTOMS_AGENT = 18,
			JOB_CORRECTIONS_OFFICER = 19,
			JOB_LAWYER = 20, //Why is service so high waa waa, the HoP is first in line, so after highest dept members (guards as seen above) it just goes the rest of the dept.
			JOB_CHEF = 21,
			JOB_COOK = 22, //Why are these two seperate jobs?
			JOB_BOTANIST = 23,
			JOB_CURATOR = 24,
			JOB_BARTENDER = 25,
			JOB_CURATOR = 26,
			JOB_CHAPLAIN = 27, //Theocracy station.
			JOB_BARBER = 28,
			JOB_SCIENTIST = 29,
			JOB_GENETICIST = 30,
			JOB_ROBOTICIST = 40,
			JOB_CHEMIST = 41,
			JOB_VIROLOGIST = 42, //The meaning of life, who is unplayable.
			JOB_CORONER = 43,
			JOB_PSYCHOLOGIST = 44,
			JOB_PARAMEDIC = 45,
			JOB_MEDICAL_DOCTOR = 46,
			JOB_TELECOMMS_SPECIALIST = 47, //Telecomms is close to Command on some stations, so...
			JOB_STATION_ENGINEER = 48,
			JOB_ATMOSPHERIC_TECHNICIAN = 49,
			JOB_BITRUNNER = 50, //GAMING STATION
			JOB_BLACKSMITH = 51,
			JOB_CARGO_TECHNICIAN = 52,
			JOB_SECURITY_OFFICER = 53,
			JOB_DETECTIVE = 54,
			JOB_SECURITY_MEDIC = 55,
			JOB_ASSISTANT = 56, //It's extremely bleak if we get to this point.
			JOB_SHAFT_MINER = 57, //Breaks the ordering but Cap can't leave the Z-Level with the disk, a miner's entire job involves leaving the Z-Level
			JOB_PRISONER = 58, //Early Parole
			JOB_MIME = 59, //I hate the French so they get to go last.
			JOB_HUMAN_AI = 60, //This is a 1 in a million shot so...
			JOB_CARGO_GORILLA = 61,
		)

/datum/controller/subsystem/job/proc/get_pda_type_by_job(job_name)
	switch(job_name)
		if(JOB_ASSISTANT)
			return new /obj/item/modular_computer/pda
		if(JOB_PRISONER)
			return null
		if(JOB_CAPTAIN) // HEADS
			return new /obj/item/modular_computer/pda/heads/captain
		if(JOB_CHIEF_ENGINEER)
			return new /obj/item/modular_computer/pda/heads/ce
		if(JOB_CHIEF_MEDICAL_OFFICER)
			return new /obj/item/modular_computer/pda/heads/cmo
		if(JOB_HEAD_OF_PERSONNEL)
			return new /obj/item/modular_computer/pda/heads/hop
		if(JOB_HEAD_OF_SECURITY)
			return new /obj/item/modular_computer/pda/heads/hos
		if(JOB_QUARTERMASTER)
			return new /obj/item/modular_computer/pda/heads/quartermaster
		if(JOB_RESEARCH_DIRECTOR)
			return new /obj/item/modular_computer/pda/heads/rd
		if(JOB_BLUESHIELD)
			return new /obj/item/modular_computer/pda/blueshield
		if(JOB_NT_REP)
			return new /obj/item/modular_computer/pda/nanotrasen_consultant
		if(JOB_WARDEN) // SEC
			return new /obj/item/modular_computer/pda/warden
		if(JOB_DETECTIVE)
			return new /obj/item/modular_computer/pda/detective
		if(JOB_SECURITY_OFFICER)
			return new /obj/item/modular_computer/pda/security
		if(JOB_SECURITY_MEDIC)
			return new /obj/item/modular_computer/pda/security
		if(JOB_CORRECTIONS_OFFICER)
			return new /obj/item/modular_computer/pda/security
		if(JOB_STATION_ENGINEER) //ENGI
			return new /obj/item/modular_computer/pda/engineering
		if(JOB_ATMOSPHERIC_TECHNICIAN)
			return new /obj/item/modular_computer/pda/atmos
		if(JOB_ENGINEERING_GUARD)
			return new /obj/item/modular_computer/pda/engineering
		if(JOB_TELECOMMS_SPECIALIST)
			return new /obj/item/modular_computer/pda/telecomms
		if(JOB_MEDICAL_DOCTOR) //MEDICAL
			return new /obj/item/modular_computer/pda/medical
		if(JOB_CORONER)
			return new /obj/item/modular_computer/pda/coroner
		if(JOB_CHEMIST)
			return new /obj/item/modular_computer/pda/chemist
		if(JOB_PARAMEDIC)
			return new /obj/item/modular_computer/pda/medical/paramedic
		if(JOB_ORDERLY)
			return new /obj/item/modular_computer/pda/medical
		if(JOB_SCIENTIST) // SCI
			return new /obj/item/modular_computer/pda/science
		if(JOB_ROBOTICIST)
			return new /obj/item/modular_computer/pda/roboticist
		if(JOB_GENETICIST)
			return new /obj/item/modular_computer/pda/geneticist
		if(JOB_SCIENCE_GUARD)
			return new /obj/item/modular_computer/pda/science
		if(JOB_CARGO_TECHNICIAN) // CARGO
			return new /obj/item/modular_computer/pda/cargo
		if(JOB_SHAFT_MINER)
			return new /obj/item/modular_computer/pda/shaftminer
		if(JOB_BITRUNNER)
			return new /obj/item/modular_computer/pda/bitrunner
		if(JOB_CUSTOMS_AGENT)
			return new /obj/item/modular_computer/pda/cargo
		if(JOB_BARTENDER) // SERVICE
			return new /obj/item/modular_computer/pda/bar
		if(JOB_BOTANIST)
			return new /obj/item/modular_computer/pda/botanist
		if(JOB_COOK)
			return new /obj/item/modular_computer/pda/cook
		if(JOB_CHEF)
			return new /obj/item/modular_computer/pda/cook
		if(JOB_JANITOR)
			return new /obj/item/modular_computer/pda/janitor
		if(JOB_CLOWN)
			return new /obj/item/modular_computer/pda/clown
		if(JOB_MIME)
			return new /obj/item/modular_computer/pda/mime
		if(JOB_CURATOR)
			return new /obj/item/modular_computer/pda/curator
		if(JOB_LAWYER)
			return new /obj/item/modular_computer/pda/lawyer
		if(JOB_CHAPLAIN)
			return new /obj/item/modular_computer/pda/chaplain
		if(JOB_PSYCHOLOGIST)
			return new /obj/item/modular_computer/pda/psychologist
		if(JOB_BARBER)
			return new /obj/item/modular_computer/pda
		if(JOB_BOUNCER)
			return new /obj/item/modular_computer/pda/bar
		else
			return null
