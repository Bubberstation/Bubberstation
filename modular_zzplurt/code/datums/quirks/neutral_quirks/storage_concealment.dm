/datum/quirk/storage_concealment
	name = "Dorsualiphobic Augmentation"
	desc = "You despise the idea of being seen wearing any type of back-mounted storage apparatus! A new technology shields you from the immense shame you may experience, by hiding your equipped backpack."

	// UNUSED: Enable by setting these values to TRUE
	// The shame is unbearable
	//quirk_flags = /datum/quirk::quirk_flags | QUIRK_MOODLET_BASED | QUIRK_PROCESSES

/datum/quirk/storage_concealment/add_unique(client/client_source)
	. = ..()

	// Create a new augment item
	var/obj/item/implant/hide_backpack/put_in = new

	// Apply the augment to the quirk holder
	put_in.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/storage_concealment/process(seconds_per_tick)
	. = ..()
	// This trait should only be applied by the augment
	// Check the quirk holder for the trait
	if(HAS_TRAIT(quirk_holder, TRAIT_HIDE_BACKPACK))
		// When found: Mood bonus
		quirk_holder.add_mood_event(QMOOD_HIDE_BAG, /datum/mood_event/dorsualiphobic_mood_positive)
	else
		// When not found: Mood penalty
		quirk_holder.add_mood_event(QMOOD_HIDE_BAG, /datum/mood_event/dorsualiphobic_mood_negative)

/datum/mood_event/dorsualiphobic_mood_positive
	description = span_nicegreen("Nobody will know if I'm wearing a backpack or not.\n")
	mood_change = 1

/datum/mood_event/dorsualiphobic_mood_negative
	description = span_warning("I can't let anyone find out if I'm wearing a backpack or not!\n")
	mood_change = -4
