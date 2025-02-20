/* Originally written by Bhijn & Myr on Citadel[1], with various other contributions since- see the Splurt & Citadel github for a full list of contributors.
It has also been further modified by Rashcat & other Fluffyfrontier contributors on Fluffy Frontier!
[1]https://github.com/Citadel-Station-13/Citadel-Station-13/pull/15677
*/
/atom/movable
	// Text-to-blooper sounds
	// yes. all atoms can have a say.
	var/sound/blooper
	var/blooper_id
	var/blooper_pitch = 1
	var/blooper_pitch_range = 0.2 //Actual pitch is (pitch - (blooper_pitch_range*0.5)) to (pitch + (blooper_pitch_range*0.5))
	var/blooper_volume = 50
	var/blooper_speed = 4 //Lower values are faster, higher values are slower
	var/blooper_current_blooper //When bloopers are queued, this gets passed to the blooper proc. If blooper_current_blooper doesn't match the args passed to the blooper proc (if passed at all), then the blooper simply doesn't play. Basic curtailing of spam~

/atom/movable/proc/set_blooper(id)
	if(!id)
		return FALSE
	var/datum/blooper/B = GLOB.blooper_list[id]
	if(!B)
		return FALSE
	blooper = sound(initial(B.soundpath))
	blooper_id = id
	return blooper

/atom/movable/proc/blooper(list/listeners, distance, volume, pitch, queue_time)
	if(!GLOB.blooper_allowed)
		return
	if(queue_time && blooper_current_blooper != queue_time)
		return
	if(!blooper)
		if(!blooper_id || !set_blooper(blooper_id)) //just-in-time blooper generation
			return
	volume = min(volume, 100)
	var/turf/T = get_turf(src)
	for(var/mob/M in listeners)
		M.playsound_local(T, vol = volume, vary = TRUE, frequency = pitch, max_distance = distance, falloff_distance = 0, falloff_exponent = BLOOPER_SOUND_FALLOFF_EXPONENT, sound_to_use = blooper, distance_multiplier = 1)

/atom/movable/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language, list/message_mods = list(), forced = FALSE, tts_message, list/tts_filter)
	. = ..()
	var/list/listeners = get_hearers_in_view(range, source)
	if(blooper || blooper_id)
		for(var/mob/M in listeners)
			if(!M.client)
				continue
			if(!(M.client.prefs?.read_preference(/datum/preference/toggle/hear_sound_blooper)))
				listeners -= M
		var/bloopers = min(round((LAZYLEN(message) / blooper_speed)) + 1, BLOOPER_MAX_BLOOPERS)
		var/total_delay
		blooper_current_blooper = world.time //this is juuuuust random enough to reliably be unique every time send_speech() is called, in most scenarios
		for(var/i in 1 to bloopers)
			if(total_delay > BLOOPER_MAX_TIME)
				break
			addtimer(CALLBACK(src, PROC_REF(blooper), listeners, range, blooper_volume, BLOOPER_DO_VARY(blooper_pitch, blooper_pitch_range), blooper_current_blooper), total_delay)
			total_delay += rand(DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE), DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE) + DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE)) TICKS

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	// This gives a random vocal bark to a random created person
	if(!client)
		set_blooper(pick(GLOB.blooper_list))
		blooper_pitch = BLOOPER_PITCH_RAND(gender)
		blooper_pitch_range = BLOOPER_VARIANCE_RAND
		blooper_speed = rand(BLOOPER_DEFAULT_MINSPEED, BLOOPER_DEFAULT_MAXSPEED)

/mob/living/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language = null, list/message_mods = list(), forced = null, tts_message, list/tts_filter)
	. = ..()

	if(!(client?.prefs.read_preference(/datum/preference/toggle/send_sound_blooper)))
		return
	blooper_volume = client?.prefs.read_preference(/datum/preference/numeric/sound_blooper_volume) //volume scales with your volume slider in game preferences.
	if(HAS_TRAIT(src, TRAIT_SIGN_LANG) && !HAS_TRAIT(src, TRAIT_MUTE)) //if you can speak and you sign, your hands don't make a bark. Unless you are completely mute, you can have some hand bark.
		return
	if(message_mods[WHISPER_MODE])
		blooper_volume = (client?.prefs.read_preference(/datum/preference/numeric/sound_blooper_volume)*0.5) //Whispered barked are half as loud.
		message_range++
	var/list/listening = get_hearers_in_view(message_range, source)
	var/is_yell = (say_test(message_raw) == "2")
	//Listening gets trimmed here if a blooper blooper's present. If anyone ever makes this proc return listening, make sure to instead initialize a copy of listening in here to avoid wonkiness
	if(blooper || blooper_id)
		for(var/mob/M in listening)
			if(!M.client)
				continue

			var/tts_pref = M.client.prefs?.read_preference(/datum/preference/choiced/sound_tts)
			var/hear_blooper = M.client.prefs?.read_preference(/datum/preference/toggle/hear_sound_blooper)

			if(!hear_blooper) // Check pref for blooper
				listening -= M

			else if (CONFIG_GET(string/tts_http_url) && SStts.tts_enabled == TRUE) // TTS for vocal barks.
				if (source.voice == "" || source.voice == "None") // "None" is for borgs
					continue
				if (tts_pref == TTS_SOUND_OFF)
					continue
				listening -= M



		var/bloopers = min(round((LAZYLEN(message_raw) / blooper_speed)) + 1, BLOOPER_MAX_BLOOPERS)
		var/total_delay
		blooper_current_blooper = world.time
		for(var/i in 1 to bloopers)
			if(total_delay > BLOOPER_MAX_TIME)
				break
			addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, blooper), listening, message_range + 1, (blooper_volume * (is_yell ? 2 : 1)), BLOOPER_DO_VARY(blooper_pitch, blooper_pitch_range), blooper_current_blooper), total_delay) //The function is zero on the seventh tile. This makes it a maximum of 1 more.
			total_delay += rand(DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE), DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE) + DS2TICKS((blooper_speed / BLOOPER_SPEED_BASELINE) * (is_yell ? 0.5 : 1))) TICKS


