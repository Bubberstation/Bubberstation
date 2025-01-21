
/datum/action/cooldown/bloodsucker/targeted/lunge
	name = "Predatory Lunge"
	desc = "Spring at your target to grapple them without warning, or tear the dead's heart out. Attacks from concealment or the rear may even knock them down if strong enough."
	button_icon_state = "power_lunge"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	cooldown_time = 10 SECONDS
	power_activates_immediately = FALSE
	unset_after_click = FALSE
	var/datum/component/tackler/tackling

/datum/action/cooldown/bloodsucker/targeted/lunge/get_power_explanation_extended()
	. = list()
	. += "Click any player to start spinning wildly and, after a short delay, dash at them."
	. += "When lunging at someone, you will grab them, immediately starting off at aggressive."
	. += "Riot gear and Monster Hunters are protected and will only be passively grabbed."
	. += "You cannot use the Power if you are already grabbing someone, or are being grabbed."
	. += "If you grab from behind, or while using cloak of darkness, you will knock the target down."
	. += "If used on a dead body, will tear out a random organ from the zone you are targeting."
	. += "Higher levels increase how long enemies are knocked down."

/datum/action/cooldown/bloodsucker/targeted/lunge/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	// Are we being grabbed?
	if(user.pulledby && user.pulledby.grab_state >= GRAB_AGGRESSIVE)
		owner.balloon_alert(user, "grabbed!")
		return FALSE
	if(user.pulling)
		owner.balloon_alert(user, "grabbing someone!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/lunge/can_deactivate()
	return !(datum_flags & DF_ISPROCESSING) //only if you aren't lunging

/datum/action/cooldown/bloodsucker/targeted/lunge/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	QDEL_NULL(tackling)
	UnregisterSignal(owner, COMSIG_MOVABLE_THROW_LANDED)

/datum/action/cooldown/bloodsucker/targeted/lunge/proc/get_skill_mod()
	return level_current

// /datum/action/cooldown/bloodsucker/lunge/proc/DelayedDeactivatePower()
// 	addtimer(CALLBACK(src, PROC_REF(DeactivatePower)), 1 SECONDS, TIMER_UNIQUE)

/datum/action/cooldown/bloodsucker/targeted/lunge/FireTargetedPower(atom/target, params)
	. = ..()
	var/skill_mod = min(get_skill_mod(), 7)
	var/knockdown = 1 SECONDS * level_current
	tackling = owner.AddComponent(/datum/component/tackler, stamina_cost = 50, base_knockdown = knockdown, range = 4, speed = 0.5, skill_mod = skill_mod, min_distance = 2)
	RegisterSignal(owner, COMSIG_MOVABLE_THROW_LANDED, PROC_REF(lunge_end))
	// something bork
	var/mob/living/user = owner
	if(user.body_position != STANDING_UP || user.incapacitated)
		user.throw_at(get_turf(target), 12, 0.8)
		user.spin(10)
		return TRUE
	if(!tackling)
		return FALSE
	// forgive me, the cost of modularity is high
	return SEND_SIGNAL(owner, COMSIG_MOB_CLICKON, target, list(RIGHT_CLICK = TRUE), TRUE) & COMSIG_MOB_CANCEL_CLICKON

/datum/action/cooldown/bloodsucker/targeted/lunge/proc/lunge_end(mob/living/carbon/user, datum/thrownthing/tackle)
	PowerActivatedSuccesfully()
	// Am I next to my target to start giving the effects?
	var/atom/hit_atom = tackle.initial_target.resolve()
	if(!owner.Adjacent(hit_atom) || !ishuman(hit_atom))
		return

	var/mob/living/carbon/target = hit_atom

	if(target.stat >= SOFT_CRIT)
		var/obj/item/bodypart/bodypart = target.get_bodypart(check_zone(user.zone_selected))
		if(!bodypart)
			target.balloon_alert(user, "bodypart missing!")
			return
		var/datum/wound/slash/flesh/moderate/crit_wound = new
		crit_wound.sound_effect = null
		crit_wound.apply_wound(bodypart)
		user.visible_message(
			span_warning("[user] tears into [target]'s [bodypart]!"),
			span_warning("You tear into [target]'s [bodypart]!"))
		playsound(target, 'sound/effects/wounds/crackandbleed.ogg', 100, TRUE, 5)
		if(target.stat != DEAD)
			to_chat(user, span_userdanger("SOMETHING IS TEARING INTO YOUR [capitalize(bodypart.name)]!"))
		var/obj/item/organ/internal/myheart_now
		if(bodypart.body_zone == BODY_ZONE_CHEST)
			myheart_now = target.get_organ_slot(ORGAN_SLOT_HEART)
		if(!myheart_now)
			var/list/organs = target.get_organs_for_zone(bodypart.body_zone)
			if(!length(organs))
				to_chat(user, span_warning("[target] has no organs in [bodypart]!"))
				target.balloon_alert(user, "no organs!")
				return
			myheart_now = pick(organs)

		if(myheart_now)
			myheart_now.Remove(target)
			user.put_in_hands(myheart_now)
