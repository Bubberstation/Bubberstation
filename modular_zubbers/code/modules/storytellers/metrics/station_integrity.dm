#define STORY_INTEGRITY_PENALTY_UNSAFE 20 //%
#define STORY_INTEGRITY_PENALTY_FIRES 10

/datum/storyteller_metric/station_integrity
	name = "Station integrity"

	var/static/list/ignored_areas = list(
		/area/station/engineering/supermatter,
		/area/station/science/ordnance,
		/area/station/service/kitchen/coldroom,
		/area/station/science/ordnance/bomb,
		/area/station/medical/coldroom,
		/area/station/tcommsat,
		/area/station/solars,
	)


// Metric for station integrity: analyzes areas for damage, fires, breaches, etc.
// Outputs to vault: raw integrity 0-100 and infra_damage 0-3
/datum/storyteller_metric/station_integrity/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/list/to_analyze = get_areas(/area/station)
	if(!length(to_analyze))
		return

	var/total_firespots_weight = 0  // Weighted fires (by area size with fire)
	var/unsafe_areas = 0             // Count unsafe (for damage_level)
	var/total_unsafe_area_size = 0   // Total size of unsafe areas
	var/checked_areas = 0            // Total valid areas
	var/total_area_size = 0          // Total size of valid areas
	var/weighted_safe_score = 0      // Sum size of safe areas


	for(var/area/station/station_area in to_analyze)
		if(station_area in ignored_areas)
			continue
		if(station_area.outdoors || station_area.area_flags & NO_GRAVITY)
			continue

		var/area_size = station_area.areasize
		total_area_size += area_size
		checked_areas += 1

		if(station_area.fire)
			total_firespots_weight += area_size / total_area_size

		if(!is_safe_area(station_area) || !length(station_area.air_vents))
			unsafe_areas += 1
			total_unsafe_area_size += area_size
		else
			weighted_safe_score += area_size


	// Base integrity as % safe size * 100
	var/safe_percentage = total_area_size > 0 ? (weighted_safe_score / total_area_size) : 0
	var/base_integrity = safe_percentage * 100

	// Penalties based on unsafe % size and weighted fires (no count-based, size-focused)
	var/unsafe_percentage = total_area_size > 0 ? (total_unsafe_area_size / total_area_size) * 100 : 0
	var/penalty_unsafe = unsafe_percentage * (STORY_INTEGRITY_PENALTY_UNSAFE / 100)  // Scale penalty by % unsafe
	var/penalty_fires = total_firespots_weight * STORY_INTEGRITY_PENALTY_FIRES  // Weighted by fire areas size
	var/raw_integrity = clamp(base_integrity - penalty_unsafe - penalty_fires, 0, 100)

	// Damage level based on % unsafe size + weighted fires (relative, not count)
	var/damage_level = clamp((unsafe_percentage / 100 * STORY_VAULT_CRITICAL_DAMAGE) + (total_firespots_weight * 1.5), 0, 3)  // *1.5 tune for fires sensitivity


	inputs.vault[STORY_VAULT_INFRA_DAMAGE] = round(damage_level)
	inputs.vault[STORY_VAULT_STATION_INTEGRITY] = round(raw_integrity)
	..()



#undef STORY_INTEGRITY_PENALTY_UNSAFE
#undef STORY_INTEGRITY_PENALTY_FIRES



// Thresholds for low power states (percentages)
#define STORY_POWER_LOW_SMES_THRESHOLD 10  // Below this % SMES charge → penalty
#define STORY_POWER_APC_FAILURE_RATIO 0.1  // Ratio for damage_level: failures / (checked * this)

// Penalties for calculations (subtracted from raw_strength; scaled by size in code)
#define STORY_POWER_PENALTY_LOW_SMES 10    // Fixed penalty if SMES < threshold
#define STORY_POWER_PENALTY_PER_OFF_APC 5  // Per non-operating APC (scaled by area size)




// Metric for station power grid: analyzes APCs and SMES for charge, operational status, etc. Weighted by area size.
// Outputs to vault: raw power strength 0-100 (size-based) and power damage 0-3
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
		return ..()


	var/total_apc_charge = 0          // Weighted charge sum
	var/operating_apc_weight = 0      // Weighted operating (by area size)
	var/total_apc_size = 0            // Total valid APC areas size
	var/total_off_apc_size = 0        // Total size of off/failing APC areas (for penalties/damage)
	var/total_smes_charge = 0         // Sum SMES charge
	var/total_smes_capacity = 0       // Sum SMES capacity


	for(var/obj/machinery/power/apc/APC in apc_to_check)
		if(!APC.area) continue
		var/area_size = APC.area.areasize
		total_apc_size += area_size


		var/charge_percent = APC.cell ? APC.cell.percent() : 0
		total_apc_charge += charge_percent * area_size

		// Operating weighted (if operating, add size; else add to off_size)
		if(APC.operating && !APC.failure_timer)
			operating_apc_weight += area_size
		else
			total_off_apc_size += area_size


	for(var/obj/machinery/power/smes/SMES in smes_to_check)
		total_smes_charge += SMES.charge

		var/total_capacity = 0
		for(var/obj/item/stock_parts/power_store/power_cell in SMES.component_parts)
			total_capacity += power_cell.maxcharge
		total_smes_capacity += total_capacity


	var/avg_apc_charge = total_apc_size > 0 ? (total_apc_charge / total_apc_size) : 0
	var/apc_operating_percent = total_apc_size > 0 ? (operating_apc_weight / total_apc_size) * 100 : 0
	var/apc_strength = (avg_apc_charge * 0.6) + (apc_operating_percent * 0.4)


	var/smes_percent = total_smes_capacity > 0 ? (total_smes_charge / total_smes_capacity) * 100 : 0

	var/raw_strength = (apc_strength * 0.7) + (smes_percent * 0.3)


	var/penalty_low_smes = smes_percent < STORY_POWER_LOW_SMES_THRESHOLD ? STORY_POWER_PENALTY_LOW_SMES : 0
	var/off_percentage = total_apc_size > 0 ? (total_off_apc_size / total_apc_size) * 100 : 0
	var/penalty_off_apc = off_percentage * (STORY_POWER_PENALTY_PER_OFF_APC / 100)  // Scale by % off size
	raw_strength = clamp(raw_strength - penalty_low_smes - penalty_off_apc, 0, 100)


	var/damage_level = clamp((off_percentage / 100 * STORY_VAULT_CRITICAL_DAMAGE) \
		+ ((100 - smes_percent) / 100), 0, 3)


	inputs.vault[STORY_VAULT_POWER_GRID_STRENGTH] = round(raw_strength)
	inputs.vault[STORY_VAULT_POWER_GRID_DAMAGE] = round(damage_level)

	..()

#undef STORY_POWER_LOW_SMES_THRESHOLD
#undef STORY_POWER_APC_FAILURE_RATIO
#undef STORY_POWER_PENALTY_LOW_SMES
#undef STORY_POWER_PENALTY_PER_OFF_APC
