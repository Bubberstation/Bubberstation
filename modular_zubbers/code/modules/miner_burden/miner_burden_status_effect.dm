//The status effect itself.
/datum/status_effect/stacking/mining_burden
	id = "mining_burden"
	alert_type = /atom/movable/screen/alert/status_effect/mining_burden

	tick_interval = -1 //Tells it not to remove stacks over time
	consumed_on_threshold = FALSE

	stacks = 0
	max_stacks = 6

/datum/status_effect/stacking/mining_burden/refresh()
	. = ..()
	if(stacks == 3)
		to_chat(owner, span_warning("Your collection of artifacts seems to be draining on you..."))
	else if(stacks == 2)
		to_chat(owner, span_notice("You have kept your collection artifacts under control, for now."))

/datum/status_effect/stacking/mining_burden/on_remove()
	. = ..()
	to_chat(owner, span_warning("You no longer feel burdened by your spoils."))


/datum/status_effect/stacking/nextmove_modifier()
	// https://www.desmos.com/calculator/e0731zv5nu
	return stacks <= 2 ? 1 : 1 + 0.05*(x-1)*(x-2)

/atom/movable/screen/alert/status_effect/mining_burden
	name = "Burden of the Necropolis"
	desc = "Carrying too many Necropolis artifacts may Burden you. You are currently burdened by %PERCENT% with the strength of %STACKS% artifacts."
