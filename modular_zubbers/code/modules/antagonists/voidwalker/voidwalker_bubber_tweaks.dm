/datum/action/cooldown/spell/pointed/unsettle
	stun_time = 3 SECONDS


/mob/living/basic/voidwalker
	var/datum/action/cooldown/spell/pointed/voidwalker_avatar_summon/avatar = /datum/action/cooldown/spell/pointed/voidwalker_avatar_summon

/mob/living/basic/voidwalker/Initialize(mapload, mob/tamer)
	. = ..()
	avatar = new avatar(src)
	avatar.Grant(src)

/mob/living/basic/voidwalker/check_wall_validity(turf/closed/wall/wall_to_check, silent = TRUE)
	return TRUE
