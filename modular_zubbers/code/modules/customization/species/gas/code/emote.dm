/datum/emote/living/cough/get_sound(mob/living/user)
	if(isgas(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/serpentidcough.ogg'
	. = ..()

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(isgas(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/serpentidsneeze.ogg'
	. = ..()
