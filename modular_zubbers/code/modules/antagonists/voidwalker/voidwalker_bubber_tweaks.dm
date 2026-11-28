/datum/action/cooldown/spell/pointed/unsettle
	stun_time = 3 SECONDS


/mob/living/basic/voidwalker/check_wall_validity(turf/closed/wall/wall_to_check, silent = TRUE)
	return TRUE

/datum/action/cooldown/mob_cooldown/charge/voidwalker/on_moved(atom/source)
	SEND_SIGNAL(source, COMSIG_ATOM_REVEAL)
