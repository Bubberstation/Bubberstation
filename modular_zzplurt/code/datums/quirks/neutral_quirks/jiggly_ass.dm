/datum/quirk/jiggly_ass
	name = "Buns of Thunder"
	desc = "That pants-stretching, seat-creaking, undie-devouring butt of yours is as satisfying as it is difficult to keep balanced when smacked!"
	value = 0
	mob_trait = TRAIT_JIGGLY_ASS
	gain_text = span_notice("Your butt feels extremely smackable.")
	lose_text = span_notice("Your butt feels normally smackable again.")
	COOLDOWN_DECLARE(wiggle_cooldown)

/datum/quirk/jiggly_ass/add()
	// Add examine text
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine_holder))

/datum/quirk/jiggly_ass/remove()
	// Remove examine text
	UnregisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE)

// Quirk examine text
/datum/quirk/jiggly_ass/proc/on_examine_holder(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	examine_list += span_purple("[quirk_holder.p_their(TRUE)] butt could use a firm smack.")


/datum/mood_event/butt_slap
	description = span_userlove("Smacking that butt felt extremely satisfying!\n")
	mood_change = 3
	timeout = 2 MINUTES

/datum/mood_event/butt_slapped
	description = span_userlove("My jiggly butt was finally smacked, so satisfying!\n")
	mood_change = 3
	timeout = 2 MINUTES
