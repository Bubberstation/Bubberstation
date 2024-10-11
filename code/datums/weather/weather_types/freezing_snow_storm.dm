
GLOBAL_LIST_EMPTY(all_walls)

GLOBAL_LIST_EMPTY(snowable_walls)
GLOBAL_LIST_EMPTY(snowable_windows)

/datum/weather/snow_storm/cold_snap
	name = "Cold Snap"
	desc = "A sudden cold snap has descended upon the area, freezing everything in its path."
	telegraph_message = span_warning("The temperature begins to drop rapidly.")
	telegraph_duration = 100
	weather_message = span_userdanger("The cold snap has arrived! Seek shelter!")
	probability = 0 // best let admins trigger this one
	cooling_lower = 10
	cooling_upper = 25
	end_duration = 500
	var/temp_change = -10
	var/wall_heat_conductivity_change = 0.05
	var/walls_per_process = 20
	var/windows_per_process = 20
	var/list/windows_to_freeze = list()
	var/list/walls_to_freeze = list()

/datum/weather/proc/weather_active_tick()

/datum/weather/snow_storm/cold_snap/weather_active_tick()
	var/list/freeze_walls_this_tick = pick_limit(walls_to_freeze, walls_per_process)
	var/list/freeze_windows_this_tick = pick_limit(windows_to_freeze, windows_per_process)

	change_outside_objects(freeze_windows_this_tick, 'icons/obj/smooth_structures/rice_window.dmi', "rice_window")
	change_outside_objects(freeze_walls_this_tick, 'icons/turf/walls/icedmetal_wall.dmi', "icedmetal_wall")

/datum/weather/snow_storm/cold_snap/proc/pick_limit(list/source_list, limit)
	var/return_list = list()
	if(length(source_list) <= limit)
		return source_list
	for(var/count in 1 to limit)
		var/atom/picked = pick(source_list)
		source_list -= picked
		return_list += picked
	return return_list

/datum/weather/snow_storm/cold_snap/proc/copy_affected_turfs(list/copy_turfs)
	var/list/valid_turfs = list()
	for(var/datum/weakref/ref in copy_turfs)
		var/turf/open/open_turf = ref.resolve()
		if(open_turf && (open_turf.z in impacted_z_levels))
			valid_turfs += ref
	return valid_turfs

/datum/weather/snow_storm/cold_snap/start()
	. = ..()
	walls_to_freeze = copy_affected_turfs(GLOB.snowable_walls)
	windows_to_freeze = copy_affected_turfs(GLOB.snowable_windows)

	for(var/datum/weakref/ref as anything in GLOB.all_walls)
		var/turf/closed/wall = ref.resolve()
		if(!wall) // it's time for the inside to become cold as fuck :)
			return
		if(!(wall.z in impacted_z_levels))
			continue
		var/conductivity_change = wall_heat_conductivity_change
		if(istype(wall, /turf/closed/wall/r_wall))
			conductivity_change /= 2
		wall.thermal_conductivity = clamp(wall_heat_conductivity_change, WALL_HEAT_TRANSFER_COEFFICIENT, OPEN_HEAT_TRANSFER_COEFFICIENT)

	// do the actual cooling
	var/iters = 1
	var/atmos_iters = 1
	var/modified_planetary = FALSE
	var/new_temp = -1
	for(var/area/snow_area as anything in impacted_areas)
		for(var/z in impacted_z_levels)
			for(var/turf/turf as anything in snow_area.get_turfs_by_zlevel(z))
				iters++
				if(!istype(turf, /turf/open))
					return
				var/turf/open/open_turf = turf
				var/datum/gas_mixture/gasmix = open_turf.air
				atmos_iters++
				if(!modified_planetary && open_turf.planetary_atmos) // DOESN'T WORK NEED TO MODIFY
					modified_planetary = TRUE
					var/datum/gas_mixture/immutable/planetary/planetary_gasmix = SSair.planetary[open_turf.initial_gas_mix]
					planetary_gasmix.temperature += temp_change
					planetary_gasmix.temperature_archived += temp_change
					planetary_gasmix.initial_temperature += temp_change
					if(new_temp == -1) // make sure we keep the temperature consistent to prevent atmos from starting up
						new_temp = planetary_gasmix.temperature

				if(gasmix)
					gasmix.temperature = new_temp
					gasmix.temperature_archived = new_temp
	world << "iters: [iters], atmos iters [atmos_iters]"
				// if(turf_gasmix)
				// 	turf_gasmix.temperature += temp_change
			// 	turf.air_update_turf(FALSE, FALSE)



/datum/weather/snow_storm/cold_snap/proc/change_outside_objects(list/objects_refs, icon_path, icon_name)
	for(var/datum/weakref/ref as anything in objects_refs)
		var/obj/object = ref.resolve()
		if(!object || !(object.z in impacted_z_levels))
			continue
		if(!istype(object, /turf))
			return
		var/turf/target_turf = object
		var/list/tiles_around = range(1, object)
		for(var/turf/open/tile in tiles_around)
			if(tile.planetary_atmos)
				if(!object.loc)
					continue
				objects_refs -= ref
				target_turf.icon = icon_path
				target_turf.base_icon_state = icon_name
				target_turf.icon_state = icon_name + "-0"
				target_turf.update_icon()
				break

/datum/weather/snow_storm/cold_snap/weather_act(mob/living/living)
	. = ..()
	if(prob(5))
		to_chat(living, "The cold snap is freezing you to the bone!")
	living.adjustFireLoss(1)

/obj/structure/window/reinforced/fulltile
	var/datum/weakref/cleanup_ref

/obj/structure/window/reinforced/fulltile/Initialize(mapload, direct)
	. = ..()
	if(type == /obj/structure/window/reinforced/fulltile)
		cleanup_ref = WEAKREF(src)
		GLOB.snowable_windows += cleanup_ref

/obj/structure/window/reinforced/fulltile/Destroy()
	. = ..()
	if(cleanup_ref)
		GLOB.snowable_windows -= cleanup_ref

/turf/closed/wall
	var/datum/weakref/cleanup_ref

/turf/closed/wall/Initialize(mapload)
	. = ..()
	var/is_base_wall = /turf/closed/wall
	if(is_base_wall || type == /turf/closed/wall/r_wall)
		if(is_base_wall)
			GLOB.snowable_walls += WEAKREF(src)
		GLOB.all_walls += WEAKREF(src)

/turf/closed/wall/Destroy()
	. = ..()
	if(cleanup_ref)
		GLOB.snowable_walls -= cleanup_ref
		GLOB.all_walls -= cleanup_ref
