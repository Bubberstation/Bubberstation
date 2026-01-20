/datum/outfit/job/curator
	skillchips = list(/obj/item/skillchip/xenoarch_magnifier)

/datum/job/curator/after_spawn(mob/living/spawned, client/player_client)
	mind_traits += (TRAIT_BLOODSUCKER_HUNTER)
	. = ..()
