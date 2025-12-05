/datum/action/cooldown/bloodsucker
	name = "Vampiric Gift"
	background_icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	background_icon_state = "vamp_power_off"
	button_icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"
	transparent_when_unavailable = TRUE

	/// Cooldown you'll have to wait between each use, decreases depending on level.
	cooldown_time = 2 SECONDS

	///Background icon when the Power is active.
	active_background_icon_state = "vamp_power_on"
	///Background icon when the Power is NOT active.
	base_background_icon_state = "vamp_power_off"

	/// The text that appears when using the help verb, meant to explain how the Power changes when ranking up.
	///The owner's stored Bloodsucker datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum_power

	// FLAGS //
	/// The effects on this Power (Toggled/Single Use/Static Cooldown)
	var/power_flags = BP_AM_SINGLEUSE|BP_AM_STATIC_COOLDOWN|BP_AM_COSTLESS_UNCONSCIOUS
	/// Requirement flags for checks
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS|AB_CHECK_PHASED
	var/bloodsucker_check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY
	/// Who can purchase the Power
	var/purchase_flags = NONE // BLOODSUCKER_CAN_BUY|BLOODSUCKER_DEFAULT_POWER|TREMERE_CAN_BUY|GHOUL_CAN_BUY

	// VARS //
	/// If the Power is currently active, differs from action cooldown because of how powers are handled.
	var/active = FALSE
	///Can increase to yield new capabilities - Each Power ranks up each Rank, with the oldest power being the highest rank.
	var/level_current = 0
	///The cost to ACTIVATE this Power
	var/bloodcost = 0
	///The cost to MAINTAIN this Power - Only used for Constant Cost Powers
	var/constant_bloodcost = 0
	///Most powers happen the moment you click. Some, like Mesmerize, require time and shouldn't cost you if they fail.
	var/power_activates_immediately = TRUE

// Modify description to add cost.
/datum/action/cooldown/bloodsucker/New(Target)
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
	desc = get_power_desc()

/datum/action/cooldown/bloodsucker/Destroy()
	SHOULD_CALL_PARENT(TRUE)
	if(active)
		DeactivatePower()
	bloodsuckerdatum_power = null
	return ..()

/datum/action/cooldown/bloodsucker/IsAvailable(feedback = FALSE)
	return next_use_time <= world.time

