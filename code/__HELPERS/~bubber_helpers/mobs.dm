/// Priority AI connections. Malf > AI cores
/proc/select_priority_ai()
	var/mob/living/silicon/ai/selected
	var/list/active = active_ais(FALSE, priority = TRUE)
	selected = pick(active) // Get the top of the list

	return selected
