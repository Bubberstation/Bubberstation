// Job estimation code, this appears on the statpanel before roundstart
// Credit: https://github.com/DaedalusDock/daedalusdock/pull/377

/datum/config_entry/flag/show_job_estimation
	default = TRUE

/datum/preference/toggle/ready_job
	savefile_key = "ready_job"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE

/datum/preference/toggle/ready_job/apply_to_human(mob/living/carbon/human/target, value, /datum/preferences/preferences)
	return FALSE

/mob/dead/get_status_tab_items()
	.=..()
	//Adds the Job Estimation panel to the end of the Statpanel.
	if(CONFIG_GET(flag/show_job_estimation))
		. += get_job_estimation()

/mob/dead/proc/get_job_estimation()
	var/list/player_ready_data = list()
	var/list/players = list()

	//This fills the readied players list that the job estimation panel uses.
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		if(player.ready == PLAYER_READY_TO_PLAY)
			players[player.key] = player

		sortTim(players, GLOBAL_PROC_REF(cmp_text_asc))

	for(var/ckey in players)
		var/mob/dead/new_player/player = players[ckey]
		var/datum/preferences/prefs = player.client?.prefs
		var/display = null
		var/datum/job/J = prefs?.get_highest_priority_job()
		var/title = J?.title
		//If a player does not have preferences (for some reason) or they don't want to be shown on the panel, continue
		if(!J || !(prefs.read_preference(/datum/preference/toggle/ready_job)))
			continue
		//If the readied player has selected a miscellaneous job (Assistant, or Prisoner), they shouldn't be displayed
		if(title == JOB_ASSISTANT || title == JOB_PRISONER)
			continue

		//If the job the player is selecting has a special name, that name should be displayed in the menu, otherwise it should use the normal name
		switch(title)
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
			//If our player is a member of Command or a Silicon, we want to sort them to the top of the list. Otherwise, just add them to the end of the list.
		if(J.departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_SILICON))
			player_ready_data.Insert(1, "* [display] as [title]")
		else
			player_ready_data += "* [display] as [title]"

	//The title line for the job estimation panel, obviously needs to be at the top
	if(length(player_ready_data))
		player_ready_data.Insert(1, "------------------")
		player_ready_data.Insert(1, "Job Estimation:")
		player_ready_data.Insert(1, "")
	return player_ready_data
