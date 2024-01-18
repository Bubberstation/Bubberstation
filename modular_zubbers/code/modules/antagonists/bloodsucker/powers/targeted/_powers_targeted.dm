// NOTE: All Targeted spells are Toggles! We just don't bother checking here.
/datum/action/cooldown/bloodsucker/targeted
	power_flags = BP_AM_TOGGLE
	click_to_activate = TRUE
	power_activates_immediately = TRUE
	///If set, how far the target has to be for the power to work.
	var/target_range
	///Message sent to chat when clicking on the power, before you use it.
	var/prefire_message
	///Is this power LOCKED due to being used?
	var/power_in_use = FALSE

/// Modify description to add notice that this is aimed.
/datum/action/cooldown/bloodsucker/targeted/New(Target)
	desc += "<br>\[<i>Targeted Power</i>\]"
	return ..()

// *Don't read this if you don't care about how actions work.*
// Actions are a wee complicated, but for anyone else who's going to take a look at this, let me explain.
// Actions satart at Trigger, which is called by the client clicking the action button,
// if it's a targeted power, like this one here, it will call set_click_ability,
// which will set up the click interception. Thus clicking will call Trigger again, but with a target this time.
// Otherwise, if click_to_activate is false, it will simply always call Trigger without a target,
// and call PreActivate, which then calls Activate.
// For this ability, we call InterceptClickOn to trigger the ability with a target, as we want
// to be able to use trigger_flags, which mere Activate doesn't have.

/datum/action/cooldown/bloodsucker/targeted/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(target)
		. = FireTargetedPower(target, trigger_flags)

// If click_to_activate is true, only these two procs are called when the ability is clicked on
/datum/action/cooldown/bloodsucker/targeted/set_click_ability(mob/on_who)
	. = ..()
	Activate()
	if(prefire_message)
		to_chat(owner, span_announce("[prefire_message]"))

/datum/action/cooldown/bloodsucker/targeted/unset_click_ability(mob/on_who, refund_cooldown)
	. = ..()
	if(power_activates_immediately)
		DeactivatePower()

/datum/action/cooldown/bloodsucker/targeted/DeactivatePower()
	if(power_flags & BP_AM_TOGGLE)
		STOP_PROCESSING(SSprocessing, src)
	active = FALSE
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

/// Check if target is VALID (wall, turf, or character?)
/datum/action/cooldown/bloodsucker/targeted/proc/CheckValidTarget(atom/target_atom)
	if(target_atom == owner)
		return FALSE
	if(!target_atom)
		stack_trace("Targeted power [name] has no target! This should never happen.")
		return FALSE
	return TRUE

/// Check if valid target meets conditions
/datum/action/cooldown/bloodsucker/targeted/proc/CheckCanTarget(atom/target_atom)
	if(target_range)
		// Out of Range
		if(!(target_atom in view(target_range, owner)))
			if(target_range > 1) // Only warn for range if it's greater than 1. Brawn doesn't need to announce itself.
				owner.balloon_alert(owner, "out of range.")
			return FALSE
	return istype(target_atom)

/// Click Target
/datum/action/cooldown/bloodsucker/targeted/PreActivate(atom/target)
	. = ..()
	// CANCEL RANGED TARGET check
	if(power_in_use || !CheckValidTarget(target))
		return FALSE
	// Valid? (return true means DON'T cancel power!)
	if(!can_pay_cost() || !can_use(owner) || !CheckCanTarget(target))
		return TRUE
	power_in_use = TRUE // Lock us into this ability until it successfully fires off. Otherwise, we pay the blood even if we fail.
	if(power_activates_immediately)
		PowerActivatedSuccesfully() // Mesmerize pays only after success.
	power_in_use = FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/proc/FireTargetedPower(atom/target, params)
	return FALSE

/// Mostly unused for trigger powers, if you're coding a new bloodsucker ability, use TargetedActivate instead.
/datum/action/cooldown/bloodsucker/targeted/Activate(atom/target)
	. = ..()
	if(!target)
		return .
	log_combat(owner, target, "used [name] on")

/// The power went off! We now pay the cost of the power.
/datum/action/cooldown/bloodsucker/targeted/proc/PowerActivatedSuccesfully(cooldown_override)
	StartCooldown(cooldown_override)
	DeactivatePower()

/datum/action/cooldown/bloodsucker/targeted/InterceptClickOn(mob/living/caller, params, atom/target)
	. = ..()
	if(!.)
		return FALSE
	// InterceptClickOn already runs PreActivate, so only check if the return value is FALSE.
	// I would use Activate if it actually had click params, but I want to be able to
	// check for right clicks.
	FireTargetedPower(target, params)
