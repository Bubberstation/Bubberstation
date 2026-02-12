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
	// BUBBER EDIT START: OLD PROC IS JUST THE 3 LINES
	// var/objtype = (prob(75) ? /datum/objective/abductee/random : pick(subtypesof(/datum/objective/abductee/) - /datum/objective/abductee/random))
	// var/datum/objective/abductee/objective = new objtype()
	// objectives += objective
	var/datum/objective/abductee/base_objective = new()
	base_objective.owner = owner

	switch(rand(1, 10))
		if(7 to 10)
			base_objective = new /datum/objective/abductee/fearful()
		if(4 to 6)
			base_objective = new /datum/objective/abductee/violent()
		if(1 to 3)
			base_objective = new /datum/objective/abductee/paranoid()

	objectives += base_objective
		// BUBBER EDIT END
