#define FORTITUDE_STUN_IMMUNITY_LEVEL 4
/datum/action/cooldown/bloodsucker/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings, but will render you unable to heal."
	button_icon_state = "power_fortitude"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_COSTLESS_UNCONSCIOUS
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	cooldown_time = 20 SECONDS
	bloodcost = 30
	constant_bloodcost = 0.2
	var/was_running
	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.
	var/list/trigger_listening = list()
	var/traits_to_add = list(TRAIT_PIERCEIMMUNE, TRAIT_NODISMEMBER, TRAIT_PUSHIMMUNE)

/datum/action/cooldown/bloodsucker/fortitude/get_power_explanation_extended()
	. = list()
	. += "Fortitude will provide pierce, stun and dismember immunity."
	. += "You will additionally gain resistance to both brute, burn and stamina damage, scaling with level."
	. += "Fortitude will make you receive [GetFortitudeResist() * 10]% less brute and and stamina and [GetBurnResist() * 10]% less burn damage."
	. += "While using Fortitude, attempting to run will crush you."
	. += "At level [FORTITUDE_STUN_IMMUNITY_LEVEL], you gain complete stun immunity."
	. += "Higher levels will increase Brute and Stamina resistance."

/datum/action/cooldown/bloodsucker/fortitude/ActivatePower(atom/target)
	owner.balloon_alert(owner, "fortitude turned on.")
	to_chat(owner, span_notice("Your flesh, skin, and muscles become as steel."))
	// Traits & Effects
	owner.add_traits(traits_to_add, BLOODSUCKER_TRAIT)
	if(level_current >= FORTITUDE_STUN_IMMUNITY_LEVEL)
		ADD_TRAIT(owner, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_GHOUL(owner))
		fortitude_resist = GetFortitudeResist()
		bloodsucker_user.physiology.brute_mod *= fortitude_resist
		bloodsucker_user.physiology.burn_mod *= GetBurnResist()
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
	return TRUE

/datum/action/cooldown/bloodsucker/fortitude/proc/on_heal(mob/current_mob, type, amount, forced)
	if(!forced && active && amount < 0)
		return COMPONENT_IGNORE_CHANGE
	return NONE

/datum/action/cooldown/bloodsucker/fortitude/proc/on_action_trigger(datum/action, mob/target)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(DeactivatePower)), 1 SECONDS)
	return TRUE

/datum/action/cooldown/bloodsucker/fortitude/proc/GetFortitudeResist()
	return max(0.3, 0.7 - level_current * 0.05)

/datum/action/cooldown/bloodsucker/fortitude/proc/GetBurnResist()
	return GetFortitudeResist() + 0.2

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
		user.adjust_brute_loss(rand(5,15))
	/// We don't want people using fortitude being able to use vehicles
	if(user.buckled && istype(user.buckled, /obj/vehicle))
		user.buckled.unbuckle_mob(src, force=TRUE)

/datum/action/cooldown/bloodsucker/fortitude/DeactivatePower(deactivate_flags)
	if(length(trigger_listening))
		for(var/power in trigger_listening)
			UnregisterSignal(power, COMSIG_FIRE_TARGETED_POWER)
			trigger_listening -= power
	. = ..()
	if(!. || !ishuman(owner))
		return
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_GHOUL(owner) && fortitude_resist)
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

#undef FORTITUDE_STUN_IMMUNITY_LEVEL
