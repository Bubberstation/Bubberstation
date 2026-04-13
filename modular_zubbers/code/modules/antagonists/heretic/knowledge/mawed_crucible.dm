/obj/item/eldritch_potion/crucible_soul
	crucible_tip = "Allows you to walk through walls. After expiring, you are teleported to your original location, and are \
	briefly knocked down. A trail of eldritch particles lights the way to your location, so be prepared to move. Lasts 20 seconds."

/datum/status_effect/crucible_soul
	duration = 20 SECONDS // enough to get in and grab some shit but not enough to do much fighting
	// ALTERNATE TODO - do a wizard phlyactery trail

/datum/status_effect/crucible_soul/on_remove()
	var/turf/curr_turf = get_turf(owner)
	curr_turf.Beam(location, icon_state = "lichbeam", time = 5 SECONDS)

	owner.AdjustKnockdown(3 SECONDS)

	return ..()
