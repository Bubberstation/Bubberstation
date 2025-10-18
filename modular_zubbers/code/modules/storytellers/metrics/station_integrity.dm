#define STORY_INTEGRITY_PENALTY_UNSAFE 10
#define STORY_INTEGRITY_PENALTY_FIRES 5

/datum/storyteller_metric/station_integrity
	name = "Station integrity"

	var/static/list/ignored_areas = list(
		/area/station/engineering/supermatter,
		/area/station/science/ordnance,
		/area/station/service/kitchen/coldroom,
		/area/station/tcommsat
	)


// Metric for station integrity: analyzes areas for damage, fires, breaches, etc.
// Outputs to vault: raw integrity 0-100 and infra_damage 0-3
/datum/storyteller_metric/station_integrity/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/list/to_analyze = get_areas(/area/station)
	if(!length(to_analyze))
		return

	var/total_firespots = 0
	var/unsafe_areas = 0
	var/checked_areas = 0
	var/total_area_size = 0
	var/weighted_safe_score = 0


	for(var/area/station/station_area in to_analyze)
		if(station_area in ignored_areas)
			continue
		if(station_area.outdoors || !length(station_area.air_vents))
			continue

		var/area_size = station_area.areasize
		total_area_size += area_size
		checked_areas += 1

		if(length(station_area.firealarms))
			total_firespots += 1

		if(!is_safe_area(station_area))
			unsafe_areas += 1
		else
			weighted_safe_score += area_size


	var/safe_percentage = total_area_size > 0 ? (weighted_safe_score / total_area_size) : 0
	var/base_integrity = safe_percentage * 100
	var/penalty_unsafe = unsafe_areas * STORY_INTEGRITY_PENALTY_UNSAFE
	var/penalty_fires = total_firespots * STORY_INTEGRITY_PENALTY_FIRES
	var/raw_integrity = clamp(base_integrity - penalty_unsafe - penalty_fires, 0, 100)
	var/damage_level = clamp((unsafe_areas / max(checked_areas * 0.1, 1)) + (total_firespots / max(checked_areas * 0.05, 1)), 0, 3)


	inputs.set_entry(STORY_VAULT_INFRA_DAMAGE, round(damage_level))
	inputs.set_entry(STORY_VAULT_STATION_INTEGRITY, round(raw_integrity))
	..()



#undef STORY_INTEGRITY_PENALTY_UNSAFE
#undef STORY_INTEGRITY_PENALTY_FIRES



// Thresholds for low power states (percentages)

#define STORY_POWER_LOW_SMES_THRESHOLD 20
#define STORY_POWER_APC_FAILURE_RATIO 0.1

// Penalties for calculations (subtracted from raw_strength)

#define STORY_POWER_PENALTY_LOW_SMES 20
#define STORY_POWER_PENALTY_PER_OFF_APC 5




/datum/storyteller_metric/power_grid_check
	name = "Station power grid"


/datum/storyteller_metric/power_grid_check/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/list/apc_to_check = list()
	var/list/smes_to_check = list()


	for(var/obj/machinery/power/power_machine as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power))
		if(!is_station_level(power_machine.z))
			continue
		if(istype(power_machine, /obj/machinery/power/apc))
			apc_to_check += power_machine
		else if(istype(power_machine, /obj/machinery/power/smes))
			smes_to_check += power_machine

	if(!length(apc_to_check) && !length(smes_to_check))
		inputs.vault[STORY_VAULT_POWER_GRID_STRENGTH] = 0
		inputs.vault[STORY_VAULT_POWER_GRID_DAMAGE] = 3
		return


	var/total_apc_charge = 0
	var/operating_apc = 0
	var/total_apc_size = 0
	var/total_smes_charge = 0
	var/total_smes_capacity = 0
	var/checked_apc = length(apc_to_check)


	for(var/obj/machinery/power/apc/APC in apc_to_check)
		if(!APC.area)
			continue
		var/area_size = APC.area.areasize
		total_apc_size += area_size


		var/charge_percent = APC.cell ? APC.cell.percent() : 0
		total_apc_charge += charge_percent * area_size


		if(APC.operating && !APC.failure_timer)
			operating_apc += 1

	for(var/obj/machinery/power/smes/SMES in smes_to_check)
		total_smes_charge += SMES.charge
		var/total_capacity = 0
		for(var/obj/item/stock_parts/power_store/power_cell in SMES.component_parts)
			total_capacity += power_cell.max_charge()
		total_smes_capacity += total_capacity


	var/avg_apc_charge = total_apc_size > 0 ? (total_apc_charge / total_apc_size) : 0
	var/apc_operating_percent = checked_apc > 0 ? (operating_apc / checked_apc) * 100 : 0
	var/apc_strength = (avg_apc_charge * 0.6) + (apc_operating_percent * 0.4)

	var/smes_percent = total_smes_capacity > 0 ? (total_smes_charge / total_smes_capacity) * 100 : 0

	var/raw_strength = (apc_strength * 0.7) + (smes_percent * 0.3)
	var/penalty_low_smes = smes_percent < 20 ? 20 : 0
	var/penalty_off_apc = (checked_apc - operating_apc) * STORY_POWER_PENALTY_PER_OFF_APC
	raw_strength = clamp(raw_strength - penalty_low_smes - penalty_off_apc, 0, 100)

	var/damage_level = clamp(((checked_apc - operating_apc) / max(checked_apc * 0.1, 1)) + ((100 - smes_percent) / 50), 0, 3)

	inputs.vault[STORY_VAULT_POWER_GRID_STRENGTH] = round(raw_strength)
	inputs.vault[STORY_VAULT_POWER_GRID_DAMAGE] = round(damage_level)
	..()



#undef STORY_POWER_LOW_SMES_THRESHOLD
#undef STORY_POWER_APC_FAILURE_RATIO
#undef STORY_POWER_PENALTY_LOW_SMES
#undef STORY_POWER_PENALTY_PER_OFF_APC
