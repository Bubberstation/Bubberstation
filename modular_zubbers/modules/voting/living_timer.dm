/client
	var/minutes_in_round = 0

/client/proc/update_living_minutes(mins)
	if(!isliving(mob))
		return
	minutes_in_round += mins
