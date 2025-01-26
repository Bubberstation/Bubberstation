/**
 *	# WITHOUT THIS POWER:
 *
 *	- Mid-Blood: SHOW AS PALE
 *	- Low-Blood: SHOW AS DEAD
 *	- No Heartbeat
 *  - Examine shows actual blood
 *	- Thermal homeostasis (ColdBlooded)
 * 		WITH THIS POWER:
 *	- Normal body temp -- remove Cold Blooded (return on deactivate)
 */

/datum/action/cooldown/bloodsucker/masquerade
	name = "Masquerade"
	desc = "Feign the vital signs of a mortal, and escape both casual and medical notice as the monster you truly are."
	button_icon_state = "power_human"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_STATIC_COOLDOWN|BP_AM_COSTLESS_UNCONSCIOUS
	check_flags = NONE
	bloodsucker_check_flags = BP_CANT_USE_IN_FRENZY
	purchase_flags = BLOODSUCKER_DEFAULT_POWER
	bloodcost = 10
	level_current = -1
	cooldown_time = 5 SECONDS
	constant_bloodcost = 0.1

/datum/action/cooldown/bloodsucker/masquerade/get_power_explanation_extended()
	. = list()
	. += "Masquerade will forge your identity to be practically identical to that of a human."
	. += "- You lose nearly all Bloodsucker benefits, including healing, sleep, radiation, crit, virus, gutting and cold immunity."
	. += "- Your eyes turn to that of a regular human as your heart begins to beat."
	. += "- You gain a Genetic sequence, and appear to have 100% blood when scanned by a Health Analyzer."
	. += "- You will not appear as Pale when examined. Anything further than Pale, however, will not be hidden."
	. += "At the end of a Masquerade, you will re-gain your Vampiric abilities, as well as lose any diseases you might have."

/datum/action/cooldown/bloodsucker/masquerade/ActivatePower(atom/target)
	var/mob/living/carbon/user = owner
	owner.balloon_alert(owner, "masquerade turned on.")
	to_chat(user, span_notice("Your heart beats falsely within your lifeless chest, and your eyes are no longer sensitive to the light. You may yet pass for a mortal."))
	to_chat(user, span_warning("Your vampiric healing is halted while imitating life."))

	// Give status effect
	user.apply_status_effect(/datum/status_effect/masquerade)

	// Handle Traits
	user.remove_traits(bloodsuckerdatum_power.bloodsucker_traits, BLOODSUCKER_TRAIT)

	ADD_TRAIT(user, TRAIT_MASQUERADE, BLOODSUCKER_TRAIT)
	var/obj/item/bodypart/chest/target_chest = user.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest)
		target_chest.bodypart_flags &= ~BODYPART_UNREMOVABLE
	// Handle organs
	var/obj/item/organ/heart/vampheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	if(vampheart)
		vampheart.Restart()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = initial(eyes.flash_protect)
		eyes.color_cutoffs = initial(eyes.color_cutoffs)
		eyes.sight_flags = initial(eyes.sight_flags)
		user.update_sight()
	return TRUE

/// todo, make bloodsuckerification into it's own proc, ie, eyes, traits, and such
/datum/action/cooldown/bloodsucker/masquerade/DeactivatePower(deactivate_flags)
	. = ..() // activate = FALSE
	if(!.)
		return
	var/mob/living/carbon/user = owner
	owner.balloon_alert(owner, "masquerade turned off.")

	// Remove status effect, mutations & diseases that you got while on masq.
	user.remove_status_effect(/datum/status_effect/masquerade)
	for(var/datum/disease/diseases as anything in user.diseases)
		diseases.cure()

	// Handle Traits
	user.add_traits(bloodsuckerdatum_power.bloodsucker_traits, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_MASQUERADE, BLOODSUCKER_TRAIT)
	var/obj/item/bodypart/chest/target_chest = user.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest)
		target_chest.bodypart_flags |= BODYPART_UNREMOVABLE
	// Handle organs
	var/obj/item/organ/heart/vampheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	if(vampheart)
		vampheart.Stop()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = max(initial(eyes.flash_protect) - 1, FLASH_PROTECTION_SENSITIVE)
		eyes.color_cutoffs = BLOODSUCKER_SIGHT_COLOR_CUTOFF
		eyes.sight_flags = SEE_MOBS
		user.update_sight()
	to_chat(user, span_notice("Your heart beats one final time, while your skin dries out and your icy pallor returns."))

/**
 * # Status effect
 *
 * This is what the Masquerade power gives, handles their bonuses and gives them a neat icon to tell them they're on Masquerade.
 */

/datum/status_effect/masquerade
	id = "masquerade"
	duration = STATUS_EFFECT_PERMANENT
	duration = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/masquerade

/atom/movable/screen/alert/status_effect/masquerade
	name = "Masquerade"
	desc = "You are currently hiding your identity using the Masquerade power. This halts Vampiric healing."
	icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	icon_state = "power_human"
	alerttooltipstyle = "cult"

/atom/movable/screen/alert/status_effect/masquerade/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()
