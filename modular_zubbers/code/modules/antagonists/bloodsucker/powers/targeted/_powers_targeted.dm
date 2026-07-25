// NOTE: All Targeted spells are Toggles! We just don't bother checking here.
/datum/action/cooldown/bloodsucker/targeted
	power_flags = NONE
	click_to_activate = TRUE
	///If set, how far the target has to be for the power to work.
	var/target_range
	///Message sent to chat when clicking on the power, before you use it.
	var/prefire_message
	///Is this power LOCKED due to being used?
	var/power_in_use = FALSE

/// Modify description to add notice that this is aimed.
/datum/action/cooldown/bloodsucker/targeted/get_power_desc()
	. = ..()
	var/current_desc = "<br>\[<i>Targeted Power</i>\]"
	if(target_range)
		current_desc += "<br>Cast Range: [target_range]<br>"
	current_desc += .
	return current_desc


// *Don't read this if you don't care about how actions work.*
// Actions are a wee complicated, but for anyone else who's going to take a look at this, let me explain.
// Actions start at Trigger, which is/ called by the client clicking the action button,
// if it's a targeted power, like this one here, it will call set_click_ability,
// which will set up the click interception. Thus clicking will call Trigger again, but with a target this time.
// Otherwise, if click_to_activate is false, it will simply always call Trigger without a target,
// and call PreActivate, which then calls Activate.
// For this ability, we call InterceptClickOn to trigger the ability with a target, as we want
// to be able to use trigger_flags, which Activate doesn't have.


// If click_to_activate is true, only these two procs are called when the ability is clicked on
/datum/action/cooldown/bloodsucker/targeted/set_click_ability(mob/on_who)
	// activate runs before
	if(!PreActivate())
		return
	. = ..()
	if(prefire_message)
		to_chat(owner, span_announce("[prefire_message]"))

/datum/action/cooldown/bloodsucker/targeted/unset_click_ability(mob/on_who, refund_cooldown)
	. = ..()
	if(active) //todo refactor active into is_action_active()
		DeactivatePower()

/// Check if target is VALID (wall, turf, or character?)
/datum/action/cooldown/bloodsucker/targeted/proc/CheckValidTarget(atom/target_atom)
	if(target_atom == owner)
		return FALSE
	if(!target_atom)
		return FALSE
	return TRUE

/// Check if valid target meets conditions
/datum/action/cooldown/bloodsucker/targeted/proc/CheckCanTarget(atom/target_atom)
	if(target_range)
		// Out of Range
		if(!(target_atom in view(target_range, owner)))
			if(target_range > 1) // Only warn for range if it's greater than 1
				owner.balloon_alert(owner, "out of range.")
			return FALSE
	return istype(target_atom)

/// Click Target
/datum/action/cooldown/bloodsucker/targeted/PreActivate(atom/target)
	if(!target)
		return ..()
	// CANCEL RANGED TARGET check
	if(power_in_use || !CheckValidTarget(target))
		return FALSE
	// Valid? (return true means DON'T cancel power!)
	if(!can_pay_cost() || !can_use(owner) || !CheckCanTarget(target))
		return FALSE
	if(power_activates_immediately)
		PowerActivatedSuccesfully() // Mesmerize pays only after success.
	power_in_use = FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/proc/FireTargetedPower(atom/target, params)
	return FALSE

/// Called on right click
/datum/action/cooldown/bloodsucker/targeted/proc/FireSecondaryTargetedPower(atom/target, params)
	return FireTargetedPower(target, params)

/datum/action/cooldown/bloodsucker/targeted/ActivatePower(atom/target)
	. = ..()
	if(!target)
		return .
	log_combat(owner, target, "used [name] on [target].")
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	// sometimes things will call DeactivatePower, but not unset_click_ability, so we have to unset the click interception here.
	if(owner.click_intercept == src) // TODO test if this is no longer needed
		owner.click_intercept = null

/// The power went off! We now pay the cost of the power.
/datum/action/cooldown/bloodsucker/targeted/proc/PowerActivatedSuccesfully(cooldown_override, cost_override)
	StartCooldown(cooldown_override)
	unset_click_ability(owner)
	pay_cost(cost_override)
	// if(active)
	// 	DeactivatePower()

/datum/action/cooldown/bloodsucker/targeted/InterceptClickOn(mob/living/clicker, params, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/list/modifiers = params2list(params)
	SEND_SIGNAL(src, COMSIG_FIRE_TARGETED_POWER, target)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return FireSecondaryTargetedPower(target, modifiers)
	else
		return FireTargetedPower(target, modifiers)
