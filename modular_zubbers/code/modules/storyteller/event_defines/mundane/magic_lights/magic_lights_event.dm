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
	var/impotence_chance = 30
	var/lights_per_maint = 3
	var/maints_count = 2

/datum/round_event/magic_lights/strong
	impotence_chance = 0
	lights_per_maint = 4
	maints_count = 3

/datum/round_event/magic_lights/start()
	for(var/m_count = 0, m_count < maints_count, m_count++)
		get_maint_and_populate()

/datum/round_event/magic_lights/proc/get_maint_and_populate()
	var/area/target_maint = get_random_maintenance_area()
	var/list/candidate_turfs = get_area_turfs(target_maint) + get_area_turfs(target_maint)
	for(var/turf/potential_turf in candidate_turfs)
		if(!is_valid_turf(potential_turf))
			candidate_turfs -= potential_turf
	var/announced = FALSE // Makes sure we announce only one per maint.
	for(var/i = 0, i < lights_per_maint, i++)
		if(!candidate_turfs.len)
			return
		var/turf/open/picked_turf = pick_n_take(candidate_turfs)
		var/obj/effect/magical_light/light
		if(prob(impotence_chance))
			light = new /obj/effect/magical_light/impotent(picked_turf)
		else
			light = new /obj/effect/magical_light(picked_turf)
		if(!announced)
			announce_to_ghosts(light)
			announced = TRUE

/datum/round_event/magic_lights/proc/is_valid_turf(turf/tile)
	if(isnull(tile))
		return FALSE
	if(isgroundlessturf(tile) || tile.density)
		return FALSE
	for(var/obj/to_check in tile.contents)
		if(to_check.density)
			return FALSE
		if(istype(to_check, /obj/machinery/door) || istype(to_check, /obj/effect/magical_light))
			return FALSE
		if(to_check.pass_flags_self & (PASSGRILLE | PASSWINDOW))
			return FALSE
	return TRUE
