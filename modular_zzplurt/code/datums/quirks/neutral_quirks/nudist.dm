/datum/quirk/nudist
	name = "Nudist"
	desc = "Wearing most types of clothing unnerves you. Bring a gear harness!"
	gain_text = span_notice("You feel spiritually connected to your natural form.")
	lose_text = span_notice("It feels like clothing could fit you comfortably.")
	medical_record_text = "Patient expresses a psychological need to remain unclothed."
	value = 0
	quirk_flags = /datum/quirk::quirk_flags | QUIRK_MOODLET_BASED
	var/is_nude

/datum/quirk/nudist/add(client/client_source)
	. = ..()

	// Register signal handlers
	RegisterSignals(quirk_holder, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM), PROC_REF(check_outfit))
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(quirk_examine_nudist))

/datum/quirk/nudist/remove()
	. = ..()

	// Remove mood event
	quirk_holder.clear_mood_event(QMOOD_NUDIST)

	// Unregister signals
	UnregisterSignal(quirk_holder, list(
		COMSIG_MOB_EQUIPPED_ITEM,
		COMSIG_MOB_UNEQUIPPED_ITEM,
		COMSIG_ATOM_EXAMINE
		)
	)

/datum/quirk/nudist/post_add()
	. = ..()

	// Evaluate outfit
	check_outfit()

/datum/quirk/nudist/add_unique(client/client_source)
	. = ..()

	// Spawn a Rapid Disrobe Implant
	var/obj/item/implant/disrobe/quirk_implant = new

	// Implant into quirk holder
	quirk_implant.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/nudist/proc/check_outfit()
	SIGNAL_HANDLER

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check if torso is uncovered
	if(quirk_mob.is_body_part_exposed(GROIN|CHEST))
		// Send positive mood event
		quirk_mob.add_mood_event(QMOOD_NUDIST, /datum/mood_event/nudist_positive)

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

		// Check if already set
		if(!is_nude)
			return

		// Alert user in chat
		to_chat(quirk_mob, span_warning("The clothes feel wrong on your body..."))

		// Set nude status
		is_nude = FALSE

/datum/quirk/nudist/proc/quirk_examine_nudist(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	SIGNAL_HANDLER

	// Define default status term
	var/mood_term = "content with [quirk_holder.p_their()] lack of"

	// Define default span class
	var/span_class

	// Check if dressed
	if(!is_nude)
		// Set negative term
		mood_term = "disturbed by wearing"

		// Set negative span class
		span_class = "warning"

	// Add examine text
	examine_list += "<span class='[span_class]'>[quirk_holder.p_they(TRUE)] appear[quirk_holder.p_s()] [mood_term] clothing.</span>"

/datum/mood_event/nudist_positive
	description = span_nicegreen("I'm delighted to not be constricted by clothing.\n")
	mood_change = 1

/datum/mood_event/nudist_negative
	description = span_warning("I don't feel comfortable wearing this.\n")
	mood_change = -4
