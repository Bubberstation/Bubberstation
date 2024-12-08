//* Raw Damage *//

/mob/living/silicon/robot/heal_overall_damage(brute = 0, burn = 0, stamina = 0, required_bodytype, updating_health = TRUE, forced = FALSE)
	var/list/datum/robot_component/parts = get_damaged_components(brute,burn)

	while(parts.len && (brute>0 || burn>0) )
		var/datum/robot_component/picked = pick(parts)

		var/brute_was = picked.brute_damage
		var/burn_was = picked.electronics_damage

		picked.heal_damage(brute,burn)

		brute -= (brute_was-picked.brute_damage)
		burn -= (burn_was-picked.electronics_damage)

		parts -= picked
	updatehealth()

/mob/living/silicon/robot/take_overall_damage(brute = 0, burn = 0, stamina = 0, required_bodytype, updating_health = TRUE, forced = FALSE)
	if(status_flags & GODMODE)	return	//godmode
	var/list/datum/robot_component/parts = get_damageable_components()

	var/datum/robot_component/armour/A = get_armour()
	if(A)
		A.take_damage(brute,burn)
	else
		while(parts.len && (brute>0 || burn>0) )
			var/datum/robot_component/picked = pick(parts)

			var/brute_was = picked.brute_damage
			var/burn_was = picked.electronics_damage

			picked.take_damage(brute,burn)

			brute	-= (picked.brute_damage - brute_was)
			burn	-= (picked.electronics_damage - burn_was)

			parts -= picked
	updatehealth()
