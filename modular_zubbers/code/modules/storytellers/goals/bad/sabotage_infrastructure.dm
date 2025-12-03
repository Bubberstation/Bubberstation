/datum/round_event_control/sabotage_infrastructure
	id = "sabotage_infrastructure"
	name = "Sabotage Infrastructure"
	description = "Sabotage the station machinery."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_TARGETS_SYSTEMS
	typepath =  /datum/round_event/sabotage_machinery

	min_players = 4
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY


/datum/round_event/sabotage_machinery
	STORYTELLER_EVENT

	var/list/candidate_types = list(
		/obj/machinery/rnd,
		/obj/machinery/recharger,
		/obj/machinery/autolathe,
		/obj/machinery/power/smes,
		/obj/machinery/vending,
	)
	var/damage_level = 0
	var/target_damage_percent = 0
	var/num_targets_per_type = 1
	var/explosive_sabotage_chance = 0

/datum/round_event/sabotage_machinery/__setup_for_storyteller(threat_points)
	. = ..()

	if(threat_points < STORY_THREAT_LOW)
		damage_level = 1
		target_damage_percent = 25
		num_targets_per_type = 1
		explosive_sabotage_chance = 0
	else if(threat_points < STORY_THREAT_MODERATE)
		damage_level = 2
		target_damage_percent = 40
		num_targets_per_type = 2
		explosive_sabotage_chance = 5
	else if(threat_points < STORY_THREAT_HIGH)
		damage_level = 3
		target_damage_percent = 60
		num_targets_per_type = 3
		explosive_sabotage_chance = 15
	else if(threat_points < STORY_THREAT_EXTREME)
		damage_level = 4
		target_damage_percent = 75
		num_targets_per_type = 5
		explosive_sabotage_chance = 30
	else
		damage_level = 5
		target_damage_percent = 90
		num_targets_per_type = 8
		explosive_sabotage_chance = 50


	num_targets_per_type = min(num_targets_per_type + round(threat_points / 1000), rand(10, 20))

/datum/round_event/sabotage_machinery/__announce_for_storyteller()
	priority_announce("Sensors detect anomalies in power systems. Equipment inspection recommended.", "Warning: Infrastructure")

/datum/round_event/sabotage_machinery/__start_for_storyteller()
	. = ..()

	for(var/machine_type in candidate_types)
		var/list/candidates = list()
		for(var/obj/machinery/machine in SSmachines.get_all_machines())
			if(istype(machine, machine_type) && machine.max_integrity > 0)
				candidates += machine

		if(!length(candidates))
			continue

		// Select random targets
		var/num_to_sabotage = min(num_targets_per_type, length(candidates))
		candidates = candidates.Copy(1, num_to_sabotage + 1)

		for(var/obj/machinery/target in candidates)
			var/actual_damage = round(target.max_integrity * (target_damage_percent / 100))
			if(actual_damage > 0)
				new /obj/effect/particle_effect/sparks(get_turf(target))

				if(prob(50))
					target.take_damage(actual_damage, BRUTE)
				else
					target.atom_break()

				if(damage_level >= 3 && prob(explosive_sabotage_chance) || istype(target, /obj/machinery/power/smes))
					target.ex_act(EXPLODE_LIGHT)
					log_game("Storyteller: Sabotage explosion at [target.loc] (threat: [damage_level])")
