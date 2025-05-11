/datum/quirk/unblinking
	name = "Unblinking"
	desc = "For whatever reason, you do not need to blink to keep your eyes (or equivalent visual apparatus) functional."
	icon = FA_ICON_EYE
	value = 0
	gain_text = span_danger("You no longer feel the need to blink.")
	lose_text = span_notice("You feel the need to blink again.")
	medical_record_text = "Patient is incapable of blinking."
	mob_trait = TRAIT_NO_EYELIDS //Also prevents eye shutting in knockout state and death.

/datum/quirk/unblinking/add_unique(client/client_source)
	. = ..()
	var/obj/item/organ/eyes/eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return

	eyes.blink_animation = FALSE

	if(eyes.eyelid_left)
		QDEL_NULL(eyes.eyelid_left)
	if(eyes.eyelid_right)
		QDEL_NULL(eyes.eyelid_right)