/datum/action/cooldown/bloodsucker/Grant(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	if(bloodsuckerdatum)
		bloodsuckerdatum_power = bloodsuckerdatum

/datum/action/cooldown/bloodsucker/Trigger(trigger_flags, atom/target)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		RightClickActivate(trigger_flags)
		return
	. = ..()

//This is when we CLICK on the ability Icon, not USING.
/datum/action/cooldown/bloodsucker/PreActivate(atom/target)
	if(QDELETED(owner))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	if(active && can_deactivate()) // Active? DEACTIVATE AND END!
		DeactivatePower()
		return FALSE
	if(!can_pay_cost() || !can_use(owner))
		return FALSE
	. = ..()
	// base type returns true? Pay costs
	if(!click_to_activate && power_activates_immediately)
		pay_cost()

/datum/action/cooldown/bloodsucker/proc/can_pay_cost()
	if(QDELETED(owner) || !owner.mind)
		return FALSE
	// Cooldown?
	if(!COOLDOWN_FINISHED(src, next_use_time))
		owner.balloon_alert(owner, "power unavailable!")
		return FALSE
	if(!bloodsuckerdatum_power)
		var/mob/living/living_owner = owner
		if(!HAS_TRAIT(living_owner, TRAIT_NOBLOOD) && living_owner.blood_volume <= bloodcost)
			to_chat(owner, span_warning("You need at least [bloodcost] blood to activate [name]"))
			return FALSE
		return TRUE

	// Have enough blood? Bloodsuckers in a Frenzy don't need to pay them
	if(bloodsuckerdatum_power.frenzied)
		return TRUE
	if(bloodsuckerdatum_power.GetBloodVolume() < bloodcost)
		to_chat(owner, span_warning("You need at least [bloodcost] blood to activate [name]"))
		return FALSE
	return TRUE

///Called when the Power is upgraded.
/datum/action/cooldown/bloodsucker/proc/upgrade_power()
	SHOULD_CALL_PARENT(TRUE)
	DeactivatePower()
	if(level_current == -1) // -1 means it doesn't rank up ever
		return FALSE
	level_current++
	on_power_upgrade()
	return TRUE

/datum/action/cooldown/bloodsucker/proc/on_power_upgrade()
	SHOULD_CALL_PARENT(TRUE)
	desc = get_power_desc()
	if(purchase_flags & TREMERE_CAN_BUY && level_current >= TREMERE_OBJECTIVE_POWER_LEVEL)
		background_icon_state = "tremere_power_gold_off"
		active_background_icon_state = "tremere_power_gold_on"
		base_background_icon_state = "tremere_power_gold_off"
	build_all_button_icons(ALL)

///Checks if the Power is available to use.
/datum/action/cooldown/bloodsucker/proc/can_use(mob/living/carbon/user)
	if(QDELETED(owner))
		return FALSE
	if(!isliving(user))
		return FALSE
	if(!(bloodsucker_check_flags & BP_CAN_USE_HEARTLESS) && bloodsuckerdatum_power && !owner.get_organ_slot(ORGAN_SLOT_HEART))
		to_chat(user, span_warning("To channel your powers you need a heart!"))
		return FALSE
	if(isbrain(user))
		to_chat(user, span_warning("What are you going to do, jump on someone and suck their blood? You're just a head."))
		return FALSE
	// Torpor?
	if((bloodsucker_check_flags & BP_CANT_USE_IN_TORPOR) && bloodsuckerdatum_power?.is_in_torpor())
		to_chat(user, span_warning("Not while you're in Torpor."))
		return FALSE
	if(!(bloodsucker_check_flags & BP_CAN_USE_TRANSFORMED) && (user.has_status_effect(/datum/status_effect/shapechange_mob/from_spell) || user.has_status_effect(/datum/status_effect/shapechange_mob)))
		to_chat(user, span_warning("You can't do this while transformed!"))
		return FALSE
	// Frenzy?
	if((bloodsucker_check_flags & BP_CANT_USE_IN_FRENZY) && (bloodsuckerdatum_power?.frenzied))
		to_chat(user, span_warning("You cannot use powers while in a Frenzy!"))
		return FALSE
	// Stake?
	if(!(bloodsucker_check_flags & BP_CAN_USE_WHILE_STAKED) && user.am_staked())
		to_chat(user, span_warning("You have a stake in your chest! Your powers are useless."))
		return FALSE
	// Constant Cost (out of blood)
	if(constant_bloodcost > 0 && !can_pay_blood(user))
		to_chat(user, span_warning("You don't have the blood to upkeep [src]."))
		return FALSE
	return TRUE

/// NOTE: With this formula, you'll hit half cooldown at level 8 for that power.
/datum/action/cooldown/bloodsucker/StartCooldown(override_cooldown_time, override_melee_cooldown_time)
	// Calculate Cooldown (by power's level)
	if(!(power_flags & BP_AM_STATIC_COOLDOWN))
		var/custom_cooldown = max(initial(cooldown_time) / 2, initial(cooldown_time) - (initial(cooldown_time) / 16 * (level_current-1)))
		// calling parent proc with custom args
		return ..(custom_cooldown, override_melee_cooldown_time)
	return ..()

/datum/action/cooldown/bloodsucker/proc/can_pay_blood(mob/living/carbon/user)
	return bloodsuckerdatum_power ? bloodsuckerdatum_power?.GetBloodVolume() >= 0 : user.blood_volume >= 0

/datum/action/cooldown/bloodsucker/proc/can_deactivate()
	return TRUE

/datum/action/cooldown/bloodsucker/is_action_active()
	return active

/datum/action/cooldown/bloodsucker/proc/pay_cost(cost_override)
	// Non-bloodsuckers will pay in other ways.
	if(!bloodsuckerdatum_power)
		var/mob/living/living_owner = owner
		var/blood_cost = cost_override ? cost_override : bloodcost
		if(HAS_TRAIT(living_owner, TRAIT_NOBLOOD))
			living_owner.adjust_brute_loss(blood_cost * 0.1)
		else
			living_owner.blood_volume = max(0, living_owner.blood_volume - blood_cost)
		return
	// Bloodsuckers in a Frenzy don't have enough Blood to pay it, so just don't.
	if(bloodsuckerdatum_power.frenzied)
		return
	bloodsuckerdatum_power.AdjustBloodVolume(cost_override ? -cost_override : -bloodcost)

// TODO refactor the Trigger -> PreActivate -> Activate -> ActivatePower / set_click_ability -> Activate -> ActivatePower chain
/datum/action/cooldown/bloodsucker/Activate(atom/target)
	if(active)
		return FALSE
	active = TRUE
	. = ActivatePower(target)
	if(!.)
		DeactivatePower(DEACTIVATE_POWER_NO_COOLDOWN)
		return FALSE
	if(power_flags & BP_CONTINUOUS_EFFECT || constant_bloodcost)
		START_PROCESSING(SSprocessing, src)

	owner.log_message("used [src][bloodcost != 0 ? " at the cost of [bloodcost]" : ""].", LOG_ATTACK, color="red")
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

/datum/action/cooldown/bloodsucker/proc/RightClickActivate(trigger_flags)
	if(!owner)
		return FALSE

/// return TRUE if you want the ability to be considered activated, put your ability activate logic here
/datum/action/cooldown/bloodsucker/proc/ActivatePower(atom/target)
	return TRUE

/datum/action/cooldown/bloodsucker/proc/DeactivatePower(deactivate_flags)
	SHOULD_CALL_PARENT(TRUE)
	if(!active) //Already inactive? Return
		return FALSE
	if(power_flags & BP_CONTINUOUS_EFFECT || constant_bloodcost)
		STOP_PROCESSING(SSprocessing, src)
	if(power_flags & BP_AM_SINGLEUSE && !(deactivate_flags & DEACTIVATE_POWER_DO_NOT_REMOVE))
		remove_after_use()
		return FALSE
	active = FALSE
	if(!click_to_activate && !(deactivate_flags & DEACTIVATE_POWER_NO_COOLDOWN))
		StartCooldown()
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)
	return TRUE

