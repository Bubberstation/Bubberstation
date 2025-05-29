// This is an emote file for random shit we've ported. Im just copying the style recipes_ported.dm did, yell at me if im wrong later.
// It said it was lazy but personally I think this might be a better way of organizing otherwise unique content that we're porting
// for ourselves. -Reo

// I found this tacked onto the bottom of code/modules/mob/living/emote.dm. No //code add: notice or anything. Moving it here,
// since it seems to all be ported emotes. -Reo
/*
//Carl wuz here
//FUCK YOU CARL SUCK MY BALLS YOU WHORE
/datum/emote/living/tesh_sneeze
	key = "tesh_sneeze"
	key_third_person = "sneezes"
	message = "sneezes."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/tesh_sneeze/can_run_emote(mob/living/user, status_check = TRUE)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent

/datum/emote/living/tesh_sneeze/run_emote(mob/user, params)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(!C.mind || C.mind.miming)//no cute sneezing for you.
			return
		if(ishumanbasic(C))
			playsound(C, pick('hyperstation/sound/voice/emotes/tesh_sneeze1.ogg', 'hyperstation/sound/voice/emotes/tesh_sneeze1b.ogg'), 50, 1)
		if(is_species(user, /datum/species/avian))//This is required(related to subtypes), otherwise it doesn't play the noises. Sometimes. Always sometimes. Just how it be.
			playsound(C, pick('hyperstation/sound/voice/emotes/tesh_sneeze1.ogg', 'hyperstation/sound/voice/emotes/tesh_sneeze1b.ogg'), 50, 1)
		if(is_species(user, /datum/species/mammal))//Just because the avian subspecies doesn't have proper sprites. Some people can't use it.
			playsound(C, pick('hyperstation/sound/voice/emotes/tesh_sneeze1.ogg', 'hyperstation/sound/voice/emotes/tesh_sneeze1b.ogg'), 50, 1)

/datum/emote/living/racc
	key = "racc_chitter"
	key_third_person = "chitters"
	message = "chitters."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/racc/can_run_emote(mob/living/user, status_check = TRUE)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent

/datum/emote/living/racc/run_emote(mob/user, params)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(!C.mind || C.mind.miming)
			return
		if(ishumanbasic(C))
			playsound(C, pick('hyperstation/sound/voice/emotes/racc_chitter_1.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_2.ogg',\
			'hyperstation/sound/voice/emotes/racc_chitter_3.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_4.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_5.ogg',\
			'hyperstation/sound/voice/emotes/racc_chitter_6.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_7.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_8.ogg'), 50, 1)
		if(is_species(user, /datum/species/mammal))
			playsound(C, pick('hyperstation/sound/voice/emotes/racc_chitter_1.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_2.ogg',\
			'hyperstation/sound/voice/emotes/racc_chitter_3.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_4.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_5.ogg',\
			'hyperstation/sound/voice/emotes/racc_chitter_6.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_7.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_8.ogg'), 50, 1)

/datum/emote/living/bat
	key = "bat_chitter"
	key_third_person = "chitters"
	message = "chitters."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bat/can_run_emote(mob/living/user, status_check = TRUE)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent

/datum/emote/living/bat/run_emote(mob/user, params)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(!C.mind || C.mind.miming)
			return
		if(ishumanbasic(C))
			playsound(C, pick('hyperstation/sound/voice/emotes/bat_c1.ogg', 'hyperstation/sound/voice/emotes/bat_c2.ogg', 'hyperstation/sound/voice/emotes/bat_c3.ogg',\
			'hyperstation/sound/voice/emotes/bat_c4.ogg', 'hyperstation/sound/voice/emotes/bat_c5.ogg',\
			 'hyperstation/sound/voice/emotes/bat_c6.ogg', 'hyperstation/sound/voice/emotes/bat_c7.ogg', 'hyperstation/sound/voice/emotes/bat_c8.ogg',\
			 'hyperstation/sound/voice/emotes/bat_c9.ogg'), 50, 1)
		if(is_species(user, /datum/species/mammal))
			playsound(C, pick('hyperstation/sound/voice/emotes/bat_c1.ogg', 'hyperstation/sound/voice/emotes/bat_c2.ogg', 'hyperstation/sound/voice/emotes/bat_c3.ogg',\
			'hyperstation/sound/voice/emotes/bat_c4.ogg', 'hyperstation/sound/voice/emotes/bat_c5.ogg',\
			 'hyperstation/sound/voice/emotes/bat_c6.ogg', 'hyperstation/sound/voice/emotes/bat_c7.ogg', 'hyperstation/sound/voice/emotes/bat_c8.ogg',\
			 'hyperstation/sound/voice/emotes/bat_c9.ogg'), 50, 1)
		if(is_species(user, /datum/species/avian))//this and mammal should be considered the same AAAAAAAAAAAA
			playsound(C, pick('hyperstation/sound/voice/emotes/bat_c1.ogg', 'hyperstation/sound/voice/emotes/bat_c2.ogg', 'hyperstation/sound/voice/emotes/bat_c3.ogg',\
			'hyperstation/sound/voice/emotes/bat_c4.ogg', 'hyperstation/sound/voice/emotes/bat_c5.ogg',\
			 'hyperstation/sound/voice/emotes/bat_c6.ogg', 'hyperstation/sound/voice/emotes/bat_c7.ogg', 'hyperstation/sound/voice/emotes/bat_c8.ogg',\
			 'hyperstation/sound/voice/emotes/bat_c9.ogg'), 50, 1)
*/
//End of the random emotes I found in mob/living


