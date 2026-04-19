/datum/heretic_knowledge/crucible
	desc = "Allows you to transmute a portable water tank and a table to create a Mawed Crucible. \
		The Mawed Crucible can brew powerful potions for combat and utility, but must be fed bodyparts and organs between uses. \
		Non-heretics can drink the potions, but will suffer massive disgust."
	drafting_tier = 2 // its honestly kinda strong asf

/obj/item/eldritch_potion/crucible_soul
	crucible_tip = "Allows you to walk through walls. After expiring, you are teleported to your original location, and are \
	briefly knocked down. A trail of eldritch particles lights the way to your location, so be prepared to move. Lasts 20 seconds."

/datum/status_effect/crucible_soul
	duration = 20 SECONDS // enough to get in and grab some shit but not enough to do much fighting

/datum/status_effect/crucible_soul/on_remove()
	var/turf/curr_turf = get_turf(owner)
	curr_turf.Beam(location, icon_state = "lichbeam", time = 5 SECONDS)

	owner.AdjustKnockdown(1 SECONDS)

	return ..()

/obj/item/eldritch_potion
	/// If this is TRUE, nonheretics can dirnk this.
	var/is_from_crucible = FALSE
