/mob/living/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language = null, list/message_mods = list(), forced = null, tts_message, list/tts_filter)
	. = ..()
	if(!blooper)
		return
	if(client && !(client.prefs.read_preference(/datum/preference/toggle/send_blooper)))
		return
	if(HAS_TRAIT(src, TRAIT_SIGN_LANG) && !HAS_TRAIT(src, TRAIT_MUTE)) //if you can speak and you sign, your hands don't make a bark. Unless you are completely mute, you can have some hand bark.
		return
	var/volume = BLOOPER_TRANSMIT_VOLUME
	if(message_mods[WHISPER_MODE])
		volume = BLOOPER_TRANSMIT_VOLUME * 0.5
		message_range++
	var/list/listeners = get_hearers_in_view(message_range, source)
	var/is_yelling = (say_test(message_raw) == "2") // boost the volume if their message ends in !
	blooper.play_bloop(source, listeners, message_raw, message_range, volume * (is_yelling ? 2 : 1), blooper_speed, blooper_pitch, blooper_pitch_range)
