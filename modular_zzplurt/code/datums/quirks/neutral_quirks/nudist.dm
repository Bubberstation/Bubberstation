/datum/quirk/nudist
	name = "Nudist"
	desc = "Wearing any clothing that covers your torso unnerves you. Bring a gear harness!"
	value = 0
	quirk_flags = QUIRK_MOODLET_BASED
	gain_text = span_danger("You feel spiritually connected to your natural form.")
	lose_text = span_notice("It feels like clothing could fit you comfortably.")
	medical_record_text = "Patient expresses a psychological need to remain unclothed."
	mob_trait = TRAIT_NUDIST
	icon = FA_ICON_LEAF
	mail_goodies = list (
		// /datum/reagent/consumable/ethanol/panty_dropper = 1 // Not yet implemented
	)
	var/is_nude

/datum/quirk/nudist/add(client/client_source)
	// Register signal handlers
	RegisterSignals(quirk_holder, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM), PROC_REF(check_outfit))

/datum/quirk/nudist/remove()
	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/nudist)

	// Unregister signals
	UnregisterSignal(quirk_holder, list(
		COMSIG_MOB_EQUIPPED_ITEM,
		COMSIG_MOB_UNEQUIPPED_ITEM
		)
	)

/datum/quirk/nudist/post_add()
	// Evaluate outfit
	check_outfit()

/* Replaced by NIFSoft!
/datum/quirk/nudist/add_unique(client/client_source)
	. = ..()

	// Spawn a Rapid Disrobe Implant
	var/obj/item/implant/disrobe/quirk_implant = new

	// Implant into quirk holder
	quirk_implant.implant(quirk_holder, null, TRUE, TRUE)
*/

/datum/quirk/nudist/proc/check_outfit()
	SIGNAL_HANDLER

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check if torso is uncovered
	if(quirk_mob.is_body_part_exposed(GROIN|CHEST))
		// Send positive mood event
		quirk_mob.add_mood_event(QMOOD_NUDIST, /datum/mood_event/nudist_positive)

		// Remove old status effect
		quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/nudist)

		// Apply positive status effect
		quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/nudist/positive)

		// Check if already set
		if(is_nude)
			return

		// Alert user in chat
		to_chat(quirk_mob, span_nicegreen("You begin to feel better without the restraint of clothing!"))

		// Set nude status
		is_nude = TRUE

	// Torso is covered
	else
		// Send negative mood event
		quirk_mob.add_mood_event(QMOOD_NUDIST, /datum/mood_event/nudist_negative)

		// Remove old status effect
		quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/nudist)

		// Apply negative status effect
		quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/nudist/negative)

		// Check if already set
		if(!is_nude)
			return

		// Alert user in chat
		to_chat(quirk_mob, span_warning("The clothes feel wrong on your body..."))

		// Set nude status
		is_nude = FALSE

// Equal to having heirloom
/datum/mood_event/nudist_positive
	description = span_nicegreen("I'm delighted to not be constricted by clothing.")
	mood_change = 1

// Equal to losing heirloom
/datum/mood_event/nudist_negative
	description = span_warning("I don't feel comfortable wearing this.")
	mood_change = -4

// Examine text status effect
/datum/status_effect/quirk_examine/nudist
	id = QUIRK_EXAMINE_NUDIST

// Set effect examine text - Positive
/datum/status_effect/quirk_examine/nudist/positive/get_examine_text()
	return span_notice("[owner.p_They()] appear[owner.p_s()] content with [owner.p_their()] lack of clothing.")

// Set effect examine text - Negative
/datum/status_effect/quirk_examine/nudist/negative/get_examine_text()
	return span_warning("[owner.p_They()] appear[owner.p_s()] disturbed by wearing clothing.")
