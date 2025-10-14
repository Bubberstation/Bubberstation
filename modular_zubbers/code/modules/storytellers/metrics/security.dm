/datum/storyteller_metric/security_status
	name = "Security Status Aggregation"

/datum/storyteller_metric/security_status/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return inputs.player_count > 0

/datum/storyteller_metric/security_status/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	..()
	var/active_sec = 0
	var/total_gear_score = 0

	// Scan security mobs
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(!H.mind || !H.client)
			continue
		// TODO: Intventory check for gear quality, now it's placeholder
		var/datum/job/job = H.mind.assigned_role
		if(istype(job, /datum/job/security_officer) || istype(job, /datum/job/head_of_security) || istype(job, /datum/job/warden))
			active_sec++
			var/gear_points = 0
			if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/armor))
				gear_points += 2
			if(H.belt && istype(H.belt, /obj/item/storage/belt/security))
				gear_points += 1
			if(H.get_active_held_item() && istype(H.get_active_held_item(), /obj/item/gun) || istype(H.get_active_held_item(), /obj/item/melee/baton))
				gear_points += 1
			total_gear_score += clamp(gear_points / 4, 0, 1)  // Normalize per officer


	// Calculate strength level (0 no sec -> 3 strong)
	var/avg_gear = active_sec > 0 ? total_gear_score / active_sec : 0
	var/sec_strength = clamp((active_sec / max(1, inputs.player_count * 0.1)) + avg_gear, 0, 3)  // Scale to crew

	// Alert level from SSsecurity_level
	var/alert_level = SSsecurity_level.current_security_level || STORY_VAULT_GREEN_ALERT  // 0 green -> 3 delta
	var/real_level
	if(istype(alert_level, /datum/security_level/green))
		real_level = STORY_VAULT_GREEN_ALERT
	else if(istype(alert_level, /datum/security_level/blue))
		real_level = STORY_VAULT_BLUE_ALERT
	else if(istype(alert_level, /datum/security_level/red))
		real_level = STORY_VAULT_RED_ALERT
	else if(istype(alert_level, /datum/security_level/delta))
		real_level = STORY_VAULT_DELTA_ALERT
	else
		real_level = STORY_VAULT_GREEN_ALERT // Fallback


	inputs.vault[STORY_VAULT_SECURITY_STRENGTH] = round(sec_strength)
	inputs.vault[STORY_VAULT_SECURITY_ALERT] = real_level
	return
