/datum/round_event/pirates/start()
	//Check for admin customization - gang_list is only populated if admins manually spawn the event
	if(gang_list)
		send_pirate_threat(gang_list)
	else
	//fires with the global pirate gang lists if gang_list is empty
		send_pirate_threat(GLOB.heavy_pirate_gangs + GLOB.light_pirate_gangs)


