GLOBAL_LIST_EMPTY(client_minutes_in_round)

/client/proc/update_living_minutes(mins)
	if(!isliving(mob))
		return
	GLOB.client_minutes_in_round[ckey] += mins
