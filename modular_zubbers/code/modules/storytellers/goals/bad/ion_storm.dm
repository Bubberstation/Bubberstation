/datum/storyteller_goal/execute_event/ion_storm
	id = "negative_ion_storm"
	name = "Ion Storm"
	desc = "Triggers an ion storm, disable and damage electronics and synthetics."
	children = list()
	category = STORY_GOAL_BAD
	tags = STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_TARGETS_SYSTEMS
	event_path = /datum/round_event/ion_storm

/datum/storyteller_goal/execute_event/ion_storm/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_WEIGHT * 0.5 // We are rare


/datum/round_event/ion_storm
	allow_random = FALSE

	var/harm_door_chance = 30
	var/harm_synthetics_chance = 20
	var/harm_prosthesis_chance = 10
	var/emp_machinery_chance = 10
	var/waves = 1
	var/wave_delay = 3 MINUTES

	COOLDOWN_DECLARE(ion_storm_wave)

/datum/round_event/ion_storm/__setup_for_storyteller(threat_points, ...)
	. = ..()
	if(threat_points < STORY_THREAT_MODERATE)
		replaceLawsetChance = 10
		removeRandomLawChance = 5
		removeDontImproveChance = 5
		shuffleLawsChance = 5
		waves = 1
		harm_door_chance = 30
		harm_synthetics_chance = 10
		harm_prosthesis_chance = 5
		emp_machinery_chance = 5
	else if(threat_points < STORY_THREAT_HIGH)
		replaceLawsetChance = 25
		removeRandomLawChance = 25
		removeDontImproveChance = 40
		shuffleLawsChance = 30
		waves = 2
		harm_door_chance = 45
		harm_synthetics_chance = 30
		harm_prosthesis_chance = 30
		emp_machinery_chance = 20
	else if(threat_points < STORY_THREAT_EXTREME)
		replaceLawsetChance = 40
		removeRandomLawChance = 50
		removeDontImproveChance = 40
		shuffleLawsChance = 40
		waves = 2
		harm_door_chance = 60
		harm_synthetics_chance = 50
		harm_prosthesis_chance = 50
		emp_machinery_chance = 40
		botEmagChance = 5
	else
		replaceLawsetChance = 60
		removeRandomLawChance = 60
		removeDontImproveChance = 70
		shuffleLawsChance = 60
		waves = 3
		wave_delay = 2 MINUTES
		harm_door_chance = 100
		harm_synthetics_chance = 100
		harm_prosthesis_chance = 80
		emp_machinery_chance = 80
		botEmagChance = 15

	end_when = waves * wave_delay

/datum/round_event/ion_storm/__start_for_storyteller()
	COOLDOWN_START(src, ion_storm_wave, wave_delay)
	SSsecurity_level.set_level(SEC_LEVEL_RED, FALSE)
	var/announce_msg = "ATTENTION: An ion storm is approaching [station_name()]! \
					Immediately evacuate to the nearest planetoid for the duration of the storm. \
					Await further instructions for return."
	priority_announce(announce_msg, "Ion storm alert", ANNOUNCEMENT_TYPE_PRIORITY)

/datum/round_event/ion_storm/__storyteller_tick(seconds_per_tick)
	. = ..()
	if(waves <= 0)
		return __end_for_storyteller()

	if(!COOLDOWN_FINISHED(src, ion_storm_wave))
		return
	waves -= 1
	ion_storm_wave()
	COOLDOWN_START(src, ion_storm_wave, wave_delay)

/datum/round_event/ion_storm/__end_for_storyteller()
	priority_announce("The ion storm has passed [station_name()], systems are returning to normal.", "The ion storm has passed", ANNOUNCEMENT_TYPE_PRIORITY)
	SSsecurity_level.set_level(SEC_LEVEL_GREEN, FALSE)


