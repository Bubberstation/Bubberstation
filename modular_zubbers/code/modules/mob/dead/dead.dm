/mob/dead/get_status_tab_items()
	.=..()
	if(CONFIG_GET(flag/show_job_estimation))
		. += get_job_estimation()

/mob/dead/proc/get_job_estimation()
	var/list/player_ready_data = list()
	player_ready_data.Cut()
	var/list/players = list()

	for(var/ckey in players)
		var/mob/dead/new_player/player = players[ckey]
		var/datum/preferences/prefs = player.client?.prefs
		if(!prefs)
			continue

		if(!prefs.read_preference(/datum/preference/toggle/ready_job))
			continue

		var/display = player.client?.holder?.fakekey || ckey
		var/datum/job/J = prefs.get_highest_priority_job()

		if(!J)
			player_ready_data += "* [display] forgot to pick a job!"
			continue

		var/title = prefs.alt_job_titles?[J.title] || J.title

		if(player.ready == PLAYER_READY_TO_PLAY)
			player_ready_data += "* [display] as [title]"

		if(length(player_ready_data))
			player_ready_data.Insert(1, "------------------")
			player_ready_data.Insert(1, "Job Estimation:")
			player_ready_data.Insert(1, "")
		return player_ready_data
