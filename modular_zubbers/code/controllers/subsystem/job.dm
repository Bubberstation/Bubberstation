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
			// Security, as they're the most "responsible" due to their inability to roll antag and general need to get into places to do things like secure the disk or call the emergency shuttle.
			JOB_WARDEN = 12,
			JOB_SECURITY_OFFICER = 13,
			JOB_DETECTIVE = 15,
			JOB_SECURITY_MEDIC = 16,
			JOB_CORRECTIONS_OFFICER = 17,
			// Departmental Guards, as they're already trusted with head-level access to their departments, with a priority matching the head of staff they work for.
			JOB_BOUNCER = 18,
			JOB_SCIENCE_GUARD = 19,
			JOB_ORDERLY = 20,
			JOB_ENGINEERING_GUARD = 21,
			JOB_CUSTOMS_AGENT = 22,
			// Medical, as a member of the emergency services aboard the station, may need to get into departments to pick up bodies.
			JOB_MEDICAL_DOCTOR = 23,
			JOB_PARAMEDIC = 24,
			JOB_CHEMIST = 25,
			JOB_CORONER = 26,
			JOB_PSYCHOLOGIST = 27,
			// Engineering, as a member of the emergency services aboard the station, may need to get into departments to repair hull breaches.
			JOB_STATION_ENGINEER = 28,
			JOB_ATMOSPHERIC_TECHNICIAN = 29,
			JOB_TELECOMMS_SPECIALIST = 30,
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
