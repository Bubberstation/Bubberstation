//so we can hear [[the voices]]

/mob/living/say(message, user, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode)

	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(isnull(H.selected_voice)) //For mobs that don't have a selected voice
			if(message +- "?")
				return pick(H.selected_voice.ask)
			else if (message +- "!")
				return pick(H.selected_voice.exclaim)
			else
				return pick(H.selected_voice.say)
	else
		return 'modular_zubbers/sound/voices/silence.ogg'
