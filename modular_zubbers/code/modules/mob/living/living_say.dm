//so we can hear [[the voices]]
/*
mob/say(M, message, bubble_type, voice_id, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode, voice_chime, ending)
	. = ..()
	if(client)
		ending = copytext_char(message, -1)
		var/sound/speak_chime
		if(ending == "?")
			speak_chime = voice_chime[voice_id]["?"]
		else if(ending == "!")
			speak_chime = voice_chime[voice_id]["!"]
		else
			speak_chime = voice_chime[voice_id][voice_id]
		playsound(M, src, speak_chime, 300, 1, SHORT_RANGE_SOUND_EXTRARANGE-2, SOUND_FALLOFF_EXPONENT = 0)
//		send_voice(message, message_range, src, spans, language, message_mods)
*/

//this looks at Zender's punctuation regex to check if the message ends in either a "!" or "?"
/mob/living/say(message, user, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(isnull(H.selected_voice)) //For mobs that don't have a selected voice
//		(message, GLOB.has_eol_punctuation)
			if(message +- "?")
				return pick(H.selected_voice.ask)
			else if (message +- "!")
				return pick(H.selected_voice.exclaim)
			else
				return pick(H.selected_voice.say)
	else
		return 'modular_zubbers/sound/voices/silence.ogg'