/datum/round_event/ion_storm/proc/ion_storm_wave()
	var/list/station_z_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	var/list/station_z_values = list()
	for(var/datum/space_level/level in station_z_levels)
		station_z_values += level.z_value

	var/list/station_ais = list()
	var/list/station_bots = list()
	var/list/station_synthetics = list()
	var/list/station_humans = list()
	var/list/station_apcs = list()
	var/list/station_smes = list()
	var/list/station_doors = list()


	for(var/mob/living/M in GLOB.alive_mob_list)
		if(!is_station_level(M.z))
			continue
		if(istype(M, /mob/living/silicon/ai))
			station_ais += M
		else if(istype(M, /mob/living/simple_animal/bot))
			station_bots += M
		else if(istype(M, /mob/living/silicon))
			station_synthetics += M
		else if(istype(M, /mob/living/carbon/human))
			station_humans += M

	for(var/obj/machinery/machine in SSmachines.get_all_machines())
		if(!is_station_level(machine.z))
			continue
		if(istype(machine, /obj/machinery/power/apc))
			station_apcs += machine
		else if(istype(machine, /obj/machinery/power/smes))
			station_smes += machine
		else if(istype(machine, /obj/machinery/door/airlock))
			station_doors += machine

	for(var/mob/living/silicon/ai/ai_mob in station_ais)
		ai_mob.laws_sanity_check()
		if(ai_mob.stat == DEAD)
			continue

		if(prob(replaceLawsetChance))
			var/ion_lawset_type = pick_weighted_lawset()
			var/datum/ai_laws/ion_lawset = new ion_lawset_type()
			ai_mob.laws.inherent = ion_lawset.inherent.Copy()
			qdel(ion_lawset)

		if(prob(removeRandomLawChance))
			ai_mob.remove_law(rand(1, ai_mob.laws.get_law_amount(list(LAW_INHERENT, LAW_SUPPLIED))))

		var/message = ionMessage || generate_ion_law()
		if(message)
			if(prob(removeDontImproveChance))
				ai_mob.replace_random_law(message, list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION), LAW_ION)
			else
				ai_mob.add_ion_law(message)

		if(prob(shuffleLawsChance))
			ai_mob.shuffle_laws(list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION))

		log_silicon("Ion storm changed laws of [key_name(ai_mob)] to [english_list(ai_mob.laws.get_law_list(TRUE, TRUE))]")
		ai_mob.post_lawchange()

	if(botEmagChance)
		for(var/mob/living/simple_animal/bot/bot in station_bots)
			if(prob(botEmagChance))
				bot.emag_act()

	if(harm_door_chance)
		for(var/obj/machinery/door/airlock/airlock in station_doors)
			if(prob(harm_door_chance))
				airlock.set_anchored(!airlock.anchored)
				airlock.set_electrified(30 SECONDS)

	if(emp_machinery_chance)
		for(var/obj/machinery/power/apc/apc in station_apcs)
			if(!(apc.z in station_z_values))
				continue
			apc.overload_lighting()
		for(var/obj/machinery/power/smes/smes in station_smes)
			if(prob(emp_machinery_chance))
				smes.emp_act()
				smes.adjust_charge(-(STANDARD_BATTERY_CHARGE * rand(1-10)))
	if(harm_synthetics_chance)
		for(var/mob/living/silicon/synthetic in station_synthetics)
			if(prob(harm_synthetics_chance))
				synthetic.emp_act(rand(1, 2))

	if(harm_prosthesis_chance)
		for(var/mob/living/carbon/human/human in station_humans)
			var/has_prosthesis = FALSE
			for(var/obj/item/bodypart/limb in human.bodyparts)
				if(limb.bodytype & BODYTYPE_ROBOTIC)
					has_prosthesis = TRUE
					break
			if(!has_prosthesis)
				for(var/obj/item/organ/organ in human.organs)
					if(organ.organ_flags & ORGAN_ROBOTIC)
						has_prosthesis = TRUE
						break
			if(has_prosthesis && prob(harm_prosthesis_chance))
				human.emp_act(2)

