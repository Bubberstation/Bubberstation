/datum/action/cooldown/vampire
	name = "Vampiric Gift"
	desc = "A vampiric gift."
	background_icon = 'modular_zubbers/icons/mob/actions/actions_vampire.dmi'
	background_icon_state = "vamp_power_off"
	button_icon = 'modular_zubbers/icons/mob/actions/actions_vampire.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"
	transparent_when_unavailable = TRUE

	/// Cooldown you'll have to wait between each use, decreases depending on level.
	cooldown_time = 2 SECONDS

	active_background_icon_state = "vamp_power_on"
	base_background_icon_state = "vamp_power_off"

	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS|AB_CHECK_PHASED

	/// A sort of tutorial text found in the Antagonist tab.
	power_explanation = "Use this power to do... something"
	/// The owner's vampire datum
	var/datum/antagonist/vampire/vampiredatum_power
	/// The owner's vassal datum, when a vassal has this power instead
	var/datum/antagonist/vassal/vassaldatum_power
	/// How long the other powers in our shared_cooldown group get locked out when this one goes on cooldown.
	var/shared_cooldown_time = 10 SECONDS

	/// The effects on this Power (Toggled/Single Use/Static Cooldown)
	var/vampire_power_flags = BP_AM_TOGGLE | BP_AM_SINGLEUSE | BP_AM_STATIC_COOLDOWN | BP_AM_COSTLESS_UNCONSCIOUS
	/// Vampire-specific requirement flags, on top of check_flags
	var/vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_IN_FRENZY | BP_CANT_USE_WHILE_STAKED

	// Special flags you can give to powers. Mainly used for any powers we want them to have by default, so, feed.
	var/special_flags = NONE
	/// If the Power is currently active, differs from action cooldown because of how powers are handled.
	var/currently_active = FALSE
	///Can increase to yield new abilities
	var/level_current = 1
	///The cost to ACTIVATE this Power
	var/vitaecost = 0
	///The cost to MAINTAIN this Power, per life tick of VAMPIRE_LIFE_TICK_SECONDS. Only used for constant powers
	var/constant_vitaecost = 0
	/// If TRUE, both costs double while the user stands on a brightly lit tile.
	var/costs_double_in_light = FALSE

	///The upgraded version of this Power. 'null' means it's the max level.
	var/upgraded_power = null

/datum/action/cooldown/vampire/New(Target, original = TRUE)
	. = ..()
	update_desc()

/datum/action/cooldown/vampire/Destroy()
	vampiredatum_power = null
	vassaldatum_power = null
	return ..()

/datum/action/cooldown/vampire/Grant(mob/user)
	. = ..()
	if(!owner)
		return
	var/datum/antagonist/vampire/vampiredatum = IS_VAMPIRE(owner)
	if(vampiredatum)
		vampiredatum_power = vampiredatum
	var/datum/antagonist/vassal/vassaldatum = IS_VASSAL(owner)
	if(vassaldatum)
		vassaldatum_power = vassaldatum

	if(vampire_check_flags & BP_CANT_USE_IN_TORPOR)
		RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_TORPOR), SIGNAL_REMOVETRAIT(TRAIT_TORPOR)), PROC_REF(update_status_on_signal))
	if(vampire_check_flags & BP_CANT_USE_IN_FRENZY)
		RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_FRENZY), SIGNAL_REMOVETRAIT(TRAIT_FRENZY)), PROC_REF(update_status_on_signal))
	if(vampiredatum_power && !(vampire_check_flags & BP_CAN_USE_HEARTLESS))
		RegisterSignals(owner, list(COMSIG_CARBON_GAIN_ORGAN, COMSIG_CARBON_LOSE_ORGAN), PROC_REF(update_status_on_signal))

/datum/action/cooldown/vampire/Remove(mob/removed_from)
	if(owner)
		UnregisterSignal(owner, list(
			COMSIG_LIVING_LIFE,
			COMSIG_CARBON_GAIN_ORGAN,
			COMSIG_CARBON_LOSE_ORGAN,
			SIGNAL_ADDTRAIT(TRAIT_TORPOR),
			SIGNAL_ADDTRAIT(TRAIT_FRENZY),
			SIGNAL_REMOVETRAIT(TRAIT_TORPOR),
			SIGNAL_REMOVETRAIT(TRAIT_FRENZY),
		))
	return ..()

/datum/action/cooldown/vampire/is_action_active(atom/movable/screen/movable/action_button/current_button)
	if(currently_active)
		return TRUE
	return ..()

/// An active power can always be clicked off. Otherwise check_flags, cooldown and our own flags all apply.
/datum/action/cooldown/vampire/IsAvailable(feedback = FALSE)
	if(currently_active)
		return !!owner
	return ..() && check_vampire_flags(feedback)

