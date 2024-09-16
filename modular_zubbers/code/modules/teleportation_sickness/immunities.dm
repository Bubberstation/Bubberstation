/datum/round_event/ghost_role/space_ninja/spawn_role()
	. = ..()
	for(var/mob/living/carbon/spawned_ninja in spawned_mobs)
		ADD_TRAIT(spawned_ninja,TRAIT_TELEPORTATION_TRAINED,ROLE_NINJA)
