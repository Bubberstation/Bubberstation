/// Enables the choice of players disabling their Intern ID tag
/datum/preference/toggle/be_intern
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "be_intern"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/job
	/// Whether the ID of the job can be tagged as an intern at all
	var/can_be_intern = TRUE
	/// Whether the job uses its own EXP to define the internship status
	var/internship_use_self_exp_type = FALSE

/// Returns the highest priority department this job belongs to
/datum/job/proc/get_highest_priority_department()
	if(!length(departments_list))
		return null
	// Prioritize command
	if(/datum/job_department/command in departments_list)
		return /datum/job_department/command
	// Then security
	if(/datum/job_department/security in departments_list)
		return /datum/job_department/security
	// Then get any first one
	return departments_list[1]

/// Returns the type of intern exp used
/datum/job/proc/get_intern_exp_type()
	var/prio_department = get_highest_priority_department()
	if(isnull(prio_department))
		return
	var/datum/job_department/department = SSjob.get_department_type(prio_department)
	return department.department_experience_type

/// Returns the amount of time required to not be intern
/datum/job/proc/get_intern_time_threshold()
	var/intern_exp_type = get_intern_exp_type()
	if(!intern_exp_type)
		return 0
	var/config_type
	switch(intern_exp_type)
		if(EXP_TYPE_COMMAND)
			config_type = /datum/config_entry/number/intern_threshold_command
		if(EXP_TYPE_SECURITY)
			config_type = /datum/config_entry/number/intern_threshold_security
		if(EXP_TYPE_SUPPLY)
			config_type = /datum/config_entry/number/intern_threshold_cargo
		if(EXP_TYPE_ENGINEERING)
			config_type = /datum/config_entry/number/intern_threshold_engineering
		if(EXP_TYPE_SERVICE)
			config_type = /datum/config_entry/number/intern_threshold_service
		if(EXP_TYPE_MEDICAL)
			config_type = /datum/config_entry/number/intern_threshold_medical
		if(EXP_TYPE_SCIENCE)
			config_type = /datum/config_entry/number/intern_threshold_science
	if(isnull(config_type))
		return 0
	return global.config.Get(config_type) * 60

/// Returns whether a player should be tagged as an intern in this job
/datum/job/proc/player_joins_as_intern(client/player_client)
	if(!can_be_intern)
		return FALSE
	if(!CONFIG_GET(flag/allow_intern_job_tags))
		return FALSE
	if(!SSdbcore.Connect())
		return FALSE
	if(job_flags & JOB_HEAD_OF_STAFF)
		return FALSE
	if(!player_client?.prefs?.read_preference(/datum/preference/toggle/be_intern)) // If the pref is off, we stop here
		return FALSE
	var/required_time
	var/playtime
	if(internship_use_self_exp_type)
		var/list/play_records = player_client?.prefs?.exp
		if(!play_records || !islist(play_records))
			stack_trace("[src] client [player_client] checking for play records resulted in invalid record data")
			return FALSE
		playtime = play_records[title] ? text2num(play_records[title]) : 0
		required_time = get_intern_time_threshold()
	else if(CONFIG_GET(flag/use_intern_master_job_unlock_threshold) && length(department_head))
		// Use first department head job as our master job to compare to
		var/datum/job/master_job = SSjob.get_job(department_head[1])
		playtime = player_client?.calc_exp_type(master_job.get_exp_req_type())
		required_time = master_job.get_exp_req_amount()
	else
		var/exp_type = get_intern_exp_type()
		if(!exp_type)
			stack_trace("[src] failed to get intern exp type")
			return FALSE
		required_time = get_intern_time_threshold()
		playtime = player_client?.calc_exp_type(exp_type)
	if(isnull(playtime))
		if(!player_client)
			stack_trace("[src] tried to check playtime against no player client")
		else
			stack_trace("[src] client [player_client] checking for playtime resulted in null")
		return FALSE
	if(!required_time)
		stack_trace("[src] job failed to set intern time threshold")
		return FALSE
	if(playtime >= required_time)
		return FALSE
	return TRUE

/obj/item/card/id
	var/intern_status = FALSE

/// Sets an intern status and updates the label of the ID
/obj/item/card/id/proc/set_intern_status(new_status)
	intern_status = new_status
	update_label()

/obj/item/card/id/proc/get_job_title()
	var/assignment_string
	if(is_intern || intern_status)
		if(assignment)
			assignment_string = trim?.intern_alt_name || "Intern [assignment]"
		else
			assignment_string = "Intern"
	else
		assignment_string = assignment
	return assignment_string


// Service
/datum/job/bartender
	internship_use_self_exp_type = TRUE

/datum/job/janitor
	internship_use_self_exp_type = TRUE

/datum/job/botanist
	internship_use_self_exp_type = TRUE

/datum/job/cook
	internship_use_self_exp_type = TRUE

/datum/job/prisoner
	can_be_intern = FALSE
