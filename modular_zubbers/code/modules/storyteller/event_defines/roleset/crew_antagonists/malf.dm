
/datum/round_event_control/antagonist/solo/malf
	name = "Malfunctioning AI"
	roundstart = TRUE

	antag_flag = ROLE_MALF
	antag_datum = /datum/antagonist/malf_ai
	weight = 0
	tags = list(TAG_CREW_ANTAG, TAG_COMBAT, TAG_DESTRUCTIVE)
	restricted_roles = list()

/datum/round_event_control/antagonist/solo/malf/midround
	name = "Malfunctioning AI Midround"
	prompted_picking = TRUE
	roundstart = FALSE
	weight = 0


/* /datum/round_event_control/antagonist/solo/malf/get_candidates()
	. = ..()
	if(!.)
		return
	var/loop = .
	var/list/ai_in_round
	for(var/mob/living/silicon/ai/ai in loop)
		if(!isAI(ai))
			continue
		ai_in_round |= ai

	. = pick(ai_in_round)
 */
