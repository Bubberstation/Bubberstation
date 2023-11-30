/mob/dead/get_status_tab_items()
	.=..()
	if(CONFIG_GET(flag/show_job_estimation))
		. += get_job_estimation()

/mob/dead/proc/get_job_estimation()
	var/list/player_ready_data = list()
	var/list/players = list()

	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		if(player.ready == PLAYER_READY_TO_PLAY)
			players[player.key] = player

		sortTim(players, GLOBAL_PROC_REF(cmp_text_asc))

	for(var/ckey in players)
		var/mob/dead/new_player/player = players[ckey]
		var/datum/preferences/prefs = player.client?.prefs
		if(!prefs || !prefs.read_preference(/datum/preference/toggle/ready_job))
			continue

		var/display = null
		var/datum/job/J = prefs.get_highest_priority_job()

		if(!J)
			continue

		switch(J.title)
			if(JOB_AI)
				display = prefs.read_preference(/datum/preference/name/ai)
			if(JOB_CLOWN)
				display = prefs.read_preference(/datum/preference/name/clown)
			if(JOB_CYBORG)
				display = prefs.read_preference(/datum/preference/name/cyborg)
			if(JOB_MIME)
				display = prefs.read_preference(/datum/preference/name/mime)
			else
				display = prefs.read_preference(/datum/preference/name/real_name)

		var/title = J.title
		if(player.ready == PLAYER_READY_TO_PLAY && J.title != JOB_ASSISTANT||JOB_PRISONER)
			if(J.departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_SILICON))
				player_ready_data.Insert(1, "[display] as [title]")
			else
				player_ready_data += "* [display] as [title]"

	if(length(player_ready_data))
		player_ready_data.Insert(1, "------------------")
		player_ready_data.Insert(1, "Job Estimation:")
		player_ready_data.Insert(1, "")
	return player_ready_data
