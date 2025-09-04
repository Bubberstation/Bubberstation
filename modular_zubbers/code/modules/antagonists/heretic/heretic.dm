/datum/objective/minor_sacrifice/New(text)
	. = ..()
	target_amount = rand(4, 5) // Essentially +1 from the amount /tg/ has. Can be edited later if needed.
	update_explanation_text()

/datum/heretic_knowledge/hunt_and_sacrifice/proc/check_sacrifice_total(mob/living/user, datum/antagonist/heretic/heretic_datum)
	var/datum/objective/minor_sacrifice/sac_objective = locate() in heretic_datum.objectives
	if(heretic_datum.total_sacrifices == (sac_objective.target_amount - 1))
		priority_announce(
			text = "High levels of eldri[generate_heretic_text()] energy detected - Threat levels elevated stop [generate_heretic_text(4)][user][generate_heretic_text(4)] at all costs. station loss imminent!",
			title = generate_heretic_text(),
			sound = "sound/music/antag/bloodcult/bloodcult_halos.ogg",
			color_override = "purple",
		)

		// If they reach this stage, also reroll their targets, just in case they're attempting to double-sac to avoid the announcement.
		to_chat(user, span_hypnophrase("Your heart beats with your new targets, the end draws near. A final chase will assure your ascension."))
		user.balloon_alert(user, "targets rerolled!")

		for(var/mob/living/carbon/human/target as anything in heretic_datum.sac_targets)
			heretic_datum.remove_sacrifice_target(target)

		var/datum/heretic_knowledge/hunt_and_sacrifice/target_finder = heretic_datum.get_knowledge(/datum/heretic_knowledge/hunt_and_sacrifice)
		if(!target_finder)
			CRASH("Heretic datum didn't have a hunt_and_sacrifice knowledge learned, what?")

		if(!target_finder.obtain_targets(user, heretic_datum = heretic_datum))
			user.balloon_alert(user, "reroll failed, no targets found!")
			return FALSE
