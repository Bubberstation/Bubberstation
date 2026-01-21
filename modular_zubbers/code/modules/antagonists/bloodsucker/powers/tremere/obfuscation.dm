/**
 *	# Obfuscation
 *
 *	Level 1 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 2 tile)
 *	Level 2 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 3 tiles)
 *	Level 3 - Cloak of Darkness until clicking an area, teleports the user to the selected area
 *	Level 4 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to bleed.
 *	Level 5 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to be knocked down.
 */

#define OBFUSCATION_BLOOD_COST_PER_TILE 5
#define OBFUSCATION_BLEED_LEVEL 4
#define OBFUSCATION_KNOCKDOWN_LEVEL 5
#define OBFUSCATION_ANYWHERE_LEVEL 6

#define OBFUSCATION_HIDDEN_ALPHA 22
#define OBFUSCATION_REVEALED_ALPHA 255
#define OBFUSCATION_RECLOAK_TIME (4 SECONDS)

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation
	name = "Obfuscation"
	level_current = 1
	button_icon_state = "power_obfuscation"
	purchase_flags = TREMERE_CAN_BUY
	bloodcost = 10
	constant_bloodcost = 2
	cooldown_time = 12 SECONDS
	target_range = 2
	power_activates_immediately = FALSE
	prefire_message = "Right click to teleport"
	/// If the cloak has currently been weakened/revealed by the user being attacked or attacking.
	var/revealed = FALSE
	/// The timer to turn near-invisible again after being revealed.
	var/recloak_timer
	/// signals to reveal on if received
	var/list/reveal_signals = list(
		COMSIG_ATOM_WAS_ATTACKED,
		COMSIG_USER_ITEM_INTERACTION,
		COMSIG_USER_ITEM_INTERACTION_SECONDARY,
		COMSIG_LIVING_UNARMED_ATTACK,
		COMSIG_MOB_ITEM_ATTACK,
		COMSIG_ATOM_ATTACKBY,
		COMSIG_ATOM_ATTACK_HAND,
		COMSIG_ATOM_HITBY,
		COMSIG_ATOM_HULK_ATTACK,
		COMSIG_ATOM_ATTACK_PAW,
		COMSIG_CARBON_CUFF_ATTEMPTED,
	)

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/on_power_upgrade()
	// 1 + for default, the other + is for the upgrade that hasn't been added yet.
	if(level_current >= OBFUSCATION_ANYWHERE_LEVEL)
		target_range = 0
	else
		target_range = min(level_current + 2, 10)
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/get_power_desc_extended()
	. = "Hide yourself within a Cloak of Darkness, click on a tile to teleport"
	. += "Your cloak will become far more visible if you attack or are attacked."
	. += "Costs [OBFUSCATION_BLOOD_COST_PER_TILE] blood per tile teleported."
	if(target_range)
		. += " up to [target_range] tiles away."
	else
		. += " anywhere you can see."
	if(level_current >= OBFUSCATION_BLEED_LEVEL)
		if(level_current >= OBFUSCATION_KNOCKDOWN_LEVEL)
			. += " This will cause people at your destination to start bleeding and knock them down."
		else
			. += " This will cause people at your destination to start bleeding."

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/get_power_explanation_extended()
	. = list()
	. += "When Activated, you will be hidden in a Cloak of Darkness."
	. += "Your cloak will become far more visible if you attack or are attacked."
	. += "[target_range ? "Click to teleport up to [target_range] tiles away, as long as you can see it" : "You can teleport anywhere you can see"]."
	. += "At level [OBFUSCATION_BLEED_LEVEL] you will cause people at your end location to start bleeding."
	. += "At level [OBFUSCATION_KNOCKDOWN_LEVEL] you will cause people at your end location to be knocked down."
	. += "At level [OBFUSCATION_ANYWHERE_LEVEL] you will be able to teleport anywhere, even if you cannot properly see the tile."
	. += "The power will cost [OBFUSCATION_BLOOD_COST_PER_TILE] blood per tile that you teleport."

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	var/turf/target_turf = get_turf(target_atom)
	if(!target_turf || target_turf.is_blocked_turf_ignore_climbable())
		return FALSE
	if(level_current < OBFUSCATION_ANYWHERE_LEVEL && !(target_turf in view(owner.client.view, owner.client)))
		owner.balloon_alert(owner, "out of view!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/ActivatePower(trigger_flags)
	. = ..()
	revealed = FALSE
	owner.AddElement(/datum/element/relay_attackers)
	RegisterSignals(owner, reveal_signals, PROC_REF(reveal))

	ADD_TRAIT(owner, TRAIT_UNKNOWN_APPEARANCE, REF(src))
	owner.AddElement(/datum/element/digitalcamo)
	animate(owner, alpha = OBFUSCATION_HIDDEN_ALPHA, time = 2 SECONDS)

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/DeactivatePower(deactivate_flags)
	..()
	UnregisterSignal(owner, reveal_signals)
	if(recloak_timer)
		deltimer(recloak_timer)
		recloak_timer = null
	REMOVE_TRAIT(owner, TRAIT_UNKNOWN_APPEARANCE, REF(src))
	animate(owner, alpha = 255, time = 2 SECONDS)
	owner.RemoveElement(/datum/element/relay_attackers)
	owner.RemoveElement(/datum/element/digitalcamo)
	revealed = FALSE

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/FireTargetedPower(atom/target_atom)
	return FALSE

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/FireSecondaryTargetedPower(atom/target, params)
	. = ..()
	obfuscation_blink(owner, get_turf(target))
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/proc/reveal()
	if(!active)
		CRASH("reveal() somehow called while ability is inactive?")
	if(!revealed)
		revealed = TRUE
		animate(owner, alpha = OBFUSCATION_REVEALED_ALPHA, time = 2 SECONDS)
	recloak_timer = addtimer(CALLBACK(src, PROC_REF(recloak)), get_recloak_time(), TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/proc/get_recloak_time()
	return min(0.5 SECONDS, OBFUSCATION_RECLOAK_TIME - 0.5 SECONDS * level_current)

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/proc/recloak()
	if(!active)
		CRASH("recloak() somehow called while ability is inactive?")
	recloak_timer = null
	revealed = FALSE
	animate(owner, alpha = OBFUSCATION_HIDDEN_ALPHA, time = 2 SECONDS)

/datum/action/cooldown/bloodsucker/targeted/tremere/obfuscation/proc/obfuscation_blink(mob/living/user, turf/targeted_turf)
	var/blood_cost = min(OBFUSCATION_BLOOD_COST_PER_TILE * get_dist(user, targeted_turf), 100)
	if(!can_pay_cost(blood_cost))
		owner.balloon_alert(owner, "not enough blood!")
		return
	playsound(user, 'sound/effects/magic/summon_karp.ogg', 60)
	playsound(targeted_turf, 'sound/effects/magic/summon_karp.ogg', 60)

	new /obj/effect/particle_effect/fluid/smoke/vampsmoke(user.drop_location())
	new /obj/effect/particle_effect/fluid/smoke/vampsmoke(targeted_turf)

	for(var/mob/living/carbon/living_mob in range(1, targeted_turf)-user)
		if(IS_BLOODSUCKER(living_mob) || IS_GHOUL(living_mob))
			continue
		if(living_mob.can_block_magic(BLOODSUCKER_ANTIMAGIC))
			continue
		if(level_current >= OBFUSCATION_BLEED_LEVEL)
			var/obj/item/bodypart/bodypart = pick(living_mob.bodyparts)
			var/severity = pick(WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_CRITICAL)
			living_mob.cause_wound_of_type_and_severity(WOUND_SLASH, bodypart, severity, wound_source = "obfuscation")
			living_mob.adjust_brute_loss(15)
		if(level_current >= OBFUSCATION_KNOCKDOWN_LEVEL)
			living_mob.Knockdown(10 SECONDS, ignore_canstun = TRUE)

	do_teleport(owner, targeted_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)

	power_activated_successfully(cost_override = blood_cost)

#undef OBFUSCATION_RECLOAK_TIME
#undef OBFUSCATION_REVEALED_ALPHA
#undef OBFUSCATION_HIDDEN_ALPHA
#undef OBFUSCATION_BLOOD_COST_PER_TILE
#undef OBFUSCATION_BLEED_LEVEL
#undef OBFUSCATION_KNOCKDOWN_LEVEL
#undef OBFUSCATION_ANYWHERE_LEVEL
