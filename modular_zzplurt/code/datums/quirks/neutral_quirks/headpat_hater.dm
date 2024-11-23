// REMOVED QUIRK - This is now redundant with Bad Touch!
/*
/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for having your head touched. Others doing so won't make you wag your tail should you possess one, and the action may even attract your ire."
	value = -1
	gain_text = span_danger("Others' touches begin to make your blood boil.")
	lose_text = span_notice("Having your head pet doesn't sound so bad anymore.")
	medical_record_text = "Patient cares little with or dislikes having their head touched."
	mob_trait = TRAIT_DISTANT
	icon = FA_ICON_HAND
	hidden_quirk = TRUE

/datum/quirk/headpat_hater/add(client/client_source)
	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/quirk_headpat_hater)

/datum/quirk/headpat_hater/remove()
	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/quirk_headpat_hater)

// Examine text status effect
/datum/status_effect/quirk_headpat_hater
	id = "headpat_hater"
	duration = -1
	alert_type = null

// Set effect examine text
/datum/status_effect/quirk_headpat_hater/get_examine_text()
	return span_warning("[owner.p_They()] look[owner.p_s()] like someone you shouldn't pat.")
*/

// Copy pasted from old code
/*
/datum/quirk/headpat_hater/add()

	var/mob/living/carbon/human/quirk_mob = quirk_holder

	var/datum/action/cooldown/toggle_distant/act_toggle = new
	act_toggle.Grant(quirk_mob)

/datum/quirk/headpat_hater/remove()

	var/mob/living/carbon/human/quirk_mob = quirk_holder

	var/datum/action/cooldown/toggle_distant/act_toggle = locate() in quirk_mob.actions
	if(act_toggle)
		act_toggle.Remove(quirk_mob)
*/
