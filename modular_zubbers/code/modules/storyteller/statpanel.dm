/mob/get_status_tab_items()
	.=..()
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return

	if(client?.holder && SSgamemode.statpanel_display == "Secret")
		. += "Storyteller: Secret / [SSgamemode.storyteller.name]"
	else
		. += "Storyteller: [SSgamemode.statpanel_display]"
