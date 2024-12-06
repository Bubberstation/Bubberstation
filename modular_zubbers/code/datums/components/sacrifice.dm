/// Keep track of and debuff the sacrificed
/datum/component/sacrificed
	var/reason = ""
	var/duration = 15 MINUTES

/datum/component/sacrificed/Initialize(mob/sacrificed_mob, given_reason = "4noraisin")
	if(!ismob(sacrificed_mob))
		return COMPONENT_INCOMPATIBLE
	. = ..()
	reason = given_reason
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, PROC_REF(after_sacrifice_revive))
	ADD_TRAIT(parent, TRAIT_CULT_SACRIFICE, source)

/datum/component/sacrificed/Destroy(force)
	. = ..()
	REMOVE_TRAIT(parent, TRAIT_CULT_SACRIFICE, source)

/datum/component/sacrificed/proc/after_sacrifice_revive()
	// show a halo effect for a few seconds
	var/mutable_appearance/new_halo_overlay = mutable_appearance('icons/mob/effects/halo.dmi', "halo[rand(1, 6)]", -HALO_LAYER)
	new_halo_overlay.alpha = 0
	animate(alpha = 255, new_halo_overlay, 1 SECOND)
	new /obj/effect/temp_visual/cult/sparks(get_turf(parent), human_parent.dir)
	flick_overlay_view(new_halo_overlay, 2 SECONDS)
	UnregisterSignal(parent, COMSIG_LIVING_REVIVE)
	addtimer(CALLBACK(src, PROC_REF(end_sacrifice_debuffs)), duration)

/datum/component/sacrificed/proc/end_sacrifice_debuffs()
	REMOVE_TRAIT(parent, TRAIT_CULT_SACRIFICE, source)
	UnregisterSignal(parent, COMSIG_LIVING_REVIVE, PROC_REF(after_sacrifice_revive))
	return
