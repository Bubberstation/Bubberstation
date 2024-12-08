/// Used by Ghouls
/datum/action/cooldown/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some of your own blood and effort."
	button_icon_state = "power_recup"
	power_explanation = "Recuperate:\n\
		Activating this Power will begin to heal your wounds.\n\
		You will heal Brute and Toxin damage, at the cost of Stamina damage, and blood from both you and your Master.\n\
		If you aren't a bloodless race, you will additionally heal Burn damage.\n\
		The power will cancel out if you are dead or unconcious."
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	bloodsucker_check_flags = NONE
	purchase_flags = NONE
	bloodcost = 1.5
	cooldown_time = 10 SECONDS
	level_current = -1

/datum/action/cooldown/bloodsucker/recuperate/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return
	if(user.stat >= DEAD || user.incapacitated)
		user.balloon_alert(user, "you are incapacitated...")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/ActivatePower(trigger_flags)
	. = ..()
	to_chat(owner, span_notice("Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds."))
	owner.balloon_alert(owner, "recuperate turned on.")
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/process(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(!active)
		return
	var/mob/living/carbon/user = owner
	var/datum/antagonist/ghoul/ghouldatum = IS_GHOUL(user)
	if(!ghouldatum || QDELETED(ghouldatum.master))
		to_chat(owner, span_warning("No master to draw blood from!"))
		DeactivatePower()
		return
	ghouldatum.master.AdjustBloodVolume(-1)
	user.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	user.adjustStaminaLoss(bloodcost * 1.1)
	user.adjustBruteLoss(-2.5, updating_health = FALSE)
	user.adjustToxLoss(-2, forced = TRUE, updating_health = FALSE)
	// Plasmamen won't lose blood, they don't have any, so they don't heal from Burn.
	if(!HAS_TRAIT(user, TRAIT_NOBLOOD))
		user.blood_volume -= bloodcost
		user.adjustFireLoss(-1.5, updating_health = FALSE)
	user.updatehealth()
	// Stop Bleeding
	if(istype(user) && user.is_bleeding())
		for(var/obj/item/bodypart/part in user.bodyparts)
			part.generic_bleedstacks--

/datum/action/cooldown/bloodsucker/recuperate/ContinueActive(mob/living/user, mob/living/target)
	if(user.stat >= DEAD)
		return FALSE
	if(INCAPACITATED_IGNORING(user, INCAPABLE_GRAB|INCAPABLE_RESTRAINTS))
		owner?.balloon_alert(owner, "too exhausted...")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	owner.balloon_alert(owner, "recuperate turned off.")
	return ..()
