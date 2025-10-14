/datum/storyteller_metric/infra_damage
	name = "Infrastructure Damage Aggregation"

/datum/storyteller_metric/infra_damage/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	..()
	var/damaged_apcs = 0
	var/breaches = 0


	var/list/to_check = SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/apc)
	// APCs
	for(var/obj/machinery/power/apc/A in to_check)
		if(A.machine_stat & BROKEN || A.machine_stat & NOPOWER)
			damaged_apcs += 1

	// It's really hard to check hull breaches properly without a full atmos simulation
	for(var/area/station_area in get_sorted_areas())
		if(istype(station_area, /area/station))
			for(var/obj/machinery/atmospherics/components/unary/vent_pump/vent in station_area.air_vents)
				if(vent.external_pressure_bound < ONE_ATMOSPHERE)
					breaches += 1
					break  // Count area once

	// Level (0 no -> 3 critical)
	var/damage_level = clamp((damaged_apcs / max(1, length(to_check) * 0.1)) + (breaches / 10), 0, 3)

	inputs.vault[STORY_VAULT_INFRA_DAMAGE] = round(damage_level)
	..()


/datum/storyteller_metric/env_hazards
	name = "Environmental Hazards Aggregation"

/datum/storyteller_metric/env_hazards/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/unsafe_areas = 0
	var/total_firespots = 0
	var/total_radiation_sources = 0

	total_radiation_sources = SSradiation.processing.len
	total_firespots = SSair.hotspots.len
	// Unsafe areas: Areas with active hazards
	for(var/area/station_area in get_sorted_areas())
		if(istype(station_area, /area/station))
			if(length(station_area.firealarms))
				unsafe_areas += 1
				continue

	var/damage_level = clamp((unsafe_areas / 10) + (total_firespots / 20) + (total_radiation_sources / 10), 0, 3)
	inputs.vault[STORY_VAULT_ENV_HAZARDS] = round(damage_level)
	..()
