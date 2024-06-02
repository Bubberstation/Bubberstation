/**
 *	# Auspex
 *
 *	Level 1 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 2 tile)
 *	Level 2 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 3 tiles)
 *	Level 3 - Cloak of Darkness until clicking an area, teleports the user to the selected area
 *	Level 4 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to bleed.
 *	Level 5 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to fall asleep.
 */

// Look to /datum/action/cooldown/spell/pointed/void_phase for help.
#define AUSPEX_BLOOD_COST_PER_TILE 5
/datum/action/cooldown/bloodsucker/targeted/tremere/auspex
	name = "Auspex"
	level_current = 1
	button_icon_state = "power_auspex"
	check_flags = BP_CANT_USE_IN_TORPOR|AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS
	bloodcost = 10
	constant_bloodcost = 1
	cooldown_time = 12 SECONDS
	target_range = 2
	prefire_message = "Right click to teleport"

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/upgrade_power()
	// 1 + for default, the other + is for the upgrade that hasn't been added yet.
	target_range = min(level_current + 2, 10)
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/get_power_desc()
	. = ..()
	var/old_desc = .
	return "Hide yourself within a Cloak of Darkness, click on an area to teleport\
		[target_range ? " up to [target_range] tiles" : ""]\
		[level_current >= 4 ? " ending the Power and causing people at your end location to start bleeding" : ""]\
		[level_current >= 5 ? " and fall asleep." : "."]\n\
		[old_desc]"

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/get_power_explanation()
	return "Level [level_current]: [src]:\n\
		When Activated, you will be hidden in a Cloak of Darkness.\n\
		[target_range ? "Click to teleport up to [target_range] tiles away, as long as you can see it" : "You can teleport anywhere you can see"].\n\
		Teleporting will refill your stamina to full.\n\
		At level 4 you will cause people at your end location to start bleeding.\n\
		At level 5 you will cause people at your end location to fall asleep. \n\
		The power will cost [AUSPEX_BLOOD_COST_PER_TILE] blood per tile that you teleport."

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	if(!isturf(target_atom))
		return FALSE
	var/turf/target_turf = target_atom
	if(target_turf.is_blocked_turf_ignore_climbable())
		return FALSE
	if(!(target_turf in view(owner.client.view, owner)))
		owner.balloon_alert(owner, "out of view!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/ActivatePower(trigger_flags)
	. = ..()
	owner.AddElement(/datum/element/digitalcamo)
	animate(owner, alpha = 15, time = 1 SECONDS)

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/DeactivatePower()
	animate(owner, alpha = 255, time = 1 SECONDS)
	owner.RemoveElement(/datum/element/digitalcamo)
	return ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/FireSecondaryTargetedPower(atom/target, params)
	. = ..()
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(target)
	auspex_blink(user, targeted_turf)

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/proc/auspex_blink(mob/living/user, turf/targeted_turf)
	var/blood_cost = -AUSPEX_BLOOD_COST_PER_TILE * get_dist(user, targeted_turf)
	if(!can_pay_blood(blood_cost))
		owner.balloon_alert(owner, "not enough blood!")
		return
	playsound(user, 'sound/magic/summon_karp.ogg', 60)
	playsound(targeted_turf, 'sound/magic/summon_karp.ogg', 60)

	new /obj/effect/particle_effect/fluid/smoke/vampsmoke(user.drop_location())
	new /obj/effect/particle_effect/fluid/smoke/vampsmoke(targeted_turf)

	for(var/mob/living/carbon/living_mob in range(1, targeted_turf)-user)
		if(IS_BLOODSUCKER(living_mob) || IS_VASSAL(living_mob))
			continue
		if(level_current >= 4)
			var/obj/item/bodypart/bodypart = pick(living_mob.bodyparts)
			bodypart.force_wound_upwards(/datum/wound/slash/flesh/critical)
			living_mob.adjustBruteLoss(15)
		if(level_current >= 5)
			living_mob.Knockdown(10 SECONDS, ignore_canstun = TRUE)
	
	do_teleport(owner, targeted_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
	user.adjustStaminaLoss(-user.staminaloss)
	PowerActivatedSuccesfully(cost_override = blood_cost)
