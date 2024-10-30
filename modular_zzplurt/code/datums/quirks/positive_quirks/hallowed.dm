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
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Give the holy trait.
	ADD_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Makes the user holy.
	quirk_mob.mind.holy_role = HOLY_ROLE_DEACON

	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_hallowed)

/datum/quirk/hallowed/remove()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove the holy trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Makes the user not holy.
	quirk_mob.mind.holy_role = NONE

	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_hallowed)

// Examine text status effect
/datum/status_effect/quirk_hallowed
	id = "quirk_hallowed"
	duration = -1
	alert_type = null

// Set effect examine text
/datum/status_effect/quirk_hallowed/get_examine_text()
	return span_notice("[owner.p_They()] radiate[owner.p_s()] divine power.")

