GLOBAL_LIST_EMPTY(voice_types)

/datum/voice_type
	var/name
	var/list/voice_chime

/datum/voice_type/none //Mime's favorite
	name = "No Voice"
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
GLOBAL_REAL_VAR(list/voice_types) = list(
	"none" = list(
		"0","!","?" = sound('null')
	),
	"voice_1" = list(
		"1" = sound('modular_zubbers/sound/voices/speak_1.ogg'),
		"!" = sound('modular_zubbers/sound/voices/speak_1_exclaim.ogg'),
		"?" = sound('modular_zubbers/sound/voices/speak_1_question.ogg')
	),
	"voice_2" = list(
		"2" = sound('modular_zubbers/sound/voices/speak_2.ogg'),
		"!" = sound('modular_zubbers/sound/voices/speak_2_exclaim.ogg'),
		"?" = sound('modular_zubbers/sound/voices/speak_2_question.ogg')
	),
)
//reference the real global? idk what that means
GLOBAL_LIST_INIT(voice_types)
