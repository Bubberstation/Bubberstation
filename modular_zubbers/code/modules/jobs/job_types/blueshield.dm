/datum/job/blueshield
	exp_required_type_department = EXP_TYPE_SECURITY

	departments_list = list(
		/datum/job_department/command,
	)
// Making the Blueshield require sec hours, NOT command hours.
//Blueshield is also now ONLY command.

/datum/outfit/job/blueshield
	id = /obj/item/card/id/advanced/silver

//Making the Blueshield have a silver ID, which cannot receive All Access by default.

/datum/id_trim/job/blueshield // Removes security access. Gives basic cargo access (either all or none basic department access), and removes template access
	extra_access = list(ACCESS_COURT, ACCESS_GATEWAY, ACCESS_BRIG_ENTRANCE)
	minimal_access = list(
		ACCESS_COMMAND, ACCESS_CONSTRUCTION, ACCESS_ENGINEERING, ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS, ACCESS_MEDICAL, ACCESS_RESEARCH, ACCESS_WEAPONS,
	)

/obj/item/encryptionkey/heads/blueshield // Removes security channel because you don't need it
	channels = list(RADIO_CHANNEL_COMMAND = 1)
