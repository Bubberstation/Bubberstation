/datum/quirk/flimsy
	name = "Flimsy"
	desc = "Your body is a little more fragile then most, decreasing total health by 20%."
	value = -2
	medical_record_text = "Patient has abnormally low capacity for injury."
	gain_text = span_notice("You feel like you could break with a single hit.")
	lose_text = span_notice("You feel more durable.")

/datum/quirk/flimsy/add(client/client_source)
	. = ..()

	quirk_holder.maxHealth *= 0.8

/datum/quirk/flimsy/remove() 
	. = ..()

	if(!quirk_holder)
		return
	quirk_holder.maxHealth *= 1.25
