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
