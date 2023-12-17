/*
!!!!!!!!IMPORTANT!!!!!!!!
The current audio files are owned by Goonstation. They are to NEVER be merged or test merged into the current public server.
Due to copyright, The files here are for temporarily testing of the voice function. @Gavla will acquire the proper files soon.
*/
//This is the place where you add more voices. probably.
GLOBAL_LIST_EMPTY(voice_types)


/datum/voice_type	//The datum where character voice chimes are picked out
	//Name of the voice
	var/name = "Name"
	//Optional, use when a voice is defaulted to a species (i.e. akula, tajaran, vulpkanin, etc.)
	var/species = list()	//currently unused
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
//	species = list(abductor, mime, etc) this variable isnt even used yet

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
