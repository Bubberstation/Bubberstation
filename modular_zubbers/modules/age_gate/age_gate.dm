/datum/config_entry/flag/age_confirmation
	default = TRUE //for testing, this should be false before it's merged to master

/client/proc/handle_age_confirmation()
	if(!CONFIG_GET(flag/age_confirmation))
		return

	var/dbAvailable = SSdbcore.Connect()
	if(!dbAvailable)
		message_admins("Age confirmation enabled but no DB was found. Users will be asked every time they join, even if they've joined previously!") //TODO tell user to enable DB or where to turn off age gate
		log_access("Age confirmation enabled but unable to contact DB! User will be asked again the next time they join!")
		to_chat(usr, span_warning("Unable to connect to DB, you will be asked again the next time you join!"))

	//Connect() might have slept, make sure our client is still there.
	if(!src)
		return

	if(dbAvailable && !src.set_db_player_flags())
		message_admins("Unable to retrieve player flags, user will be asked again the next time they join!.")
		log_access("Age confirmation unable to use DB, failed to retrieve player flags for player: [ckey]")
		to_chat(usr, span_warning("Unable to retrieve player flags, you will be asked again the next time you join!"))
		dbAvailable = FALSE

	//set_db_player_flags might sleep
	if(!src)
		return

	if(prefs.db_flags & DB_FLAG_AGE_CONFIRMED)
		//Player has already confirmed their age in the past
		return

	var/isAdult = prompt_player_for_age()
	if(!isAdult)
		to_chat(usr, "You must be 18 years or older to play on this server.")
		qdel(src) //kick client
		return

	log_access("[ckey] sucessfully verified their age!")
	//User is an adult and has verified their age. Save to DB if needed
	if(dbAvailable)
		update_flag_db(DB_FLAG_AGE_CONFIRMED, TRUE)

	return

/client/proc/prompt_player_for_age()
	var/result = alert(usr, "Are you 18 years or older", "Age confirmation", "Yes", "No")
	return result == "Yes"