/datum/emote/living
	/// What sound do we want to play?
	var/sound

/datum/emote/living/proc/get_sound()
	return


/datum/emote/living/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!. || user.is_muzzled())
		return

	var/sound_to_play = sound
	if(!sound)
		sound_to_play = get_sound()

	if(!sound_to_play)
		return

	playsound(user.loc, sound_to_play, 50, 1, 4, 1.2)

//Rewrites of the above start.
/datum/emote/living/carbon/racc
	key = "racc_chitter"
	key_third_person = "raccchitters"
	message = "chitters."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/racc/get_sound()
	return pick('hyperstation/sound/voice/emotes/racc_chitter_1.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_2.ogg',\
			'hyperstation/sound/voice/emotes/racc_chitter_3.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_4.ogg', \
			'hyperstation/sound/voice/emotes/racc_chitter_5.ogg','hyperstation/sound/voice/emotes/racc_chitter_6.ogg', \
			'hyperstation/sound/voice/emotes/racc_chitter_7.ogg', 'hyperstation/sound/voice/emotes/racc_chitter_8.ogg')

/datum/emote/living/carbon/bat
	key = "bat_chitter"
	key_third_person = "bat_chitters"
	message = "chitters."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/bat/get_sound()
	return pick('hyperstation/sound/voice/emotes/bat_c1.ogg', 'hyperstation/sound/voice/emotes/bat_c2.ogg', \
			'hyperstation/sound/voice/emotes/bat_c3.ogg', 'hyperstation/sound/voice/emotes/bat_c4.ogg', \
			'hyperstation/sound/voice/emotes/bat_c5.ogg','hyperstation/sound/voice/emotes/bat_c6.ogg', \
			'hyperstation/sound/voice/emotes/bat_c7.ogg', 'hyperstation/sound/voice/emotes/bat_c8.ogg',\
			'hyperstation/sound/voice/emotes/bat_c9.ogg')

//Rewrites of the above end.

//Ported from Vorestation
/datum/emote/living/carbon/teshsqueak
	key = "teshsurprise" //Originally, It was just "surprised" but I dont think that's very telling of a teshari emote.
	key_third_person = "teshsurprised"
	message = "chirps in surprise!"
	message_param = "chirps in surprise at %t!"
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/teshari/teshsqueak.ogg' // Copyright CC BY 3.0 InspectorJ (freesound.org) for the source audio.

