/mob/living/carbon/Initialize(...)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_POST_TELEPORT, PROC_REF(apply_teleportation_sickness))

/mob/living/carbon/Destroy(...)
	UnregisterSignal(src, COMSIG_MOVABLE_POST_TELEPORT)
	. = ..()

/mob/living/carbon/proc/apply_teleportation_sickness(user,destination,channel) //We don't actually use the user here, but we need to include it so everything is in order.

	if(channel == TELEPORT_CHANNEL_WORMHOLE)
		return FALSE

	if(HAS_TRAIT(src,TRAIT_TELEPORTATION_TRAINED))
		return FALSE

	var/datum/status_effect/teleportation_sickness/existing_status = src.has_status_effect(/datum/status_effect/teleportation_sickness)
	if(existing_status)
		existing_status.do_vomit()
	else
		src.apply_status_effect(/datum/status_effect/teleportation_sickness)

	return TRUE
