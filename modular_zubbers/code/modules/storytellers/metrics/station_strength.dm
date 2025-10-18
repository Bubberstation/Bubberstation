/datum/storyteller_metric/crew_strength

	name = "Overral Station strength"

/datum/storyteller_metric/crew_strength/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/total_crew_count = 0
	var/total_security = 0
	var/total_security_gear_points = 0
	var/total_crew_weight = 0
	var/total_gear_points = 0


	for(var/mob/living/carbon/human/crew in get_alive_crew())
		if(crew.is_antag())
			continue
		var/datum/job/job = crew.mind.assigned_role
		if(!job)
			continue
		var/is_security = job.story_tags & STORY_JOB_SECURITY
		total_crew_count += 1
		if(is_security)
			total_security += 1


		var/gear_score = 0
		var/mod = 1
		if(job.story_tags & STORY_JOB_HEAVYWEIGHT)
			mod += 0.4
		if(job.story_tags & STORY_JOB_COMBAT)
			mod += 0.2
		if(job.story_tags & STORY_JOB_ANTAG_MAGNET)
			mod += 0.6

		// TODO: add to item gear score
		for(var/obj/item/item in get_inventory(crew, TRUE))
			if(istype(item, /obj/item/gun))
				gear_score += 5
			if(istype(item, /obj/item/melee))
				gear_score += 3
			if(istype(item, /obj/item/stack/medical))
				gear_score += 1
		if(istype(crew.back, /obj/item/mod))
			gear_score += 3
		total_gear_points += gear_score
		total_crew_weight += clamp(round((job.story_weight * mod) + gear_score), 1, STORY_MAJOR_ANTAG_WEIGHT)
		if(is_security)
			total_security_gear_points += gear_score


	if(total_crew_count > 0)
		inputs.vault[STORY_VAULT_CREW_READINESS] = clamp((total_gear_points / total_crew_count) * 0.3, 0, 3)
		inputs.set_entry(STORY_VAULT_CREW_WEIGHT, total_crew_weight / total_crew_count)
	if(total_security > 0)
		inputs.vault[STORY_VAULT_SECURITY_STRENGTH] = clamp((total_gear_points / total_security) * 1.3, 0, 3)
		inputs.vault[STORY_VAULT_SECURITY_COUNT] = total_security



	// TODO: remove this
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
		real_level = STORY_VAULT_GREEN_ALERT
	inputs.vault[STORY_VAULT_SECURITY_ALERT] = real_level
	..()
