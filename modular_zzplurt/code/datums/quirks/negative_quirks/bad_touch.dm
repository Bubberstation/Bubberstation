// Edit to update description
/datum/quirk/bad_touch
	desc = "You don't like physical affection, and have a slight chance of retaliating against others who attempt it."
	value = 0

// Examine text status effect
/datum/status_effect/quirk_bad_touch_warning
	id = "quirk_bad_touch_warning"
	duration = -1
	alert_type = null

// Set effect examine text
/datum/status_effect/quirk_bad_touch_warning/get_examine_text()
	return span_warning("[owner.p_They()] look[owner.p_s()] like someone who doesn't enjoy physical affection.")
