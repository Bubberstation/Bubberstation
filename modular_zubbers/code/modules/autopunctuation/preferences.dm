/datum/preference/toggle/autopunctuation
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "autopunctuation"
	savefile_identifier = PREFERENCE_PLAYER

/client/var/autopunctuation

/datum/preference/toggle/autopunctuation/apply_to_client(client/client, value)
	.=..()
	if(value == FALSE)
		client.autopunctuation = FALSE
	else
		client.autopunctuation = TRUE