/// The vampire_check_flags part of IsAvailable()
/datum/action/cooldown/vampire/proc/check_vampire_flags(feedback = FALSE)
	if(!isliving(owner))
		return FALSE
	var/mob/living/living_owner = owner
	if(vampiredatum_power && !(vampire_check_flags & BP_CAN_USE_HEARTLESS) && !living_owner.get_organ_slot(ORGAN_SLOT_HEART))
		if(feedback)
			to_chat(owner, span_warning("To channel your powers you need a heart!"))
		return FALSE
	if((vampire_check_flags & BP_CANT_USE_IN_TORPOR) && HAS_TRAIT(owner, TRAIT_TORPOR))
		if(feedback)
			to_chat(owner, span_warning("Not while you're in Torpor."))
		return FALSE
	if((vampire_check_flags & BP_CANT_USE_IN_FRENZY) && HAS_TRAIT(owner, TRAIT_FRENZY))
		if(feedback)
			to_chat(owner, span_warning("You cannot use powers while in a Frenzy!"))
		return FALSE
	if((vampire_check_flags & BP_CANT_USE_WHILE_STAKED) && vampiredatum_power?.check_if_staked())
		if(feedback)
			to_chat(owner, span_warning("You have a stake in your chest! Your powers are useless."))
		return FALSE
	return TRUE

//This is when we CLICK on the ability Icon, not USING.
/datum/action/cooldown/vampire/Activate(atom/target)
	if(currently_active)
		deactivate_power()
		return FALSE
	if(!can_pay_cost() || !can_use())
		return FALSE
	pay_cost()
	activate_power()
	if(!(vampire_power_flags & BP_AM_TOGGLE) || !currently_active)
		StartCooldown()

	return TRUE

/datum/action/cooldown/vampire/proc/update_desc()
	desc = get_power_desc()

/// Builds the button tooltip, rebuilt whenever the power's level changes
/datum/action/cooldown/vampire/proc/get_power_desc()
	SHOULD_CALL_PARENT(TRUE)
	var/new_desc = get_power_desc_extended()
	if(level_current > 1)
		new_desc += "<br><br><b>LEVEL:</b> [level_current]"
	if(vitaecost > 0)
		new_desc += "<br><br><b>COST:</b> [vitaecost] Blood"
	if(constant_vitaecost > 0)
		new_desc += "<br><br><b>CONSTANT COST:</b><i> [constant_vitaecost / VAMPIRE_LIFE_TICK_SECONDS] Blood per second.</i>"
	if(vampire_power_flags & BP_AM_SINGLEUSE)
		new_desc += "<br><br><b>SINGLE USE:</b><i> Can only be used once per night.</i>"
	if(costs_double_in_light)
		new_desc += "<br><br><b>LIGHT:</b><i> Costs double while you stand in bright light.</i>"
	if(shared_cooldown & VAMPIRE_SHARED_COOLDOWN_MIND)
		new_desc += "<br><br><b>SHARED COOLDOWN:</b><i> Using this locks your other disabling powers for [DisplayTimeText(shared_cooldown_time)].</i>"
	return new_desc

/// The descriptive part of the tooltip, override for text that depends on level_current
/datum/action/cooldown/vampire/proc/get_power_desc_extended()
	return initial(desc)

/// Lines shown for this power in the antagonist panel
/datum/action/cooldown/vampire/proc/get_power_explanation()
	SHOULD_CALL_PARENT(TRUE)
	. = list()
	. += get_power_explanation_extended()

/// The explanation itself, override for text that depends on level_current
/datum/action/cooldown/vampire/proc/get_power_explanation_extended()
	return list(power_explanation)

/// Same idea as the core version, but the lockout length is ours, a longer cooldown never gets shortened, and a power that is armed or mid-use gets cancelled.
/datum/action/cooldown/vampire/StartCooldownOthers(override_cooldown_time)
	if(!length(owner?.actions))
		return
	if((shared_cooldown & VAMPIRE_SHARED_COOLDOWN_MIND) && vampiredatum_power)
		vampiredatum_power.mind_lockout_end = world.time + shared_cooldown_time
	for(var/datum/action/cooldown/vampire/shared_power in owner.actions - src)
		if(!(shared_cooldown & shared_power.shared_cooldown))
			continue
		if(shared_power.currently_active)
			shared_power.deactivate_power()
		if(shared_power.next_use_time - world.time >= shared_cooldown_time)
			continue
		shared_power.StartCooldownSelf(shared_cooldown_time)

/// Vitae we can spend: the vampire's own, the master's blood in a vassal, or plain blood for anyone else (hemophages).
/datum/action/cooldown/vampire/proc/get_vitae()
	if(vampiredatum_power)
		return vampiredatum_power.current_vitae
	if(vassaldatum_power)
		return vassaldatum_power.vitae
	var/mob/living/living_owner = owner
	if(!isliving(living_owner) || HAS_TRAIT(living_owner, TRAIT_NOBLOOD))
		return 0
	return living_owner.get_blood_volume()

