// Merges Buns of Steel flavor text
/datum/quirk/personalspace
	desc = "You'd rather people keep their hands off your rear end. Anyone who tries to slap your rock-hard posterior usually gets a broken hand!"
	medical_record_text = "Patient demonstrates negative reactions to their posterior being touched. Said posterior has developed a supernatural level of durability."

/datum/quirk/personalspace/post_add()
	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_personalspace_warning)

/datum/quirk/personalspace/remove()
	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_personalspace_warning)

// Examine text status effect
/datum/status_effect/quirk_personalspace_warning
	id = "quirk_personalspace_warning"
	duration = -1
	alert_type = null

// Set effect examine text
/datum/status_effect/quirk_personalspace_warning/get_examine_text()
	return span_warning("[owner.p_Their()] posterior is remarkably firm!")
