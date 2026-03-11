/mob/Login()
	. = ..()

	if(!.)
		return FALSE

	if(SSplayer_ranks.initialized)
		SSplayer_ranks.update_prefs_donator_status(client?.prefs)

	if(!SSprivacy.has_accepted(client?.ckey, CURRENT_PRIVACY_KEY))
		if(!Master.init_stage_completed)
			spawn(600)
				if(client)
					client.show_privacy_policy()
		else if(Master.init_stage_completed)
			if(client)
				client.show_privacy_policy()
	return TRUE
