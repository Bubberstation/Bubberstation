/datum/species/teshari
	screamsounds = list('modular_zubbers/sound/emotes/teshariscream.ogg')
	femalescreamsounds = null

/datum/emote/living/cough/get_sound(mob/living/user)
	if(israptor(user))
		return 'modular_zubbers/sound/emotes/tesharicough.ogg'
	..(user)

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(israptor(user))
		return 'modular_zubbers/sound/emotes/tesharisneeze.ogg'
	..(user)

/datum/laugh_type/teshari_alt
	name = "Teshari laugh"
	male_laughsounds = list('modular_zubbers/sound/emotes/tesharilaugh.ogg')
	female_laughsounds = null

/datum/scream_type/teshari_alt
	name = "Teshari scream"
	male_screamsounds = list('modular_zubbers/sound/emotes/teshariscream.ogg')
	female_screamsounds = null
