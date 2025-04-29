/mob/get_status_tab_items()
	.=..()
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return

	if(SSgamemode.statpanel_display != "Secret")
		. += "Storyteller: [SSgamemode.statpanel_display]"
		return
	else if(client?.holder)
		. += "Storyteller: Secret / [SSgamemode.storyteller.name]"
