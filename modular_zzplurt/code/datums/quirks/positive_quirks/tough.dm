/datum/quirk/tough
	name = "Tough"
	desc = "Your body is abnormally enduring, granting you 10% more health."
	value = 4
	gain_text = span_notice("You feel very sturdy.")
	lose_text = span_notice("You feel less sturdy.")
	medical_record_text = "Patient has an abnormally high capacity for injury."
	mob_trait = TRAIT_TOUGH
	hardcore_value = -2
	icon = FA_ICON_SHIELD_HEART

/datum/quirk/tough/add(client/client_source)
	quirk_holder.maxHealth *= 1.1

/datum/quirk/tough/remove()
	if(!quirk_holder)
		return
	quirk_holder.maxHealth *= 0.909 //close enough



