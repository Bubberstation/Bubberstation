/datum/action/cooldown/bloodsucker/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings, but will render you unable to heal."
	button_icon_state = "power_fortitude"
	power_explanation = "Fortitude:\n\
		Activating Fortitude will provide pierce, stun and dismember immunity, however making you unable to regenerate wounds any way whatsoever\n\
		You will additionally gain resistance to both physical and stamina damage, scaling with level.\n\
		While using Fortitude, attempting to run will crush you, and you will be unable to heal while it is active.\n\
		At level 4, you gain complete stun immunity.\n\
		Higher levels will increase Brute and Stamina resistance."
	power_flags = BP_AM_TOGGLE|BP_AM_COSTLESS_UNCONSCIOUS
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY
	purchase_flags = BLOODSUCKER_CAN_BUY|VASSAL_CAN_BUY
	cooldown_time = 20 SECONDS
	bloodcost = 30
	constant_bloodcost = 0.2
	var/was_running
	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.
	var/list/trigger_listening = list()
	var/traits_to_add = list(TRAIT_PIERCEIMMUNE, TRAIT_NODISMEMBER, TRAIT_PUSHIMMUNE)

/datum/action/cooldown/bloodsucker/fortitude/ActivatePower(trigger_flags)
	. = ..()
	owner.balloon_alert(owner, "fortitude turned on.")
	to_chat(owner, span_notice("Your flesh, skin, and muscles become as steel."))
	// Traits & Effects
	owner.add_traits(traits_to_add, BLOODSUCKER_TRAIT)
	if(level_current >= 4)
		ADD_TRAIT(owner, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT) // They'll get stun resistance + this, who cares.
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_VASSAL(owner))
		fortitude_resist = max(0.3, 0.7 - level_current * 0.1)
		bloodsucker_user.physiology.brute_mod *= fortitude_resist
		bloodsucker_user.physiology.burn_mod *= fortitude_resist + 0.2
		bloodsucker_user.physiology.stamina_mod *= fortitude_resist

	was_running = (bloodsucker_user.move_intent == MOVE_INTENT_RUN)
	if(was_running)
		bloodsucker_user.toggle_move_intent()
	for(var/power in bloodsuckerdatum_power.powers)
		if(!istype(power, /datum/action/cooldown/bloodsucker/targeted/haste))
			continue
		RegisterSignal(power, COMSIG_FIRE_TARGETED_POWER, PROC_REF(on_action_trigger))
		trigger_listening += power
	RegisterSignal(owner, COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, PROC_REF(on_heal))
	RegisterSignal(owner, COMSIG_LIVING_ADJUST_BURN_DAMAGE, PROC_REF(on_heal))

/datum/action/cooldown/bloodsucker/fortitude/proc/on_heal(mob/current_mob, type, amount, forced)
	if(!forced && active && amount < 0)
		return COMPONENT_IGNORE_CHANGE
	return NONE

/datum/action/cooldown/bloodsucker/fortitude/proc/on_action_trigger(datum/action, mob/target)
	SIGNAL_HANDLER
	DeactivatePower()

/datum/action/cooldown/bloodsucker/fortitude/process(seconds_per_tick)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	if(!active)
		return
	var/mob/living/carbon/user = owner
	/// Prevents running while on Fortitude
	if(user.move_intent != MOVE_INTENT_WALK)
		user.toggle_move_intent()
		user.balloon_alert(user, "you attempt to run, crushing yourself.")
		user.adjustBruteLoss(rand(5,15))
	/// We don't want people using fortitude being able to use vehicles
	if(user.buckled && istype(user.buckled, /obj/vehicle))
		user.buckled.unbuckle_mob(src, force=TRUE)

/datum/action/cooldown/bloodsucker/fortitude/DeactivatePower()
	if(length(trigger_listening))
		for(var/power in trigger_listening)
			UnregisterSignal(power, COMSIG_FIRE_TARGETED_POWER)
			trigger_listening -= power
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_VASSAL(owner))
		bloodsucker_user.physiology.brute_mod /= fortitude_resist
		bloodsucker_user.physiology.burn_mod /= fortitude_resist + 0.2
		bloodsucker_user.physiology.stamina_mod /= fortitude_resist
	// Remove Traits & Effects
	owner.remove_traits(traits_to_add, BLOODSUCKER_TRAIT)

	if(was_running && bloodsucker_user.move_intent == MOVE_INTENT_WALK)
		bloodsucker_user.toggle_move_intent()
	owner.balloon_alert(owner, "fortitude turned off.")
	fortitude_resist = 1
	UnregisterSignal(owner, list(COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, COMSIG_LIVING_ADJUST_BURN_DAMAGE))
	return ..()
