/datum/objective/drain_influences
	name = "drain influences"

/datum/objective/drain_influences/New(text)
	. = ..()
	target_amount = rand(8, 9)
	update_explanation_text()

/datum/objective/drain_influences/update_explanation_text()
	. = ..()
	explanation_text = "Drain at least [target_amount] influences."

/datum/objective/drain_influences/check_completion()
	. = ..()
	var/datum/antagonist/heretic/heretic_datum = owner?.has_antag_datum(/datum/antagonist/heretic)
	if(!heretic_datum)
		return FALSE
	return completed || heretic_datum.met_drained_num
