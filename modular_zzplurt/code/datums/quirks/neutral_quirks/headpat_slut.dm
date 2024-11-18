/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You love the feeling of others touching your head! Maybe a little too much. Others patting your head will provide a stronger mood boost, along with other sensual reactions."
	value = 0
	gain_text = span_purple("You long for the wonderful sensation of head pats!")
	lose_text = span_purple("Being pat on the head doesn't feel special anymore.")
	medical_record_text = "Patient seems abnormally responsive to being touched on the head."
	mob_trait = TRAIT_HEADPAT_SLUT
	icon = FA_ICON_HAND_HOLDING_HEART
	erp_quirk = TRUE

/datum/quirk/headpat_slut/add(client/client_source)
	// Add examine text status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/headpat_slut)

/datum/quirk/headpat_slut/remove()
	// Remove examine text status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/headpat_slut)

// Examine text status effect
/datum/status_effect/quirk_examine/headpat_slut
	id = QUIRK_EXAMINE_HEADPAT_SLUT

// Set effect examine text
/datum/status_effect/quirk_examine/headpat_slut/get_examine_text()
	return span_purple("[owner.p_Their()] head could use a good patting.")

// Base mood event
// Based on 'betterhug' mood event
/datum/mood_event/headpat_slut
	description = span_danger("I have an invalid mood event. I should report this.")
	mood_change = 3
	timeout = 4 MINUTES

// Mood for recipient
/datum/mood_event/headpat_slut/recipient
	description = span_purple("I enjoyed receiving head pats.")

/datum/mood_event/headpat_slut/recipient/add_effects(mob/giver)
	// Check for valid giver
	if(!giver)
		return

	// Set dynamic text
	description = span_purple("[giver.name] gives great head pats!")

// Mood for giver
/datum/mood_event/headpat_slut/giver
	description = span_purple("I enjoyed patting that person on the head.")

/datum/mood_event/headpat_slut/giver/add_effects(mob/recipient)
	// Check for valid recipient
	if(!recipient)
		return

	// Set dynamic text
	description = span_purple("[recipient.name] was overjoyed by my touch!")
