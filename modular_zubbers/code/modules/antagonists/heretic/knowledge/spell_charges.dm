/datum/heretic_knowledge/spell/New()
	// infinite hides the tooltip
	max_charges = INFINITY
	transmute_text = ""
	return ..()

/datum/heretic_knowledge/spell/action_update(datum/action/source, atom/movable/screen/movable/action_button/button, ...)
	return

/datum/heretic_knowledge/spell/has_charges(mob/living/user)
	return TRUE

/datum/heretic_knowledge/spell/add_charges(num, uncapped = FALSE)
	return FALSE

/datum/heretic_knowledge/spell/remove_charges(num)
	return FALSE

/datum/status_effect/heretic_passive/recharge_spells()
	return
