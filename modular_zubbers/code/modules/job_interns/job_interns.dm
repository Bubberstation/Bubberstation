/// Enables the choice of players disabling their Intern ID tag
/datum/preference/toggle/be_intern
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "be_intern"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

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
	else
		return TRUE // I am too lazy to fix this, let's just respect the prefs so we can RP being new

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
