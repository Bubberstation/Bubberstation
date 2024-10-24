//Very important modifications for the bird communication, also new emote files for bubber EXCLUSIVE emote list!

/datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/chirp.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/caw2.ogg'

/datum/emote/living/mrrp //you play like a cat
	key = "mrrp"
	key_third_person = "mrrps"
	message = "mrrps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/mrrp.ogg'

/datum/emote/living/fpurr
	key = "fpurr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/fox_purr.ogg'

/datum/emote/living/prbt //all tesh players will love me
	key = "prbt"
	key_third_person = "prbts!"
	message = "prbts!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/prbt.ogg'

/datum/emote/living/gecker
	key = "gecker"
	key_third_person = "geckers"
	message = "geckers!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/foxgecker.ogg'

/datum/emote/living/mar //all shadekin players will love me
	key = "mar"
	key_third_person = "lets out a mar!"
	message = "lets out a mar!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/sound_voice_mar.ogg' // Credit to vorestation

//Silicons can snap now
/datum/emote/living/snap
	key = "snap"
	key_third_person = "snaps"
	message = "snaps their fingers."
	message_param = "snaps their fingers at %t."
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	sound = 'sound/mobs/humanoids/human/snap/fingersnap1.ogg'

/datum/emote/living/meow_alt
	key = "meow1"
	key_third_person = "meows"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/meow1.ogg'

/datum/emote/living/mrowl
	key = "mrowl"
	key_third_person = "mrowls"
	message = "mrowls!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/sound/emotes/mrowl.ogg'

/datum/emote/living/flutter //Moth flutter
	key = "flutter"
	key_third_person = "rapidly flutters their wings!"
	message = "rapidly flutters their wings!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/mobs/humanoids/moth/moth_flutter.ogg'

/datum/emote/living/sigh_exasperated
	key = "esigh" // short for exasperated sigh
	key_third_person = "esighs"
	message = "lets out an exasperated sigh."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh_exasperated/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_zubbers/code/modules/emotes/sound/voice/male_sigh_exasperated.ogg'
		return 'modular_zubbers/code/modules/emotes/sound/voice/female_sigh_exasperated.ogg'
	return

/datum/emote/living/tail_thump
		key = "tailthump"
		key_third_person = "thumps their tail!"
		message = "thumps their tail!"
		emote_type = EMOTE_AUDIBLE
		vary = TRUE
		sound = 'modular_zubbers/code/modules/emotes/sound/voice/tailthump.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159

/datum/emote/living/tail_thump/can_run_emote(mob/user, status_check, intentional, params)
	var/obj/item/organ/external/tail/tail = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(isnull(tail))
		return FALSE
	return ..()


/datum/emote/living/squeal
	key = "squeal"
	key_third_person = "squeals!"
	message = "squeals!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_zubbers/code/modules/emotes/sound/voice/squeal.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159
