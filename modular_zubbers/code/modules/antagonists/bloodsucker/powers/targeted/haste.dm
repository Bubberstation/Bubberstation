/* Level 1: Speed to location
 * Level 2: Dodge Bullets
 * Level 3: Stun People Passed
 */

#define HASTE_GETUP_LEVEL 3
/datum/action/cooldown/bloodsucker/targeted/haste
	name = "Immortal Haste"
	desc = "Force yourself to stand up if you're down and dash somewhere with supernatural speed. Those nearby may be knocked away, stunned, or left empty-handed."
	button_icon_state = "power_speed"
	prefire_message = "You prepare to dash!"
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 6
	cooldown_time = 12 SECONDS
	target_range = 5
	power_activates_immediately = FALSE
	///List of all people hit by our power, so we don't hit them again.
	var/list/hit = list()

/datum/action/cooldown/bloodsucker/targeted/haste/get_power_desc_extended()
	. = "Dash to a location, knocking down anyone in your way, and refilling your stamina. Those nearby may be knocked away, stunned, or left empty-handed.\n"
	if(level_current >= HASTE_GETUP_LEVEL)
		. += "Dashing from lying down will get you up, but won't affect your foes."
	else
		. += "You cannot dash while knocked down."

/datum/action/cooldown/bloodsucker/targeted/haste/get_power_explanation_extended()
	. = list()
	. += "Click anywhere to immediately dash towards that location."
	. += "At level [HASTE_GETUP_LEVEL], if you are lying down, you will get up and regain your stamina, but the resulting dash will not knock down those nearby."
	. += "Haste will knockdown your enemies for [DisplayTimeText(GetKnockdown())] and refill your stamina, but using haste while knocked down will make it go on cooldown for [DisplayTimeText(cooldown_time * 3)]"
	. += "The Power will not work if you are lying down, in no gravity, or are aggressively grabbed."
	. += "Anyone in your way during your Haste will be knocked down."
	. += "Higher levels will increase the knockdown dealt to enemies."
	. += "It will also refill your stamina so you can keep moving."
	. += "If Fortitude is active, using haste will disable it."

/datum/action/cooldown/bloodsucker/targeted/haste/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	// Being Grabbed
	if(user.pulledby && user.pulledby.grab_state >= GRAB_AGGRESSIVE)
		user.balloon_alert(user, "you're being grabbed!")
		return FALSE
	if(!user.has_gravity(user.loc)) //We dont want people to be able to use this to fly around in space
		user.balloon_alert(user, "you cannot dash while floating!")
		return FALSE
	if(level_current < HASTE_GETUP_LEVEL && user.body_position == LYING_DOWN)
		user.balloon_alert(user, "you must be standing to dash!")
		return FALSE
	return TRUE

/// Anything will do, if it's not mea or my square
/datum/action/cooldown/bloodsucker/targeted/haste/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return target_atom.loc != owner.loc

/// This is a non-async proc to make sure the power is "locked" until this finishes.
/datum/action/cooldown/bloodsucker/targeted/haste/FireTargetedPower(atom/target, params)
	. = ..()
	var/mob/living/user = owner
	var/stuns_mobs = TRUE
	var/temp_cooldown = cooldown_time
	if(level_current >= HASTE_GETUP_LEVEL && user.body_position == LYING_DOWN)
		to_chat(user, span_danger("Your heart takes a beat, and you force yourself to stand up!"))
		user.SetKnockdown(0)
		user.setStaminaLoss(0)
		user.set_resting(FALSE, FALSE, TRUE)
		stuns_mobs = FALSE
		temp_cooldown = GetGetupCooldown()
	if(stuns_mobs)
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	var/turf/targeted_turf = isturf(target) ? target : get_turf(target)
	// Pulled? Not anymore.
	user.pulledby?.stop_pulling()
	// Go to target turf
	// DO NOT USE WALK TO.
	owner.balloon_alert(owner, "you dash into the air!")
	playsound(get_turf(owner), 'sound/weapons/punchmiss.ogg', 25, 1, -1)
	var/safety = get_dist(user, targeted_turf) * 3 + 1
	var/consequetive_failures = 0
	active = TRUE
	while(--safety && (get_turf(user) != targeted_turf))
		var/success = step_towards(user, targeted_turf) //This does not try to go around obstacles.
		if(!success)
			success = step_to(user, targeted_turf) //this does
		if(!success)
			consequetive_failures++
			if(consequetive_failures >= 3) //if 3 steps don't work
				break //just stop
		else
			consequetive_failures = 0 //reset so we can keep moving
		if(user.resting || INCAPACITATED_IGNORING(user, INCAPABLE_GRAB|INCAPABLE_RESTRAINTS)) //actually down? stop.
			break
		if(success) //don't sleep if we failed to move.
			sleep(world.tick_lag)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	hit.Cut()
	user.adjustStaminaLoss(-user.staminaloss)
	PowerActivatedSuccesfully(temp_cooldown)

/datum/action/cooldown/bloodsucker/targeted/haste/proc/GetKnockdown()
	return 10 + level_current * 4

/datum/action/cooldown/bloodsucker/targeted/haste/proc/GetGetupCooldown()
	return cooldown_time * 3

/datum/action/cooldown/bloodsucker/targeted/haste/proc/on_move()
	for(var/mob/living/hit_living in dview(1, get_turf(owner)) - owner)
		if(hit.Find(hit_living))
			continue
		hit += hit_living
		playsound(hit_living, "sound/weapons/punch[rand(1,4)].ogg", 15, 1, -1)
		hit_living.Knockdown(GetKnockdown())
		hit_living.spin(10, 1)

#undef HASTE_GETUP_LEVEL
