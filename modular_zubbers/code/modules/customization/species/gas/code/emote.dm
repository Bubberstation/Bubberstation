/datum/emote/living/cough/get_sound(mob/living/user)
	if(isgas(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/nabbercough.ogg'
	. = ..()

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(isgas(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/nabbersneeze.ogg'
	. = ..()
