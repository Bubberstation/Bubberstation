/datum/blooper
	/// User friendly name of the blooper, displayed in preferences menu
	var/name = null
	/// Internal ID of blooper, must be unique
	var/id = null
	/// List of sounds, one is chosen randomly each time the blooper is played
	var/list/sound/soundpath_list = list()

	var/min_pitch = BLOOPER_DEFAULT_MINPITCH
	var/max_pitch = BLOOPER_DEFAULT_MAXPITCH
	var/min_vary = BLOOPER_DEFAULT_MINVARY
	var/max_vary = BLOOPER_DEFAULT_MAXVARY

	// Speed vars. Speed determines the number of characters required for each blooper, with lower speeds being faster with higher blooper density
	var/min_speed = BLOOPER_DEFAULT_MINSPEED
	var/max_speed = BLOOPER_DEFAULT_MAXSPEED

/**
 * Plays the vocal blooper for all listeners, duration is controlled by length of the message argument
 * * speaker - Origin source of the blooper, used for 3D audio calculations and to set the cooldown
 * * listeners - List of mobs that will hear the blooper
 * * message - Chat message being sent, used to determine how long bloopers play for (longer message, more sounds)
 * * distance - Range at which the sounds will be heard
 * * volume - Volume the sounds will play at
 * * speed - How fast the bloopers will be, percentage between 0 - 100, converted and clamped to datum's min/max values
 * * pitch - How high-pitched the bloopers will be, percentage between 0 - 100, converted and clamped to datum's min/max values
 * * pitch_range - Amount of pitch variance for each blooper, percentage between 0 - 100,  converted and clamped to datum's max/min values
 */
/datum/blooper/proc/play_bloop(atom/movable/speaker, list/listeners, message, distance, volume, speed, pitch, pitch_range)
	if(!COOLDOWN_FINISHED(speaker, blooper_cooldown))
		return
	volume = min(volume, 100)
	// convert passed values (which are percentages) into value clamped between min and max of blooper datum
	speed = round(min_speed + ((max_speed - min_speed) * ((100 - speed) / 100)), 0.01) // this one gets inverted because lower % = faster isn't intuitive
	pitch = round(min_pitch + ((max_pitch - min_pitch) * (pitch / 100)), 0.01)
	pitch_range = round(min_vary + ((max_vary - min_vary) * (pitch_range / 100)), 0.01)
	for(var/mob/target_mob in listeners)
		if(target_mob.client && !(target_mob.client.prefs.read_preference(/datum/preference/toggle/hear_blooper)))
			listeners -= target_mob
	var/sound/blooper_pick = pick(soundpath_list)
	var/num_bloopers = min(round(length(message) / speed, 1) + 1, BLOOPER_MAX_BLOOPERS)
	var/total_delay = 0
	for(var/i in 1 to num_bloopers)
		if(total_delay > BLOOPER_MAX_TIME)
			break
		addtimer(CALLBACK(src, PROC_REF(play_callback), speaker, listeners, distance, volume, BLOOPER_DO_VARY(pitch, pitch_range), blooper_pick), total_delay)
		total_delay += rand(DS2TICKS(speed / BLOOPER_SPEED_BASELINE), DS2TICKS(speed / BLOOPER_SPEED_BASELINE) + DS2TICKS(speed / BLOOPER_SPEED_BASELINE)) TICKS
	COOLDOWN_START(speaker, blooper_cooldown, total_delay)

/// Private callback function to actually play the sound, used for timers scheduled in play_bloop
/datum/blooper/proc/play_callback(atom/movable/speaker, list/listeners, distance, volume, pitch, sound/voice)
	PRIVATE_PROC(TRUE)
	for(var/mob/target_mob in listeners)
		target_mob.playsound_local(
			turf_source = get_turf(speaker),
			soundin = voice,
			vol = volume,
			vary = TRUE,
			frequency = pitch,
			falloff_distance = 0,
			falloff_exponent = BLOOPER_SOUND_FALLOFF_EXPONENT,
			max_distance = distance,
		)
