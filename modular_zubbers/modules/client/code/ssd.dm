/mob/living/carbon/human/Logout()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_SUICIDED))
		alpha = GHOST_ALPHA

	if(!(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH))))
		if(get_organ_by_type(/obj/item/organ/internal/brain))
			if(!key)
				alpha = GHOST_ALPHA

/mob/living/carbon/human/Login()
	. = ..()
	alpha = 255

/mob/dead/observer
	var/datum/timedevent/logout_timer

/mob/dead/observer/Logout()
	. = ..()
	if(CONFIG_GET(flag/allow_respawn) && ckey)
		if(is_banned_from(ckey, BAN_RESPAWN))
			return
		logout_timer = addtimer(CALLBACK(src, .proc/send_to_lobby), 5 MINUTES, flags = TIMER_STOPPABLE)

/mob/dead/observer/Login()
	. = ..()
	if(logout_timer)
		deltimer(logout_timer)

/mob/dead/observer/proc/can_send_to_lobby()
	return ((!mind || QDELETED(mind.current)) && !client)

/mob/dead/observer/proc/send_to_lobby()
	if(!can_send_to_lobby())
		return
	var/mob/dead/new_player/M = new /mob/dead/new_player()

	log_access("Ghost sent to lobby due to disconnect: [key]")
	M.key = key
