/datum/emote/speen
	key = "speen"
	key_third_person = "speeeeens!"
	restraint_check = TRUE
	mob_type_allowed_typecache = list(/mob/living, /mob/dead/observer)
	mob_type_ignore_stat_typecache = list(/mob/dead/observer)

/datum/emote/speen/run_emote(mob/user)
	. = ..()
	if(.)
		user.spin(20, 1)

		if(iscyborg(user) && user.has_buckled_mobs())
			var/mob/living/silicon/robot/R = user
			var/datum/component/riding/riding_datum = R.GetComponent(/datum/component/riding)
			if(riding_datum)
				for(var/mob/M in R.buckled_mobs)
					riding_datum.force_dismount(M)
			else
				R.unbuckle_all_mobs()

/datum/emote/speen/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'GainStation13/sound/voice/speen.ogg', 50, 1, -1)
	. = ..()


/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE

/datum/emote/living/cackle/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'GainStation13/sound/voice//cackle_yeen.ogg', 50, 1, -1)
	. = ..()
