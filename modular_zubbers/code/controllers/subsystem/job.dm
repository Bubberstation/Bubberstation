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
			JOB_BRIDGE_ASSISTANT = 10
		)

/datum/controller/subsystem/job/proc/get_pda_type_by_job(job_name)
	switch(job_name)
		if(JOB_ASSISTANT)
			return new /obj/item/modular_computer/pda/crew/assistant
		if(JOB_PRISONER)
			return null
		if(JOB_CAPTAIN) // HEADS
			return new /obj/item/modular_computer/pda/crew/heads/captain
		if(JOB_CHIEF_ENGINEER)
			return new /obj/item/modular_computer/pda/crew/heads/ce
		if(JOB_CHIEF_MEDICAL_OFFICER)
			return new /obj/item/modular_computer/pda/crew/heads/cmo
		if(JOB_HEAD_OF_PERSONNEL)
			return new /obj/item/modular_computer/pda/crew/heads/hop
		if(JOB_HEAD_OF_SECURITY)
			return new /obj/item/modular_computer/pda/crew/heads/hos
		if(JOB_QUARTERMASTER)
			return new /obj/item/modular_computer/pda/crew/heads/quartermaster
		if(JOB_RESEARCH_DIRECTOR)
			return new /obj/item/modular_computer/pda/crew/heads/rd
		if(JOB_BLUESHIELD)
			return new /obj/item/modular_computer/pda/crew/blueshield
		if(JOB_NT_REP)
			return new /obj/item/modular_computer/pda/crew/nanotrasen_consultant
		if(JOB_WARDEN) // SEC
			return new /obj/item/modular_computer/pda/crew/warden
		if(JOB_DETECTIVE)
			return new /obj/item/modular_computer/pda/crew/detective
		if(JOB_SECURITY_OFFICER)
			return new /obj/item/modular_computer/pda/crew/security
		if(JOB_SECURITY_MEDIC)
			return new /obj/item/modular_computer/pda/crew/security
		if(JOB_CORRECTIONS_OFFICER)
			return new /obj/item/modular_computer/pda/crew/security
		if(JOB_STATION_ENGINEER) //ENGI
			return new /obj/item/modular_computer/pda/crew/engineering
		if(JOB_ATMOSPHERIC_TECHNICIAN)
			return new /obj/item/modular_computer/pda/crew/atmos
		if(JOB_ENGINEERING_GUARD)
			return new /obj/item/modular_computer/pda/crew/engineering
		if(JOB_TELECOMMS_SPECIALIST)
			return new /obj/item/modular_computer/pda/crew/telecomms
		if(JOB_MEDICAL_DOCTOR) //MEDICAL
			return new /obj/item/modular_computer/pda/crew/medical
		if(JOB_CORONER)
			return new /obj/item/modular_computer/pda/crew/coroner
		if(JOB_CHEMIST)
			return new /obj/item/modular_computer/pda/crew/chemist
		if(JOB_PARAMEDIC)
			return new /obj/item/modular_computer/pda/crew/medical/paramedic
		if(JOB_ORDERLY)
			return new /obj/item/modular_computer/pda/crew/medical
		if(JOB_SCIENTIST) // SCI
			return new /obj/item/modular_computer/pda/crew/science
		if(JOB_ROBOTICIST)
			return new /obj/item/modular_computer/pda/crew/roboticist
		if(JOB_GENETICIST)
			return new /obj/item/modular_computer/pda/crew/geneticist
		if(JOB_SCIENCE_GUARD)
			return new /obj/item/modular_computer/pda/crew/science
		if(JOB_CARGO_TECHNICIAN) // CARGO
			return new /obj/item/modular_computer/pda/crew/cargo
		if(JOB_SHAFT_MINER)
			return new /obj/item/modular_computer/pda/crew/shaftminer
		if(JOB_BITRUNNER)
			return new /obj/item/modular_computer/pda/crew/bitrunner
		if(JOB_CUSTOMS_AGENT)
			return new /obj/item/modular_computer/pda/crew/cargo
		if(JOB_BARTENDER) // SERVICE
			return new /obj/item/modular_computer/pda/crew/bar
		if(JOB_BOTANIST)
			return new /obj/item/modular_computer/pda/crew/botanist
		if(JOB_COOK)
			return new /obj/item/modular_computer/pda/crew/cook
		if(JOB_CHEF)
			return new /obj/item/modular_computer/pda/crew/cook
		if(JOB_JANITOR)
			return new /obj/item/modular_computer/pda/crew/janitor
		if(JOB_CLOWN)
			return new /obj/item/modular_computer/pda/crew/clown
		if(JOB_MIME)
			return new /obj/item/modular_computer/pda/crew/mime
		if(JOB_CURATOR)
			return new /obj/item/modular_computer/pda/crew/curator
		if(JOB_LAWYER)
			return new /obj/item/modular_computer/pda/crew/lawyer
		if(JOB_CHAPLAIN)
			return new /obj/item/modular_computer/pda/crew/chaplain
		if(JOB_PSYCHOLOGIST)
			return new /obj/item/modular_computer/pda/crew/psychologist
		if(JOB_BARBER)
			return new /obj/item/modular_computer/pda/crew
		if(JOB_BOUNCER)
			return new /obj/item/modular_computer/pda/crew/bar
		else
			return null

/**
 * Handles giving out the mobs alternate job title to their items
 *
 * Arguments:
 * * equipping - /mob/living/carbon/human on whom we're working
 * * job - /datum/job of the mob
 * * player_client - /client of equipping
 */
/datum/controller/subsystem/job/proc/setup_alt_job_items(mob/living/carbon/human/equipping, datum/job/job, client/player_client)
	if(!player_client)
		return

	if(!ishuman(equipping))
		return

	var/chosen_title = player_client.prefs.alt_job_titles?[job.title] || job.title

	var/obj/item/card/id/card = equipping.wear_id
	if(istype(card))
		card.assignment = chosen_title
		card.update_label()

	// Look for PDA in belt or L pocket
	var/obj/item/modular_computer/pda/pda = equipping.belt
	if(!istype(pda))
		pda = equipping.l_store
	if(istype(pda))
		pda.saved_job = chosen_title
		pda.UpdateDisplay()
