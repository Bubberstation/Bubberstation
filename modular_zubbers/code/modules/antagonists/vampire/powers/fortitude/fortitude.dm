/datum/discipline/fortitude
	name = "Fortitude"
	discipline_explanation = "Fortitude is a Discipline that grants Kindred unearthly toughness."
	icon_state = "fortitude"

	// Lists of abilities granted per level
	level_1 = list(/datum/action/cooldown/vampire/fortitude)
	level_2 = list(/datum/action/cooldown/vampire/fortitude/two)
	level_3 = list(/datum/action/cooldown/vampire/fortitude/three)
	level_4 = list(/datum/action/cooldown/vampire/fortitude/four)
	level_5 = null
	vassal_power = /datum/action/cooldown/vampire/fortitude

/**
 *	FORTITUDE
 *	All levels: Incrementally increasing brute and stamina resistance.
 *	Level 1: Pierce resistance
 * 	Level 2: Push immunity
 * 	Level 3: Dismember resistance
 * 	Level 4: Complete stun immunity
 */

/datum/action/cooldown/vampire/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings."
	button_icon_state = "power_fortitude"
	power_explanation = "Grants increasing levels of brute and stamina resistance, as well as various immunities to physical harm.\n\
						At level 1: Gain pierce resistance.\n\
						At level 2: Gain push immunity.\n\
						At level 3: Gain dismember resistance.\n\
						At level 4: Gain complete stun immunity."
	vampire_power_flags = BP_AM_TOGGLE | BP_AM_COSTLESS_UNCONSCIOUS
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_IN_FRENZY | BP_CANT_USE_WHILE_STAKED
	check_flags = AB_CHECK_PHASED
	vitaecost = 50
	cooldown_time = 5 SECONDS
	constant_vitaecost = 1

	var/resistance = 0.8

	// Flags for what immunities to turn on at which level
	var/pierce = TRUE
	var/push = FALSE
	var/dismember = FALSE
	var/stun = FALSE

	var/calculated_burn_resist // do not touch
	var/calculated_stamina_resist // do not touch

/datum/action/cooldown/vampire/fortitude/two
	vitaecost = 40
	constant_vitaecost = 2
	resistance = 0.6
	pierce = TRUE
	push = TRUE

/datum/action/cooldown/vampire/fortitude/three
	vitaecost = 30
	constant_vitaecost = 3
	resistance = 0.4
	pierce = TRUE
	push = TRUE
	dismember = TRUE

/datum/action/cooldown/vampire/fortitude/four
	vitaecost = 20
	constant_vitaecost = 4
	resistance = 0.3
	pierce = TRUE
	push = TRUE
	dismember = TRUE
	stun = TRUE

/datum/action/cooldown/vampire/fortitude/get_power_explanation_extended()
	. = list()
	. += "While active you take [get_resist_percent(resistance)]% less brute damage, [get_resist_percent(get_stamina_resist())]% less stamina damage and [get_resist_percent(get_burn_resist())]% less burn damage."
	var/list/immunities = list()
	if(pierce)
		immunities += "piercing"
	if(push)
		immunities += "being pushed"
	if(dismember)
		immunities += "dismemberment"
	if(stun)
		immunities += "stuns"
	if(length(immunities))
		. += "You are also immune to [english_list(immunities)]."
	. += "At level 1: Gain pierce resistance."
	. += "At level 2: Gain push immunity."
	. += "At level 3: Gain dismember resistance."
	. += "At level 4: Gain complete stun immunity."

/datum/action/cooldown/vampire/fortitude/proc/get_resist_percent(damage_mod)
	return round((1 - damage_mod) * 100)

/// Stamina resistance is half as effective because they have it inherently.
/datum/action/cooldown/vampire/fortitude/proc/get_stamina_resist()
	return (1 + resistance) / 2

/// they get burn resistance, but way less
/datum/action/cooldown/vampire/fortitude/proc/get_burn_resist()
	return (2 + resistance) / 3

/datum/action/cooldown/vampire/fortitude/activate_power()
	. = ..()
	owner.balloon_alert(owner, "fortitude turned on.")
	to_chat(owner, span_notice("Your flesh has become as hard as steel!"))
	owner.playsound_local(null, 'modular_zubbers/sound/effects/vampires/fortitude_on.ogg', 100, FALSE, pressure_affected = FALSE)

	calculated_burn_resist = get_burn_resist()
	calculated_stamina_resist = get_stamina_resist()

	// Traits & Effects
	if(pierce)
		ADD_TRAIT(owner, TRAIT_PIERCEIMMUNE, REF(src))
	if(dismember)
		ADD_TRAIT(owner, TRAIT_NODISMEMBER, REF(src))
	if(push)
		ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, REF(src))
	if(stun)
		ADD_TRAIT(owner, TRAIT_STUNIMMUNE, REF(src)) // They'll get stun resistance + this, who cares.

	var/mob/living/carbon/human/user = owner
	MODIFY_PHYSIOLOGY(user, BRUTE, resistance)
	MODIFY_PHYSIOLOGY(user, STAMINA, calculated_stamina_resist)
	MODIFY_PHYSIOLOGY(user, BURN, calculated_burn_resist)

/datum/action/cooldown/vampire/fortitude/deactivate_power()
	if(!ishuman(owner) || !currently_active)
		return

	var/mob/living/carbon/human/vampire_user = owner
	MODIFY_PHYSIOLOGY(vampire_user, BRUTE, 1 / resistance)
	MODIFY_PHYSIOLOGY(vampire_user, BURN, 1 / calculated_burn_resist)
	MODIFY_PHYSIOLOGY(vampire_user, STAMINA, 1 / calculated_stamina_resist)

	// Remove Traits & Effects
	REMOVE_TRAITS_IN(owner, REF(src))

	owner.balloon_alert(owner, "fortitude turned off.")
	owner.playsound_local(null, 'modular_zubbers/sound/effects/vampires/fortitude_off.ogg', 100, FALSE, pressure_affected = FALSE)

	return ..()
