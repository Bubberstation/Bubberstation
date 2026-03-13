/datum/looping_sound/global_sound
	parent_type = /datum/looping_sound

	var/new_player = TRUE
	var/list/sounds_to_play

	direct = TRUE
	volume = 45
	vary = FALSE
	extra_range = -1
	ignore_walls = TRUE
	pressure_affected = FALSE
	use_reverb = FALSE
	chance = 100
	in_order = TRUE
	each_once = FALSE

/datum/looping_sound/global_sound/New(start_immediately = FALSE)
	if(sounds_to_play)
		mid_sounds = list()
		for(var/sound_path in sounds_to_play)
			var/pause_length = sounds_to_play[sound_path]
			if(isfile(sound_path) && pause_length > 0)
				mid_sounds[sound_path] = pause_length

		if(!length(mid_sounds))
			stack_trace("train_sound_loop created without sounds!")
			qdel(src)
			return
	..(null, start_immediately)

/datum/looping_sound/global_sound/proc/create_from_list(sounds)
	sounds_to_play = sounds
	mid_sounds = list()
	for(var/sound_path in sounds_to_play)
		var/pause_length = sounds_to_play[sound_path]
		if(isfile(sound_path) && pause_length > 0)
			mid_sounds[sound_path] = pause_length

/datum/looping_sound/global_sound/get_sound(_mid_sounds)
	var/soundfile = ..()

	if(soundfile && (soundfile in sounds_to_play))
		set_mid_length(sounds_to_play[soundfile])

	return soundfile

/datum/looping_sound/global_sound/play(soundfile, volume_override)
	if(!soundfile)
		return

	var/sound/S = sound(soundfile)
	S.volume = volume_override || volume
	S.channel = sound_channel || SSsounds.random_available_channel()
	for(var/mob/M as anything in GLOB.player_list)
		if(!M.client)
			continue
		if(!new_player && isnewplayer(M))
			continue

		SEND_SOUND(M, S)

/datum/looping_sound/global_sound/stop(null_parent = FALSE)
	if(sound_channel)
		for(var/mob/M as anything in GLOB.player_list)
			if(M.client)
				M.stop_sound_channel(sound_channel)

	return ..()
