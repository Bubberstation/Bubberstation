/datum/objective/minor_sacrifice/New(text)
	. = ..()
	target_amount = rand(6, 8)
	update_explanation_text()
