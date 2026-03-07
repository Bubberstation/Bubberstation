/mob/Login()
	. = ..()

	if(!.)
		return FALSE

	if(SSplayer_ranks.initialized)
		SSplayer_ranks.update_prefs_donator_status(client?.prefs)

	if(!client.prefs.privacy_policy_acknowledged)
		client.show_privacy_policy()
	return TRUE
