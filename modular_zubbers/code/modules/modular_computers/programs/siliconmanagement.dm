/datum/computer_file/program/silicon_management
	filename = "Silicon Manager"
	filedesc = "Silicon Manager"
	downloader_category = PROGRAM_CATEGORY_EQUIPMENT
	program_open_overlay = "id"
	extended_desc = "Program for viewing and changing Silicon priority."
	download_access = list(ACCESS_ROBOTICS)
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	size = 4
	tgui_id = "SiliconJobManager"
	program_icon = "address-book"

/datum/computer_file/program/silicon_management/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/obj/item/card/id/user_id = computer.computer_id_slot
	if(!user_id || !(ACCESS_ROBOTICS in user_id.access))
		return TRUE

	if(action)
		var/priority_target = params["target"]
		var/datum/job/silicon = SSjob.get_job(priority_target)
		if(silicon in SSjob.prioritized_jobs)
			SSjob.prioritized_jobs -= silicon
		else
			SSjob.prioritized_jobs += silicon
		playsound(computer, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
		return TRUE

/datum/computer_file/program/silicon_management/ui_data(mob/user)
	var/list/data = list()

	var/authed = FALSE
	var/obj/item/card/id/user_id = computer.computer_id_slot
	if(user_id && (ACCESS_ROBOTICS in user_id.access))
		authed = TRUE

	var/list/silicon_jobs = list(
		SSjob.get_job(JOB_AI),
		SSjob.get_job(JOB_CYBORG)
	)
	data["authed"] = authed

	var/list/pos = list()
	var/list/priority = list()
	for(var/datum/job/job as anything in silicon_jobs)
		if(job in SSjob.prioritized_jobs)
			priority += job.title

		pos += list(list(
			"title" = job.title,
			"current" = job.current_positions,
			"total" = job.total_positions,
		))
	data["slots"] = pos
	data["prioritized"] = priority
	return data
