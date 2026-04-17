/datum/action/cooldown/spell/pointed/unsettle
	stun_time = 3 SECONDS

/mob/living/basic/voidwalker

	var/brute_damage_lower = 24
	var/brute_damage_upper = 30

/mob/living/basic/voidwalker/early_melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!. || !can_do_abductions)
		return

	if(ishuman(target))
		var/mob/living/carbon/human/hewmon = target

		var/should_attack = try_kidnap(hewmon)

		// Marks the victim with nodeath
		hewmon.apply_status_effect(/datum/status_effect/void_chomped)

		if(!should_attack)
			return FALSE

		if(hewmon.stat == HARD_CRIT && !hewmon.has_trauma_type(/datum/brain_trauma/voided))
			hewmon.balloon_alert(src, "is in crit!")
			hewmon.Stun(5 SECONDS) // blocks some crit movement mechanics from a bunch of sources
			return FALSE

	// left click
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		melee_damage_lower = initial(melee_damage_lower)
		melee_damage_upper = initial(melee_damage_upper)
		melee_damage_type = ishuman(target) ? initial(melee_damage_type) : rclick_damage_type

	// Right click
	else
		melee_damage_lower = brute_damage_lower
		melee_damage_upper = brute_damage_upper
		melee_damage_type = rclick_damage_type

		if(!istype(target, /turf/closed/wall))
			return
		INVOKE_ASYNC(src, PROC_REF(try_convert_wall), target)
	return TRUE

/mob/living/basic/voidwalker/check_wall_validity(turf/closed/wall/wall_to_check, silent = TRUE)
	return TRUE
