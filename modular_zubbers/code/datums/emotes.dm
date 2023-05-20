/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	emote_type = EMOTE_VISIBLE

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints"
	message = "squints their eyes." // i dumb
	emote_type = EMOTE_VISIBLE

/datum/emote/living/mlem
	key = "mlem"
	key_third_person = "mlems"
	message = "sticks their tongue out for a moment. Mlem!"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/audio/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	message_mime = "cackles silently!"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/cackle_yeen.ogg'

/datum/emote/living/audio/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	message_mime = "caws silently!"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/caw.ogg'

/datum/emote/living/audio/bleat
	key = "bleat"
	key_third_person = "bleats"
	message = "bleats loudly!"
	message_mime = "bleats silently!"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/bleat.ogg'

/datum/emote/living/audio/chitter2
	key = "chitter2"
	key_third_person = "chitters2"
	message = "chitters."
	message_mime = "chitters silently!"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/moth/mothchitter2.ogg'

/datum/emote/living/audio/eyebrow3
	key = "eyebrow3"
	key_third_person = "eyebrows3"
	message = "raises an eyebrow <i>quizzaciously</i>."
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/moonmen.ogg'
	cooldown = 7 SECONDS

/datum/emote/living/audio/blink2
	key = "blink2"
	key_third_person = "blinks2"
	message = "blinks."
	message_mime = "blinks expressively."
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/blink.ogg'

/datum/emote/living/audio/lawyerup
	key = "lawyerup"
	key_third_person = "lawyerups"
	message = "emits an aura of expertise."
	message_mime = "acts out an aura of expertise."
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/lawyerup.ogg'
	cooldown = 7.5 SECONDS

/datum/emote/living/audio/wtune
	key = "whistle_tune"
	key_third_person = "whistle_tunes"
	message = "whistles a tune."
	message_mime = "makes an expression as if whistling."
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/wtune1.ogg'

/datum/emote/living/audio/wtune/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_zubbers/sound/voice/wtune1.ogg', 'modular_zubbers/sound/voice/wtune2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/audio/chill
	key = "chill"
	key_third_person = "chills"
	message = "feels a chill running down their spine..."
	message_mime = "acts out a chill running down their spine..."
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/waterphone.ogg'

/datum/emote/living/audio/weh2
	key = "weh2"
	key_third_person = "wehs"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/weh2.ogg'

/datum/emote/living/audio/weh2/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_zubbers/sound/voice/weh2.ogg', 'modular_zubbers/sound/voice/weh3.ogg', 'modular_zubbers/sound/voice/weh_s.ogg', 'modular_zubbers/sound/voice/waa.ogg')

	// Return normally
	. = ..()

/datum/emote/living/audio/ara_ara
	key = "ara"
	key_third_person = "aras"
	message = "coos with sultry surprise~..."
	message_mime = "exudes a sultry aura~"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/ara-ara.ogg'

/datum/emote/living/audio/ara_ara/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_zubbers/sound/voice/ara-ara.ogg', 'modular_zubbers/sound/voice/ara-ara2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/audio/nya2
	key = "nya2"
	key_third_person = "nya2s."
	message = "Lets out a nya~."
	message_mime = "Nyas silently~"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/felinid/nya-1.ogg'

/datum/emote/living/audio/felinid/nyaha/run_emote(mob/user, params)
	sound = pick('modular_zubbers/sound/voice/felinid/nya-1.ogg', 'modular_zubbers/sound/voice/felinid/nya-2.ogg')

/datum/emote/living/audio/teshari/teshcough
	key = "teshcough"
	key_third_person = "teshcoughs"
	message = "coughs cutely!"
	message_mime = "acts out a cute cough!"
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/teshari/tesharicougha.ogg'

/datum/emote/living/audio/teshari/cought/run_emote(mob/user, params)
	sound = pick('modular_zubbers/sound/voice/teshari/tesharicoughb.ogg', 'modular_zubbers/sound/voice/teshari/tesharicougha.ogg')

/datum/emote/living/audio/teshari/scream
	key = "teshscream"
	key_third_person = "teshscreams"
	message = "screams like a chicken!"
	message_mime = "acts out a chicken scream."
	vary = TRUE
	sound = 'modular_zubbers/sound/voice/teshari/teshariscream.ogg'

/datum/emote/living/audio/teshari/sneeze
	key = "teshsneeze"
	key_third_person = "teshsneeze"
	message = "sneezes cutely."
	message_mime = "acts out a cute sneeze."
	sound = 'modular_zubbers/sound/voice/teshari/tesharisneeze.ogg'
