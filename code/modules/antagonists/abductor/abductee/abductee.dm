/**
 * ## Abductees
 *
 * Abductees are created by being operated on by abductors. They get some instructions about not
 * remembering the abduction, plus some random weird objectives for them to act crazy with.
 */
/datum/antagonist/abductee
	name = "\improper Abductee"
	stinger_sound = 'sound/music/antag/abductee.ogg'
	roundend_category = "abductees"
	antagpanel_category = ANTAG_GROUP_ABDUCTORS
	antag_hud_name = "abductee"

/datum/antagonist/abductee/on_gain()
	give_objective()
	. = ..()

/datum/antagonist/abductee/greet()
	to_chat(owner, span_warning("<b>Your mind snaps!</b>"))
	to_chat(owner, "<big>[span_warning("<b>You can't remember how you got here...</b>")]</big>")
	owner.announce_objectives()
	play_stinger()

/datum/antagonist/abductee/proc/give_objective()

	// Give the base objective
	var/datum/objective/abductee/base_objective = new()
	base_objective.owner = owner

	switch(rand(1,10))
		if(6 to 10)
			new_objective = new /datum/objective/abductee/fearful()
		if(3 to 5)
			new_objective = new /datum/objective/abductee/violent()
		if(1 to 2)
			new_objective = new /datum/objective/abductee/paranoid()

	new_objective.owner = owner
	objectives += new_objective
	log_objective(H, new_objective.explanation_text)