///Used by powers that are scontinuously active (That have BP_CONTINUOUS_EFFECT flag)
/datum/action/cooldown/bloodsucker/process(seconds_per_tick)
	SHOULD_CALL_PARENT(TRUE) //Need this to call parent so the cooldown system works
	. = ..()
	if(!active || !(power_flags & BP_CONTINUOUS_EFFECT))
		return FALSE
	if(!ContinueActive(owner)) // We can't afford the Power? Deactivate it.
		DeactivatePower()
		return FALSE
	// We can keep this up (For now), so Pay Cost!
	if(power_flags & BP_AM_COSTLESS_UNCONSCIOUS && owner.stat != CONSCIOUS)
		return TRUE
	if(constant_bloodcost < 0)
		return TRUE
	if(bloodsuckerdatum_power)
		bloodsuckerdatum_power.AdjustBloodVolume(-constant_bloodcost * seconds_per_tick)
	else
		pay_cost(constant_bloodcost * seconds_per_tick)
	return TRUE

/// Checks to make sure this power can stay active
/datum/action/cooldown/bloodsucker/proc/ContinueActive(mob/living/user, mob/living/target)
	if(QDELETED(user))
		return FALSE
	if(!constant_bloodcost > 0 || can_pay_blood(user))
		return TRUE

/// Used to unlearn Single-Use Powers
/datum/action/cooldown/bloodsucker/proc/remove_after_use()
	bloodsuckerdatum_power?.powers -= src
	Remove(owner)

/datum/action/cooldown/bloodsucker/proc/get_power_explanation()
	SHOULD_CALL_PARENT(TRUE)
	. = list()
	if(level_current != -1)
		. += "LEVEL: [level_current] [name]:"
	else
		. += "(Inherent Power) [name]:"

	. += get_power_explanation_extended()

/datum/action/cooldown/bloodsucker/proc/get_power_explanation_extended()
	return list()

/datum/action/cooldown/bloodsucker/proc/get_power_desc()
	SHOULD_CALL_PARENT(TRUE)
	var/new_desc = ""
	if(level_current != -1)
		new_desc += "<br><b>LEVEL:</b> [level_current]"
	else
		new_desc += "<br><b>(Inherent Power)</b>"
	if(bloodcost > 0)
		new_desc += "<br><br><b>COST:</b> [bloodcost] Blood"
	if(constant_bloodcost > 0)
		new_desc += "<br><br><b>CONSTANT COST:</b><i> [name] costs [constant_bloodcost] blood per second to keep it active.</i>"
	if(power_flags & BP_AM_SINGLEUSE)
		new_desc += "<br><br><br>SINGLE USE:</br><i> [name] can only be used once per night.</i>"
	new_desc += "<br><br><b>DESCRIPTION:</b> [get_power_desc_extended()]"
	new_desc += "<br>"
	return new_desc

/datum/action/cooldown/bloodsucker/proc/get_power_desc_extended()
	return initial(desc)
