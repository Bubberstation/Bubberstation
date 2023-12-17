//this is the place where you add more voices. probably.
GLOBAL_LIST_EMPTY(voice_types)


/datum/voice_type	//The datum where character voice chimes are picked out
	//Name of the voice
	var/name = "Name"
	//Optional, use when a voice is defaulted to a species
	var/species = list()
	//Audio file used for normal speech
	var/list/say
	//Audio file used for speech ending with a "!"
	var/list/exclaim
	//Audio file used for speech ending with a "?"
	var/list/ask

/datum/voice_type/none
	name = "No Voice"
	say = 'modular_zubbers/sound/voices/silence.ogg'
	exclaim = 'modular_zubbers/sound/voices/silence.ogg'
	ask = 'modular_zubbers/sound/voices/silence.ogg'
//species = list(abductor, mime, etc) this variable isnt even used yet

/datum/voice_type/voice_1
	name = "Normal Voice"
	say = 'modular_zubbers/sound/voices/speak_1.ogg'
	exclaim = 'modular_zubbers/sound/voices/speak_1_exclaim.ogg'
	ask = 'modular_zubbers/sound/voices/speak_1_ask.ogg'

/datum/voice_type/voice_2
	name = "Second Voice"
	say = 'modular_zubbers/sound/voices/speak_2.ogg'
	exclaim = 'modular_zubbers/sound/voices/speak_2_exclaim.ogg'
	ask = 'modular_zubbers/sound/voices/speak_2_ask.ogg'

/* THE SUPER COMMENT START
/datum/voice_type
	var/name
	var/list/voice_type


/datum/voice_type/none //Mime's favorite
	name = "No Voice"
	voice_type = null

/datum/voice_type/voice_1
	name = "Voice 1"
	voice_type = list(
		'modular_zubbers/sound/voices/speak_1.ogg',
		'modular_zubbers/sound/voices/speak_1_ask.ogg',
		'modular_zubbers/sound/voices/speak_1_exclaim.ogg',
	)

/datum/voice_type/voice_2
	name = "Voice 2"
	voice_type = list(
		'modular_zubbers/sound/voices/speak_2.ogg',
		'modular_zubbers/sound/voices/speak_2_ask.ogg',
		'modular_zubbers/sound/voices/speak_2_exclaim.ogg',
	)

THE SUPER COMMENT END */
//I wish I knew what I am doing

//GLOBAL_DATUM
//GLOBAL_LIST_INIT(voice_chime, list(
//	"No Voice" = list(
//		"1","!","?" = sound(null)
//	),
//	"Voice 1" = list(
//		"1" = sound('modular_zubbers/sound/voices/speak_1.ogg'),
//		"!" = sound('modular_zubbers/sound/voices/speak_1_exclaim.ogg'),
//		"?" = sound('modular_zubbers/sound/voices/speak_1_ask.ogg')
//	),
//	"Voice 2" = list(
//		"1" = sound('modular_zubbers/sound/voices/speak_2.ogg'),
//		"!" = sound('modular_zubbers/sound/voices/speak_2_exclaim.ogg'),
//		"?" = sound('modular_zubbers/sound/voices/speak_2_ask.ogg')
//	)
//	))
