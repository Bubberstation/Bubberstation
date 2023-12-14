//this is the place where you add more voices. probably.

/datum/voice_type
	var/name
	var/list/voice_chime


/datum/voice_type/none //Mime's favorite
	name = "No sound"
	voice_chime = null

/datum/voice_type/voice_1
	name = "Voice 1"
	voice_chime = list(
		'modular_zubbers/sound/voices/speak_1.ogg',
		'modular_zubbers/sound/voices/speak_1_ask.ogg',
		'modular_zubbers/sound/voices/speak_1_exclaim.ogg',
	)

/datum/voice_type/voice_2
	name = "Voice 2"
	voice_chime = list(
		'modular_zubbers/sound/voices/speak_2.ogg',
		'modular_zubbers/sound/voices/speak_2_ask.ogg',
		'modular_zubbers/sound/voices/speak_2_exclaim.ogg',
	)
//I wish I knew what I am doing
/datum/voice_types
var/sound/voice_types
GLOBAL_DATUM
GLOBAL_LIST_INIT(voice_types, list(
	"No sound = list(
		"0","!","?" = sound(null)
	),
	"Voice 1" = list(
		"1" = sound('modular_zubbers/sound/voices/speak_1.ogg'),
		"!" = sound('modular_zubbers/sound/voices/speak_1_exclaim.ogg'),
		"?" = sound('modular_zubbers/sound/voices/speak_1_ask.ogg')
	),
	"Voice 2" = list(
		"2" = sound('modular_zubbers/sound/voices/speak_2.ogg'),
		"!" = sound('modular_zubbers/sound/voices/speak_2_exclaim.ogg'),
		"?" = sound('modular_zubbers/sound/voices/speak_2_ask.ogg')
	)
	))

