/mob/get_status_tab_items()
	.=..()
	if(client?.holder && SSgamemode.statpanel_display == "Secret")
		. += "Storyteller: Secret / [SSgamemode.storyteller.name]"
	else
		. += "Storyteller: [SSgamemode.statpanel_display]"
