/datum/interaction/lewd/clothesplosion
	name = "Clothesplosion"
	description = "Explode out of your clothes."
	usage = INTERACTION_SELF
	message = list(
		"bursts out of their clothes!",
		"explodes out of their outfit!",
		"dramatically tears free of their garments!"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	user_arousal = 0

/datum/interaction/lewd/clothesplosion/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!istype(user))
		return
	user.clothing_burst(FALSE)
