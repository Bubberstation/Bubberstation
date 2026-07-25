/// Priority AI connections. Malf > AI cores
/proc/select_priority_ai()
	var/mob/living/silicon/ai/selected
	var/list/active = active_ais(FALSE, priority = TRUE)
	selected = active.len ? pick(active) : null

	return selected
