// Global cached list of job exemption to lower stress on the database
// Associative list of ckey to associative list of job titles which were granted the exemption ex. `job_exempt_cache[ckey][job_title]` being null is no exemption and being TRUE is an exemption
GLOBAL_LIST_INIT(job_exempt_cache, list())

/**
 * Returns whether a ckey has the job exemption for a job
 *
 * Arguments:
 * * ckey - The ckey you're checking, both key and ckey work
 * * job_title - The `job.title` of the job you're checking
 */
/proc/is_job_exempt_from(ckey, job_title)
	if(!SSdbcore.Connect())
		return FALSE
	// Convert to ckey just in case we get called with player 'key'
	var/player_ckey = ckey(ckey)
	// Load the ckey cache if it is not present
	load_job_exempt_cache(player_ckey)
	return GLOB.job_exempt_cache[player_ckey][job_title]

/**
 * Loads job exempt cache for ckey, for internal use
 *
 * Arguments:
 * * ckey - The ckey to load the cache for
 */
/proc/load_job_exempt_cache(ckey)
	if(GLOB.job_exempt_cache[ckey])
		return
	GLOB.job_exempt_cache[ckey] = list()
	// Load list from DB
	var/datum/db_query/get_query = SSdbcore.NewQuery(
		"SELECT jobs FROM [format_table_name("jobexempt")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!get_query.warn_execute())
		qdel(get_query)
		return
	// Get first row value
	if(!get_query.NextRow())
		// If there's none then that means we havent inserted anything, so do that
		var/datum/db_query/insert_query = SSdbcore.NewQuery(
			"INSERT INTO [format_table_name("jobexempt")] (ckey, jobs) VALUES(:ckey, :jobs)",
			list("ckey" = ckey, "jobs" = "")
			)
		insert_query.Execute()
		qdel(insert_query)
		qdel(get_query)
		return
	// We got a value, split the string and set the job titles to TRUE in our cache
	var/list/string_list = splittext(get_query.item[1], ";")
	for(var/job_title in string_list)
		if(job_title == "")
			continue
		GLOB.job_exempt_cache[ckey][job_title] = TRUE
	qdel(get_query)

/**
 * Sets the job exempt state of a ckey to desired state
 *
 * Arguments:
 * * ckey - The ckey to set the state for
 * * job_title - The `job.title` of the state
 * * state - New TRUE or FALSE state to set it to
 */
/proc/set_job_exempt_state(ckey, job_title, state)
	if(!SSdbcore.Connect())
		return
	// Convert to ckey just in case we get called with player 'key'
	var/player_ckey = ckey(ckey)
	load_job_exempt_cache(player_ckey)
	// Set cache
	if(state)
		GLOB.job_exempt_cache[player_ckey][job_title] = TRUE
	else
		GLOB.job_exempt_cache[player_ckey] -= job_title
	// Set state in DB
	var/joined_string = ""
	for(var/title in GLOB.job_exempt_cache[player_ckey])
		if(joined_string == "")
			joined_string = title
		else
			joined_string += ";[title]"
	var/datum/db_query/query = SSdbcore.NewQuery(
		"UPDATE [format_table_name("jobexempt")] SET jobs = :jobs WHERE ckey = :ckey",
		list("jobs" = joined_string, "ckey" = player_ckey)
	)
	query.Execute(FALSE)
	qdel(query)

#define JOBS_PER_COLUMN 20

/**
 * Displays the job exempt menu UI to target admin user
 *
 * Arguments:
 * * user - The administrator mob to display the UI to
 * * target_ckey - The ckey to inspect and possibly modify the job exemption statuses
 */
/proc/show_job_exempt_menu(mob/user, target_ckey)
	if(!check_rights(R_ADMIN))
		return
	var/list/dat = list()
	if(!SSdbcore.Connect())
		dat += "Can't connect to the database"
	else
		dat += "Toggle playtime exemption for specific jobs for the ckey: [target_ckey]<HR>"
		var/job_count = 0
		dat += "<table width='100%'><tr><td width='33%' valign='top'>"
		for(var/datum/job_department/department as anything in SSjob.joinable_departments)
			if(job_count >= JOBS_PER_COLUMN)
				job_count -= JOBS_PER_COLUMN
				dat += "</td><td width='33%' valign='top'>"
			dat += "<b>[department.department_name]</b><br>"
			for(var/datum/job/job as anything in department.department_jobs)
				job_count++
				dat += "<a [is_job_exempt_from(target_ckey, job.title) ? "class='linkOn'" : ""] href='byond://?_src_=holder;[HrefToken()];getjobexempttask=[target_ckey];task=togglejob;job=[job.title]'>[job.title]</a><br>"
		dat += "</tr></td></table>"
	var/datum/browser/popup = new(user, "job_exempt_menu", "Job Exemption Menu", 730, 650)
	popup.set_content(dat.Join())
	popup.open()

#undef JOBS_PER_COLUMN

/**
 * Topic handler for the job exempt menu
 *
 * Arguments:
 * * user - The administrator mob invoking the Topic
 * * href - The href token
 * * href_list - The href list
 * * target_ckey - The ckey to edit
 */
/proc/handle_job_exempt_menu_topic(mob/user, href, href_list, target_ckey)
	if(!check_rights(R_ADMIN))
		return
	switch(href_list["task"])
		if("togglejob")
			var/job_title = href_list["job"]
			var/newstate = !is_job_exempt_from(target_ckey, job_title)
			set_job_exempt_state(target_ckey, job_title, newstate)
			// Announce to admins which admin is modifying whose exemptions
			message_admins("[key_name_admin(user)] has [newstate ? "activated" : "deactivated"] job exp exempt status on ckey [target_ckey] for job: [job_title]")
			log_admin("[key_name(user)] has [newstate ? "activated" : "deactivated"] job exp exempt status on ckey [target_ckey] for job: [job_title]")
			// If a client whose job exemption is being modified, announce it to the player aswell
			var/client/client = GLOB.directory[target_ckey]
			if(client)
				to_chat(client, span_boldnotice("Job exemption status for [job_title] has been [newstate ? "activated" : "deactivated"]"))
	show_job_exempt_menu(user, target_ckey)