/// Takes vitae from whichever pool get_vitae() reads.
/datum/action/cooldown/vampire/proc/spend_vitae(amount)
	if(amount <= 0)
		return
	if(vampiredatum_power)
		vampiredatum_power.adjust_blood_volume(-amount)
		return
	if(vassaldatum_power)
		vassaldatum_power.adjust_vitae(-amount)
		return
	var/mob/living/living_owner = owner
	if(!isliving(living_owner))
		return
	if(HAS_TRAIT(living_owner, TRAIT_NOBLOOD))
		living_owner.adjust_brute_loss(amount * 0.1)
		return
	living_owner.adjust_blood_volume(-amount)

/// Applies the bright light tax to a cost, if this power has it.
/datum/action/cooldown/vampire/proc/get_vitaecost(base_cost)
	if(!costs_double_in_light)
		return base_cost
	var/turf/owner_turf = get_turf(owner)
	if(owner_turf?.get_lumcount() > SHADOW_SPECIES_BRIGHT_LIGHT)
		return base_cost * 2
	return base_cost

/datum/action/cooldown/vampire/proc/can_pay_cost()
	if(QDELETED(owner))
		return FALSE

	// Have enough blood? Vampires in a Frenzy don't need to pay them
	if(HAS_TRAIT(owner, TRAIT_FRENZY))
		return TRUE
	if(get_vitae() < get_vitaecost(vitaecost))
		owner.balloon_alert(owner, "not enough blood.")
		return FALSE

	return TRUE

/// Checks beyond IsAvailable() made right as the power is used. IsAvailable() already ran with feedback by the time this is reached from a button press.
/datum/action/cooldown/vampire/proc/can_use()
	if(!iscarbon(owner))
		return FALSE
	if(!currently_active && !IsAvailable(feedback = TRUE))
		return FALSE
	// Constant Cost (out of blood)
	if(constant_vitaecost > 0 && get_vitae() <= 0)
		to_chat(owner, span_warning("You don't have the blood to upkeep [src]."))
		return FALSE
	return TRUE

/datum/action/cooldown/vampire/proc/pay_cost()
	// Vampires in a Frenzy don't have enough Blood to pay it, so just don't.
	if(HAS_TRAIT(owner, TRAIT_FRENZY))
		return
	spend_vitae(get_vitaecost(vitaecost))

/datum/action/cooldown/vampire/proc/activate_power()
	currently_active = TRUE
	if(vampire_power_flags & BP_AM_TOGGLE)
		RegisterSignal(owner, COMSIG_LIVING_LIFE, PROC_REF(use_power))

	owner.log_message("used [src][vitaecost != 0 ? " at the cost of [vitaecost]" : ""].", LOG_ATTACK, color="red")
	build_all_button_icons(UPDATE_BUTTON_NAME | UPDATE_BUTTON_BACKGROUND)

/datum/action/cooldown/vampire/proc/deactivate_power()
	if(!currently_active) //Already inactive? Return
		return

	if(vampire_power_flags & BP_AM_TOGGLE)
		UnregisterSignal(owner, COMSIG_LIVING_LIFE)
	if(vampire_power_flags & BP_AM_SINGLEUSE)
		remove_after_use()
		return

	currently_active = FALSE
	StartCooldown()
	build_all_button_icons(UPDATE_BUTTON_NAME | UPDATE_BUTTON_BACKGROUND)

/// Used by powers that are continuously active (That have BP_AM_TOGGLE flag). Runs every life tick of the owner.
/datum/action/cooldown/vampire/proc/use_power(mob/living/source, seconds_per_tick)
	if(!continue_active()) // We can't afford the Power? Deactivate it.
		deactivate_power()
		return FALSE

	if((vampire_power_flags & BP_AM_COSTLESS_UNCONSCIOUS) && IS_UNCONSCIOUS_OR_CRIT(owner))
		return TRUE
	spend_vitae(get_tick_cost(seconds_per_tick))
	return TRUE

/// The upkeep owed for this many seconds of being active
/datum/action/cooldown/vampire/proc/get_tick_cost(seconds_per_tick = VAMPIRE_LIFE_TICK_SECONDS)
	return get_vitaecost(constant_vitaecost) * seconds_per_tick / VAMPIRE_LIFE_TICK_SECONDS

/// Checks to make sure this power can stay active
/datum/action/cooldown/vampire/proc/continue_active()
	if(QDELETED(owner))
		return FALSE
	if(get_vitae() < get_tick_cost())
		return FALSE

	return TRUE

/// Used to unlearn Single-Use Powers
/datum/action/cooldown/vampire/proc/remove_after_use()
	currently_active = FALSE
	vampiredatum_power?.powers -= src
	Remove(owner)
