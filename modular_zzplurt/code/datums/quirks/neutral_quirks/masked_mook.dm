/datum/quirk/masked_mook
	name = "Bane Syndrome"
	desc = "You don't feel right without wearing some kind of gas mask."
	value = 0
	quirk_flags = QUIRK_MOODLET_BASED
	gain_text = span_danger("You start feeling the need to keep a gas mask on.")
	lose_text = span_notice("You no longer feel the need to wear a gas mask.")
	medical_record_text = "Patient feels a strong psychological attachment to gas masks."
	mob_trait = TRAIT_MASKED_MOOK
	hardcore_value = 1
	icon = FA_ICON_MASK_VENTILATOR
	mail_goodies = list (
		/obj/item/gas_filter = 1
	)
	var/is_masked

/datum/quirk/masked_mook/add(client/client_source)
	// Register signal handlers
	// Equip and unequip check for wearing the mask
	// Stat change checks if the mask is adjusted
	RegisterSignals(quirk_holder, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM), PROC_REF(check_outfit))

/datum/quirk/masked_mook/post_add()
	// Evaluate outfit
	check_outfit()

/datum/quirk/masked_mook/proc/check_outfit()
	SIGNAL_HANDLER

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Define possible gas mask
	var/obj/item/clothing/mask/gas/gasmask = quirk_mob.get_item_by_slot(ITEM_SLOT_MASK)

	// Check if wearing valid mask
	if(quirk_mob.wear_mask && istype(gasmask))
		// Send positive mood event
		quirk_mob.add_mood_event(QMOOD_MASKED_MOOK, /datum/mood_event/masked_mook/positive)

		// Remove old status effect
		quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/masked_mook)

		// Apply positive status effect
		quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/masked_mook/positive)

		// Check if already set
		if(is_masked)
			return

		// Alert user in chat
		to_chat(quirk_mob, span_nicegreen("The mask makes you feel more complete."))

		// Set mask status
		is_masked = TRUE

	// Target is not wearing a gas mask
	else
		// Send negative mood event
		quirk_mob.add_mood_event(QMOOD_MASKED_MOOK, /datum/mood_event/masked_mook/negative)

		// Remove old status effect
		quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/masked_mook)

		// Apply negative status effect
		quirk_holder.apply_status_effect(/datum/status_effect/quirk_examine/masked_mook/negative)

		// Check if already set
		if(!is_masked)
			return

		// Alert user in chat
		to_chat(quirk_mob, span_warning("You start feeling incomplete without your mask..."))

		// Set mask status
		is_masked = FALSE

/datum/quirk/masked_mook/remove()
	. = ..()

	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_examine/masked_mook)

	// Remove mood event
	quirk_holder.clear_mood_event(QMOOD_MASKED_MOOK)

	// Unregister signals
	UnregisterSignal(quirk_holder, list(
		COMSIG_MOB_EQUIPPED_ITEM,
		COMSIG_MOB_UNEQUIPPED_ITEM
		)
	)

// Item granter removed
// Please use the loadout system

// Equal to having heirloom
/datum/mood_event/masked_mook/positive
	description = span_nicegreen("I feel more complete with a gas mask on.")
	mood_change = 1

// Equal to losing heirloom
/datum/mood_event/masked_mook/negative
	description = span_warning("I feel incomplete without a gas mask...")
	mood_change = -4

// Examine text status effect
/datum/status_effect/quirk_examine/masked_mook
	id = QUIRK_EXAMINE_MASKED_MOOK

// Set effect examine text - Positive
/datum/status_effect/quirk_examine/masked_mook/positive/get_examine_text()
	return span_notice("[owner.p_They()] wear[owner.p_s()] [owner.p_their()] mask with a particular finesse.")

// Set effect examine text - Negative
/datum/status_effect/quirk_examine/masked_mook/negative/get_examine_text()
	return span_warning("[owner.p_They()] seem[owner.p_s()] uncomfortable with [owner.p_their()] unprotected face.")
