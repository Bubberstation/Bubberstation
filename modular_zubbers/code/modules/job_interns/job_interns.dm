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
	/// What department EXP to use to determine internship
	var/internship_dep_exp_type = null

/datum/job/proc/get_intern_time_threshold()
	if(!internship_dep_exp_type)
		return 0
	var/config_type
	switch(internship_dep_exp_type)
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
	if(!player_client.prefs.read_preference(/datum/preference/toggle/be_intern)) // If the pref is off, we stop here
		return FALSE
	var/required_time
	var/playtime
	if(internship_use_self_exp_type)
		var/list/play_records = player_client.prefs.exp
		playtime = play_records[title] ? text2num(play_records[title]) : 0
		required_time = get_intern_time_threshold()
	else if(CONFIG_GET(flag/use_intern_master_job_unlock_threshold) && length(department_head))
		// Use first department head job as our master job to compare to
		var/datum/job/master_job = SSjob.name_occupations[department_head[1]]
		playtime = player_client.calc_exp_type(master_job.get_exp_req_type())
		required_time = master_job.get_exp_req_amount()
	else
		if(!internship_dep_exp_type)
			return FALSE
		required_time = get_intern_time_threshold()
		playtime = player_client.calc_exp_type(internship_dep_exp_type)
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

// Command
/datum/job/captain
	internship_dep_exp_type = EXP_TYPE_COMMAND

/datum/job/chief_engineer
	internship_dep_exp_type = EXP_TYPE_ENGINEERING

/datum/job/chief_medical_officer
	internship_dep_exp_type = EXP_TYPE_MEDICAL

/datum/job/head_of_security
	internship_dep_exp_type = EXP_TYPE_SECURITY

/datum/job/head_of_personnel
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/research_director
	internship_dep_exp_type = EXP_TYPE_SCIENCE

/datum/job/quartermaster
	internship_dep_exp_type = EXP_TYPE_SUPPLY

/datum/job/blueshield
	internship_dep_exp_type = EXP_TYPE_COMMAND

/datum/job/nanotrasen_consultant
	internship_dep_exp_type = EXP_TYPE_COMMAND

// Security
/datum/job/warden
	internship_dep_exp_type = EXP_TYPE_SECURITY

/datum/job/security_officer
	internship_dep_exp_type = EXP_TYPE_SECURITY

/datum/job/security_medic
	internship_dep_exp_type = EXP_TYPE_SECURITY

/datum/job/corrections_officer
	internship_dep_exp_type = EXP_TYPE_SECURITY

/datum/job/detective
	internship_dep_exp_type = EXP_TYPE_SECURITY

// Cargo
/datum/job/cargo_technician
	internship_dep_exp_type = EXP_TYPE_SUPPLY

/datum/job/shaft_miner
	internship_dep_exp_type = EXP_TYPE_SUPPLY

/datum/job/bitrunner
	internship_dep_exp_type = EXP_TYPE_SUPPLY

/datum/job/blacksmith
	internship_dep_exp_type = EXP_TYPE_SUPPLY

/datum/job/customs_agent
	internship_dep_exp_type = EXP_TYPE_SECURITY

// Medical
/datum/job/doctor
	internship_dep_exp_type = EXP_TYPE_MEDICAL

/datum/job/chemist
	internship_dep_exp_type = EXP_TYPE_MEDICAL

/datum/job/paramedic
	internship_dep_exp_type = EXP_TYPE_MEDICAL

/datum/job/coroner
	internship_dep_exp_type = EXP_TYPE_MEDICAL

/datum/job/orderly
	internship_dep_exp_type = EXP_TYPE_SECURITY

/datum/job/virologist
	internship_dep_exp_type = EXP_TYPE_MEDICAL

// Science
/datum/job/scientist
	internship_dep_exp_type = EXP_TYPE_SCIENCE

/datum/job/geneticist
	internship_dep_exp_type = EXP_TYPE_SCIENCE

/datum/job/roboticist
	internship_dep_exp_type = EXP_TYPE_SCIENCE

/datum/job/science_guard
	internship_dep_exp_type = EXP_TYPE_SECURITY

// Engineering
/datum/job/station_engineer
	internship_dep_exp_type = EXP_TYPE_ENGINEERING

/datum/job/atmospheric_technician
	internship_dep_exp_type = EXP_TYPE_ENGINEERING

/datum/job/engineering_guard
	internship_dep_exp_type = EXP_TYPE_SECURITY

// Service
/datum/job/bartender
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/janitor
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/botanist
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/cook
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/psychologist
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/curator
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/barber
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/lawyer
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/mime
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/clown
	internship_use_self_exp_type = TRUE
	internship_dep_exp_type = EXP_TYPE_SERVICE

/datum/job/bouncer
	internship_dep_exp_type = EXP_TYPE_SECURITY