/datum/emote/living/carbon/teshchirp
	key = "tchirp"
	key_third_person = "tchirps"
	message = "chirps!"
	message_param = "chirps at %t!"
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/teshari/teshchirp.ogg' // Copyright Sampling+ 1.0 Incarnidine (freesound.org) for the source audio.

/datum/emote/living/carbon/teshtrill
	key = "trill"
	key_third_person = "trills"
	message = "trills."
	message_param = "trills at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/teshari/teshtrill.ogg' // Copyright CC BY-NC 3.0 Arnaud Coutancier (freesound.org) for the source audio.

/datum/emote/living/sneeze/teshsneeze //Replace this with a modular species/tongue based sneeze system later. Also piggybacking on normal sneezes
	key = "teshsneeze"
	key_third_person = "teshsneezes"
	message = "sneezes."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sneeze/teshsneeze/get_sound()
	return pick('GainStation13/sound/voice/teshari/tesharisneeze.ogg', 'GainStation13/sound/voice/teshari/tesharisneezeb.ogg')

/datum/emote/living/cough/teshcough //Same as above. Replace with a modular system later.
	key = "teshcough"
	key_third_person = "teshcoughs"
	message = "coughs."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cough/teshcough/get_sound()
	return pick('GainStation13/sound/voice/teshari/tesharicougha.ogg', 'GainStation13/sound/voice/teshari/tesharicoughb.ogg')

/datum/emote/living/carbon/teshscream
	key = "teshscream"
	key_third_person = "teshscreams"
	message = "screams!"
	message_param = "screams at %t!"
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/teshari/teshscream.ogg'

/datum/emote/living/prbt
	key = "prbt"
	key_third_person = "prbts"
	message = "prbts."
	message_param = "prbts at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/emotes/prbt.ogg'

/datum/emote/living/mlem
	key = "mlem"
	key_third_person = "mlems"
	message = "mlems their tongue up over their nose. Mlem."

/datum/emote/living/blep
	key = "blep"
	key_third_person = "bleps"
	message = "bleps their tongue out. Blep."

/datum/emote/living/teppi
	key = "gyoh"
	key_third_person = "gyohs"
	message = "gyohs"
	var/bigsound = list('GainStation13/sound/voice/teppi/gyooh1.ogg', 'GainStation13/sound/voice/teppi/gyooh2.ogg', \
						'GainStation13/sound/voice/teppi/gyooh3.ogg', 'GainStation13/sound/voice/teppi/gyooh4.ogg', \
						'GainStation13/sound/voice/teppi/gyooh5.ogg', 'GainStation13/sound/voice/teppi/gyooh6.ogg')
	var/smolsound = list('GainStation13/sound/voice/teppi/whine1.ogg', 'GainStation13/sound/voice/teppi/whine2.ogg')

/datum/emote/living/teppi/run_emote(mob/living/user, params)
	/* //If we port teppi later, Enable this.
	if(istype(user, /mob/living/simple_mob/vore/alienanimals/teppi))
		if(istype(user, /mob/living/simple_mob/vore/alienanimals/teppi/baby))
			sound = pick(smolsound)
		else
			sound = pick(bigsound)
		return ..()
	*/
	if(user.size_multiplier >= 1.5)
		sound = pick(bigsound)
	else
		sound = pick(smolsound)
	. = ..()

/datum/emote/living/teppi/rumble
	key = "rumble"
	key_third_person = "rumbles"
	message = "rumbles contentedly."
	sound = 'GainStation13/sound/voice/teppi/cute_rumble.ogg'
	bigsound = list('GainStation13/sound/voice/teppi/rumble.ogg')
	smolsound = list('GainStation13/sound/voice/teppi/cute_rumble.ogg')

//Vorestation ports end.

//Ported from Chompstation
/datum/emote/living/wawa
	key = "wawa"
	key_third_person = "wawas"
	message = "wawas."
	message_param = "wawas at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/emotes/wawa.ogg'

//Chompstation ports end.
