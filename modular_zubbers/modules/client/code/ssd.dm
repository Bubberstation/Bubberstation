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


/*
	Code for sending ghosts into the lobby.
	Handles ghostize() and observer Logout()

*/
/mob/dead/observer
	var/datum/timedevent/logout_timer

// Handles fresh ghosts. This includes cryo chambers
/mob/living/ghostize(can_reenter_corpse)
	. = ..()
	var/mob/dead/observer/ghost = .
	if(!istype(ghost))
		return
	if(is_banned_from(ghost.ckey, BAN_RESPAWN))
		return
	// Send them there directly.
	ghost.send_to_lobby()

/mob/dead/observer/Logout()
	. = ..()
	if(CONFIG_GET(flag/allow_respawn))
		if(!ckey) // Turns out sometime ghosts exist without ckeys? A curious thing that shouldn't happen
			return
		if(is_banned_from(ckey, BAN_RESPAWN))
			return
		logout_timer = addtimer(CALLBACK(src, PROC_REF(send_to_lobby)), 15 MINUTES, TIMER_STOPPABLE)

/mob/dead/observer/Login()
	. = ..()
	if(logout_timer)
		deltimer(logout_timer)

// Don't respawn people with a connected body or client
/mob/dead/observer/proc/can_send_to_lobby()
	return ((!mind || QDELETED(mind.current)) && !client)

/mob/dead/observer/proc/send_to_lobby()
	if(!can_send_to_lobby())
		return
	var/mob/dead/new_player/M = new /mob/dead/new_player()

	log_access("Ghost sent to lobby due to disconnect: [key]")
	M.key = key
