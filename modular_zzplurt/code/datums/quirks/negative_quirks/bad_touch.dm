// Edit to update description
/datum/quirk/bad_touch
	desc = "You don't like physical affection, and have a slight chance of retaliating against others who attempt it."
	value = 0

/datum/quirk/bad_touch/add(client/client_source)
	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/bad_touch)

/datum/quirk/bad_touch/remove()
	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/bad_touch)

// Examine text status effect
/datum/status_effect/quirk_examine/bad_touch
	id = QUIRK_EXAMINE_BADTOUCH

// Set effect examine text
/datum/status_effect/quirk_examine/bad_touch/get_examine_text()
	return span_warning("[owner.p_They()] look[owner.p_s()] like someone who doesn't enjoy physical affection.")
