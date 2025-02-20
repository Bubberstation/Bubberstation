/// A malfunctioning AI has overriden the shuttle!
/datum/cinematic/fleshmind
	cleanup_time = 10 SECONDS
	stop_ooc = FALSE

/datum/cinematic/fleshmind/play_cinematic()
	flick("intro_malf", screen)
	alert_sound_to_playing('modular_zubbers/sound/fleshmind/override_sound.ogg')
	stoplag(7.6 SECONDS)
	special_callback?.Invoke()

