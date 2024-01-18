
// fix this if there's a better way to apply this.
/datum/job/curator/after_spawn(mob/living/spawned, client/player_client)
	mind_traits += (TRAIT_BLOODSUCKER_HUNTER)
	. = ..()
