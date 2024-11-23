// REMOVED QUIRK - Disabled in favor of new NIFSoft method
/datum/quirk/storage_concealment
	name = "Dorsualiphobic Augmentation"
	desc = "You despise the idea of being seen wearing any type of back-mounted storage apparatus! A new technology shields you from the immense shame you may experience, by hiding your equipped backpack."
	value = 0
	gain_text = span_notice("Your Chameleon Storage Concealment Implant has been activated.")
	lose_text = span_notice("Your Chameleon Storage Concealment Implant encounters a critical error.")
	medical_record_text = "Patient has exhibited concerns about being seen wearing a backpack."
	icon = FA_ICON_BRIEFCASE
	hidden_quirk = TRUE

	// UNUSED: Enable by setting these values to TRUE
	// The shame is unbearable
	//quirk_flags = /datum/quirk::quirk_flags | QUIRK_MOODLET_BASED | QUIRK_PROCESSES

/datum/quirk/storage_concealment/add_unique(client/client_source)
	// Create a new augment item
	var/obj/item/implant/hide_backpack/put_in = new

	// Apply the augment to the quirk holder
	put_in.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/storage_concealment/process(seconds_per_tick)
	// This trait should only be applied by the augment
	// Check the quirk holder for the trait
	if(HAS_TRAIT(quirk_holder, TRAIT_HIDE_BACKPACK))
		// When found: Mood bonus
		quirk_holder.add_mood_event(QMOOD_HIDE_BAG, /datum/mood_event/dorsualiphobic_mood_positive)
	else
		// When not found: Mood penalty
		quirk_holder.add_mood_event(QMOOD_HIDE_BAG, /datum/mood_event/dorsualiphobic_mood_negative)

// Equal to having heirloom
/datum/mood_event/dorsualiphobic_mood_positive
	description = span_nicegreen("Nobody will know if I'm wearing a backpack or not.")
	mood_change = 1

// Equal to losing heirloom
/datum/mood_event/dorsualiphobic_mood_negative
	description = span_warning("I can't let anyone find out if I'm wearing a backpack or not!")
	mood_change = -4
