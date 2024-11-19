
#define LUNGE_INSTANT_LEVEL 4
#define LUNGE_INSTANT_RANGE 6
/datum/action/cooldown/bloodsucker/targeted/lunge
	name = "Predatory Lunge"
	desc = "Spring at your target to grapple them without warning, or tear the dead's heart out. Attacks from concealment or the rear may even knock them down if strong enough."
	button_icon_state = "power_lunge"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED|AB_CHECK_LYING|AB_CHECK_PHASED|AB_CHECK_LYING
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	cooldown_time = 10 SECONDS
	power_activates_immediately = FALSE
	unset_after_click = FALSE

/datum/action/cooldown/bloodsucker/targeted/lunge/get_power_explanation_extended()
	. = list()
	. += "Click any player to start spinning wildly and, after a short delay, dash at them."
	. += "When lunging at someone, you will grab them, immediately starting off at aggressive."
	. += "Riot gear and Monster Hunters are protected and will only be passively grabbed."
	. += "You cannot use the Power if you are already grabbing someone, or are being grabbed."
	. += "If you grab from behind, or while using cloak of darkness, you will knock the target down."
	. += "If used on a dead body, will tear out a random organ from the zone you are targeting."
	. += "Higher levels increase how long enemies are knocked down."
	. += "At level [LUNGE_INSTANT_LEVEL], you will no longer spin, but you will be limited to tackling from only [LUNGE_INSTANT_RANGE] tiles away."

/datum/action/cooldown/bloodsucker/targeted/lunge/on_power_upgrade()
	. = ..()
	//range is lowered when you get stronger, since it's instant now.
	if(level_current > LUNGE_INSTANT_LEVEL)
		target_range = LUNGE_INSTANT_RANGE

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

/// Check: Are we lunging at a person?
/datum/action/cooldown/bloodsucker/targeted/lunge/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return isliving(target_atom)

/datum/action/cooldown/bloodsucker/targeted/lunge/CheckCanTarget(atom/target_atom)
	// Default Checks
	. = ..()
	if(!.)
		return FALSE
	// Check: Turf
	var/mob/living/turf_target = target_atom
	if(!isturf(turf_target.loc))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/lunge/can_deactivate()
	return !(datum_flags & DF_ISPROCESSING) //only if you aren't lunging

/datum/action/cooldown/bloodsucker/targeted/lunge/FireTargetedPower(atom/target, params)
	. = ..()
	owner.face_atom(target)
	if(level_current >= LUNGE_INSTANT_LEVEL)
		do_lunge(target)
		return

	prepare_target_lunge(target)
	return TRUE

///Starts processing the power and prepares the lunge by spinning, calls lunge at the end of it.
/datum/action/cooldown/bloodsucker/targeted/lunge/proc/prepare_target_lunge(atom/target_atom)
	START_PROCESSING(SSprocessing, src)
	owner.balloon_alert(owner, "lunge started!")
	//animate them shake
	var/base_x = owner.base_pixel_x
	var/base_y = owner.base_pixel_y
	animate(owner, pixel_x = base_x, pixel_y = base_y, time = 1, loop = -1)
	for(var/i in 1 to 25)
		var/x_offset = base_x + rand(-3, 3)
		var/y_offset = base_y + rand(-3, 3)
		animate(pixel_x = x_offset, pixel_y = y_offset, time = 1)

	if(!do_after(owner, 2 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_SLOWDOWNS), extra_checks = CALLBACK(src, PROC_REF(CheckCanTarget), target_atom)))
		end_target_lunge(base_x, base_y)

		return FALSE

	end_target_lunge()
	do_lunge(target_atom)
	return TRUE

///When preparing to lunge ends, this clears it up.
/datum/action/cooldown/bloodsucker/targeted/lunge/proc/end_target_lunge(base_x, base_y)
	animate(owner, pixel_x = base_x, pixel_y = base_y, time = 1)
	STOP_PROCESSING(SSprocessing, src)

/datum/action/cooldown/bloodsucker/targeted/lunge/process()
	if(!active) //If running SSfasprocess (on cooldown)
		return ..() //Manage our cooldown timers
	if(prob(75))
		owner.spin(8, 1)
		owner.balloon_alert_to_viewers("spins wildly!", "you spin!")
		return
	do_smoke(0, owner.loc, smoke_type = /obj/effect/particle_effect/fluid/smoke/transparent)

///Actually lunges the target, then calls lunge end.
/datum/action/cooldown/bloodsucker/targeted/lunge/proc/do_lunge(atom/hit_atom)
	var/turf/targeted_turf = get_turf(hit_atom)

	var/safety = get_dist(owner, targeted_turf) * 3 + 1
	var/consequetive_failures = 0
	while(--safety && !hit_atom.Adjacent(owner))
		if(!step_to(owner, targeted_turf))
			consequetive_failures++
		if(consequetive_failures >= 3) // If 3 steps don't work, just stop.
			break

	lunge_end(hit_atom, targeted_turf)

/datum/action/cooldown/bloodsucker/targeted/lunge/proc/lunge_end(atom/hit_atom, turf/target_turf)
	PowerActivatedSuccesfully()
	// Am I next to my target to start giving the effects?
	if(!owner.Adjacent(hit_atom))
		return

	var/mob/living/user = owner
	var/mob/living/carbon/target = hit_atom

	// Did I slip or get knocked unconscious?
	if(user.body_position != STANDING_UP || user.incapacitated)
		user.throw_at(target_turf, 12, 0.8)
		user.spin(10)
		return
	// Is my target a Monster hunter?
	if(HAS_TRAIT(target, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED))
		user.balloon_alert(user, "pushed away!")
		target.grabbedby(user)
		return

	user.balloon_alert(user, "you lunge at [target]!")
	user.changeNext_move(CLICK_CD_MELEE)
	if(target.stat == DEAD)
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

	else
		if(!is_source_facing_target(target, user) || user.alpha <= 40)
			target.Knockdown(10 + level_current * 5)
			target.Paralyze(0.1)
		target.grabbedby(user)
		target.grippedby(user, instant = TRUE)
		// Did we knock them down?


/datum/action/cooldown/bloodsucker/targeted/lunge/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)

#undef LUNGE_INSTANT_LEVEL
#undef LUNGE_INSTANT_RANGE
