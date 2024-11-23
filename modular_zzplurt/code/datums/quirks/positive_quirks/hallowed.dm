/datum/quirk/hallowed
	name = "Hallowed"
	desc = "You have been blessed by a higher power, or otherwise become a deacon imbued with holy energy. Your divine presence gives you the power of a chaplain, and drives away unholy magics!"
	value = 6 // Maybe up the cost if more is added later.
	gain_text = span_notice("You feel holy energy radiating through your body.")
	lose_text = span_notice("You feel your holy energy fading away...")
	medical_record_text = "Patient is under the influence of an unidentified hallowed blessing. Please consult a chaplain."
	mob_trait = TRAIT_HALLOWED
	hardcore_value = -4
	icon = FA_ICON_CHURCH
	mail_goodies = list (
		/obj/item/reagent_containers/cup/glass/bottle/holywater = 1
	)

/datum/quirk/hallowed/add(client/client_source)
	// Give the holy trait.
	ADD_TRAIT(quirk_holder, TRAIT_HOLY, TRAIT_HALLOWED)

	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/hallowed)

	// Register holy water interactions
	RegisterSignal(quirk_holder, COMSIG_REAGENT_METABOLIZE_HOLYWATER, PROC_REF(metabolize_holywater))
	RegisterSignal(quirk_holder, COMSIG_REAGENT_PROCESS_HOLYWATER, PROC_REF(process_holywater))

/datum/quirk/hallowed/post_add()
	// Makes the user holy.
	quirk_holder.mind?.holy_role = HOLY_ROLE_DEACON

/datum/quirk/hallowed/remove()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove the holy trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_HOLY, TRAIT_HALLOWED)

	// Check if the holder is a deacon
	if(quirk_holder.mind?.holy_role == HOLY_ROLE_DEACON)
		// Revoke the holder's deacon status
		quirk_mob.mind?.holy_role = NONE

	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/hallowed)

	// Unregister holy water interactions
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_METABOLIZE_HOLYWATER)
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_PROCESS_HOLYWATER)

/// Handle effects applied by metabolizing Holy Water
/datum/quirk/hallowed/proc/metabolize_holywater()
	SIGNAL_HANDLER

	// Alert user of holy water effect.
	to_chat(quirk_holder, span_nicegreen("The holy water nourishes you!"))

	// Add positive mood.
	quirk_holder.add_mood_event("fav_food", /datum/mood_event/favorite_food)

/// Handle effects applied by consuming Holy Water
/datum/quirk/hallowed/proc/process_holywater()
	SIGNAL_HANDLER

	// Reduce disgust, hunger, and thirst
	// These effects should be a foil to bloodfledge penalties
	quirk_holder.adjust_disgust(-2)
	quirk_holder.adjust_nutrition(6)
	//quirk_holder.adjust_thirst(6)

// Examine text status effect
/datum/status_effect/quirk_examine/hallowed
	id = QUIRK_EXAMINE_HALLOWED

// Set effect examine text
/datum/status_effect/quirk_examine/hallowed/get_examine_text()
	return span_notice("[owner.p_They()] radiate[owner.p_s()] divine power.")

