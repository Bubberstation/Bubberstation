/datum/round_event_control/electrical_storm
	id = "electrical_storm"
	name = "Electrical Storm"
	description = "Execite electrical storms to disable station lighting and machinery."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_TARGETS_SYSTEMS
	typepath = /datum/round_event/electrical_storm


/datum/round_event/electrical_storm
	allow_random = FALSE
	var/overload_apc_chance = 0
	var/destroy_lights_chance = 0
	var/disable_machinery_chance = 0
	var/bolt_doors_chance = 0
	var/range = 20

	start_when = 30
	announce_when = 1


/datum/round_event/electrical_storm/__setup_for_storyteller(threat_points, ...)
	. = ..()
	if(threat_points < STORY_THREAT_LOW)
		overload_apc_chance = 20
		destroy_lights_chance = 10
		disable_machinery_chance = 5
		bolt_doors_chance = 0
	else if(threat_points < STORY_THREAT_MODERATE)
		overload_apc_chance = 40
		destroy_lights_chance = 25
		disable_machinery_chance = 15
		bolt_doors_chance = 5
	else if(threat_points < STORY_THREAT_HIGH)
		overload_apc_chance = 60
		destroy_lights_chance = 40
		disable_machinery_chance = 30
		bolt_doors_chance = 15
		range = 30
	else if(threat_points < STORY_THREAT_EXTREME)
		overload_apc_chance = 80
		destroy_lights_chance = 60
		disable_machinery_chance = 50
		bolt_doors_chance = 30
		range = 40
	else
		overload_apc_chance = 100
		destroy_lights_chance = 80
		disable_machinery_chance = 70
		bolt_doors_chance = 50
		range = 50


/datum/round_event/electrical_storm/__start_for_storyteller()
	var/turf/center = get_safe_random_station_turf_equal_weight()
	for(var/obj/machinery/machinery in SSmachines.get_all_machines())
		if(get_dist(center, machinery) > range)
			continue

		if(prob(overload_apc_chance) && istype(machinery, /obj/machinery/power/apc))
			var/obj/machinery/power/apc/apc = machinery
			apc.overload_lighting()

		if(prob(destroy_lights_chance) && istype(machinery, /obj/machinery/light))
			var/obj/machinery/light/light = machinery
			light.break_light_tube(FALSE)

		if(prob(disable_machinery_chance) && !(machinery.machine_stat & BROKEN) && !(machinery.machine_stat & NOPOWER))
			machinery.use_energy(10 JOULES * rand(2*4)) //Cause some damage to the machine

		if(prob(bolt_doors_chance) && istype(machinery, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/door = machinery
			door.bolt()

/datum/round_event/electrical_storm/__announce_for_storyteller()
	priority_announce("An heavy electrical storm has been detected in your area, \
						please repair potential electronic overloads.", "Electrical Storm Alert", ANNOUNCER_ELECTRICALSTORM)
