/datum/objective/minor_sacrifice/New(text)
	. = ..()
	target_amount = rand(5, 6) // Essentially +1 from the amount /tg/ has. Can be edited later if needed.
	update_explanation_text()
