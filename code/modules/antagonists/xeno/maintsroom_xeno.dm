/datum/antagonist/beno
	name = "\improper Xenomorph"
	pref_flag = ROLE_ALIEN
	show_in_antagpanel = FALSE
	antagpanel_category = ANTAG_GROUP_XENOS
	show_to_ghosts = TRUE

/datum/antagonist/beno/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/beno/forge_objectives()
	var/datum/objective/maints_benos/objective = new
	objective.owner = owner
	objectives += objective

/datum/objective/maints_benos

/datum/objective/maints_benos/New()
	explanation_text = "Survive, escape your cell, you remember nothing of time before you came here youve been here for god knows how long- a decade? a century? this place has changed you be it the time the environment of the bioscramblers you are not what you once were."
