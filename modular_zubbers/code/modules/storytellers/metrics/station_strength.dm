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

		// Job importance modifiers (cumulative)
		if(job.story_tags & STORY_JOB_IMPORTANT)
			mod += 0.3  // Important jobs add value
		if(job.story_tags & STORY_JOB_HEAVYWEIGHT)
			mod += 0.5  // Heavyweight jobs are more valuable
		if(job.story_tags & STORY_JOB_COMBAT)
			mod += 0.25  // Combat roles add effectiveness
		if(job.story_tags & STORY_JOB_ANTAG_MAGNET)
			mod += 0.4  // Antag magnets are important targets
		if(job.story_tags & STORY_JOB_SECURITY)
			mod += 0.35  // Security adds direct combat value

		// Health modifier - healthy crew members are more effective
		var/health_mod = 1.0
		if(crew.health > 80)
			health_mod = 1.2  // Very healthy crew
		else if(crew.health > 50)
			health_mod = 1.0  // Normal health
		else if(crew.health > 25)
			health_mod = 0.8  // Injured crew
		else
			health_mod = 0.5  // Critically injured

		// Equipment scoring (improved)
		for(var/obj/item/item in get_inventory(crew, TRUE))
			if(istype(item, /obj/item/gun))
				gear_score += 6  // Guns are powerful tools
			if(istype(item, /obj/item/melee))
				gear_score += 4  // Melee weapons add combat value
			if(istype(item, /obj/item/stack/medical))
				gear_score += 1.5  // Medical supplies are valuable
			if(istype(item, /obj/item/clothing/suit/armor))
				gear_score += 3  // Armor provides protection value
			if(istype(item, /obj/item/clothing/head/helmet))
				gear_score += 2  // Helmets add protection

		// MOD suits provide significant bonus
		if(istype(crew.back, /obj/item/mod))
			gear_score += 5  // MOD suits are powerful equipment

		// Experience and skill modifiers (if available)
		var/skill_mod = 1.0
		if(crew.mind && crew.mind.assigned_role)
			// Check for job importance and experience
			// More experienced/important crew members are more effective
			var/datum/job/job_role = crew.mind.assigned_role
			if(job_role.story_tags & STORY_JOB_IMPORTANT)
				skill_mod = 1.15  // Important crew members are more valuable
			if(job_role.story_tags & STORY_JOB_HEAVYWEIGHT)
				skill_mod = max(skill_mod, 1.2)  // Heavyweight jobs are highly valuable

		total_gear_points += gear_score

		// Calculate final crew weight: (base job weight * modifiers) + equipment, scaled by health and skill
		var/base_weight = job.story_weight * mod
		var/final_weight = (base_weight + gear_score) * health_mod * skill_mod
		total_crew_weight += clamp(round(final_weight), 1, STORY_MAJOR_ANTAG_WEIGHT * 1.5)
		if(is_security)
			total_security_gear_points += gear_score


	if(total_crew_count > 0)
		inputs.vault[STORY_VAULT_CREW_READINESS] = clamp((total_gear_points / total_crew_count) * 0.3, 0, 3)
		inputs.set_entry(STORY_VAULT_CREW_WEIGHT, total_crew_weight / total_crew_count)
	if(total_security > 0)
		inputs.vault[STORY_VAULT_SECURITY_STRENGTH] = clamp((total_gear_points / total_security) * 1.3, 0, 3)
		inputs.vault[STORY_VAULT_SECURITY_COUNT] = total_security

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
