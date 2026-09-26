/datum/round_event_control/magic_lights
	name = "Magic Lights - Weak"
	typepath = /datum/round_event/magic_lights
	min_players = 5
	earliest_start = 10 MINUTES
	max_occurrences = 3
	category = EVENT_CATEGORY_WIZARD
	description = "Summons a few sparkling lights in the station maintenance."
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 2

	weight = 30 // Including the strong variant, this lands at 50, or about as much as a clown rift
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_NEUTRAL, TAG_MAGIC, TAG_COMMUNAL)

/datum/round_event_control/magic_lights/strong
	name = "Magic Lights - Strong"
	typepath = /datum/round_event/magic_lights/strong
	weight = 20
	max_occurrences = 1

/datum/round_event/magic_lights
	announce_chance = 0
	var/impotence_chance = 66

/datum/round_event/magic_lights/strong
	impotence_chance = 0

/datum/round_event/magic_lights/start()
	var/area/target = get_random_maintenance_area()
	var/list/candidate_turfs = get_area_turfs(target)
	for(var/turf/potential_turf in candidate_turfs)
		if(isgroundlessturf(potential_turf) || potential_turf.density)
			candidate_turfs -= potential_turf
	var/amount_of_lights = rand(2,4)
	for(var/i = 0, i < amount_of_lights, i++)
		var/turf/open/picked_turf = pick_n_take(candidate_turfs)
		var/obj/effect/magical_light/light
		if(prob(impotence_chance))
			light = new /obj/effect/magical_light/impotent(picked_turf)
		else
			light = new /obj/effect/magical_light(picked_turf)
		announce_to_ghosts(light)
