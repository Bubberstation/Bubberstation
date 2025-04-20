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

