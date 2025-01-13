/datum/centcom_announcer/default
	alert_sounds = list('modular_zubbers/sound/alerts/green.ogg')

/datum/centcom_announcer/default/New()
	event_sounds |= list(
		ANNOUNCER_GRAVGENBLACKOUT = 'modular_zubbers/sound/alerts/gravgen_blackout.ogg',
		ANNOUNCER_METEORWARNING = 'modular_zubbers/sound/alerts/meteor_warning.ogg',
	)
	. = ..()
