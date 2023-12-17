GLOBAL_DATUM(voice_chime, /datum/voice_chime)

/datum/preference/choiced/voice_chime	//The tgui voice dropdown in char prefs
    category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
    savefile_identifier = PREFERENCE_CHARACTER
    savefile_key = "voice_chime"	// just for the tgui pref, 'voice' is 'voice_chime' to avoid conflicts with tgstation's voice.dm and tts.dm

//List of possible voices
/datum/preference/choiced/voice_chime/init_possible_values()
    return list(assoc_to_keys(GLOB.voice_types))

/datum/preference/choiced/voice_chime/create_default_value()
	return "No Voice"

/datum/preference/choiced/voice_chime/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/voice_chime/apply_to_human(mob/living/carbon/human/target, value)
	var/voice_id = GLOB.voice_types[value]
	if (voice_id)
		var/datum/voice_type/voice_type = new voice_id
		target.selected_voice = voice_type

/datum/preference/toggle/voice_chime	//toggle on or off voices in game prefs
    category = PREFERENCE_CATEGORY_GAME_PREFERENCES
    savefile_key = "voice_toggle"
    savefile_identifier = PREFERENCE_PLAYER

/client/var/voice_chime
/datum/client_interface/var/voice_chime

/datum/preference/toggle/voice_chime/apply_to_client(client/client, value)
	.=..()
	if(value)
		client.voice = TRUE
	else
		client.voice = FALSE
