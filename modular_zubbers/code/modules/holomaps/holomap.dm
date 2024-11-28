#define HOLOMAP_LOW_LIGHT 1, 2
#define HOLOMAP_HIGH_LIGHT 2, 3
#define HOLOMAP_LIGHT_OFF 0

// Wall mounted holomap of the station
// Credit to polaris for the code which this current map was originally based off of, and credit to VG for making it in the first place.

/obj/machinery/holomap
	name = "\improper holomap"
	desc = "A virtual map of the surrounding area."
	icon = 'modular_zubbers/icons/obj/machines/holomap/stationmap.dmi'
	icon_state = "station_map"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 100
	light_color = HOLOMAP_HOLOFIER

	/// The mob beholding this marvel.
	var/mob/watching_mob
	/// The image that can be seen in-world.
	var/image/small_station_map
	/// The little "map" floor painting.
	var/image/floor_markings

	// zLevel which the map is a map for.
	var/current_z_level
	/// The various images and icons for the map are stored in here, as well as the actual big map itself.
	var/datum/station_holomap/holomap_datum

	var/wall_frame_type = /obj/item/wallframe/holomap

	var/construction_state

/obj/machinery/holomap/open
	panel_open = TRUE
	construction_state = "unwired"
	icon_state = "station_map_unwired"

/obj/machinery/holomap/Initialize(mapload)
	. = ..()
	current_z_level = z
	SSholomaps.station_holomaps += src

/obj/machinery/holomap/post_machine_initialize()
	. = ..()
	setup_holomap()

/obj/machinery/holomap/Destroy()
	SSholomaps.station_holomaps -= src
	close_map()
	QDEL_NULL(holomap_datum)
	. = ..()

/obj/machinery/holomap/proc/setup_holomap()
	var/turf/current_turf = get_turf(src)
	holomap_datum = new
	floor_markings = image('modular_zubbers/icons/obj/machines/holomap/stationmap.dmi', "decal_station_map")

	if(!("[HOLOMAP_EXTRA_STATIONMAP]_[current_z_level]" in SSholomaps.extra_holomaps))
		holomap_datum.initialize_holomap_bogus()
		update_icon()
		return

	holomap_datum.bogus = FALSE
	holomap_datum.initialize_holomap(current_turf.x, current_turf.y, current_z_level, reinit_base_map = TRUE, extra_overlays = handle_overlays())

	update_icon()

/obj/machinery/holomap/attack_hand(mob/user)
	if(user && user == holomap_datum?.watching_mob)
		close_map(src)
		return

	open_map(user, src)

/// Tries to open the map for the given mob. Returns FALSE if it doesn't meet the criteria, TRUE if the map successfully opened with no runtimes.
/obj/machinery/holomap/proc/open_map(mob/user)
	if((machine_stat & (NOPOWER | BROKEN)) || !user?.client || panel_open || user.hud_used.holomap.used_station_map)
		return FALSE

	if(!holomap_datum)
		// Something is very wrong if we have to un-fuck ourselves here.
		stack_trace("\[HOLOMAP] WARNING: Holomap at [x], [y], [z] [ADMIN_FLW(src)] had to set itself up on interact! Something during Initialize went very wrong!")
		setup_holomap()

	holomap_datum.update_map(handle_overlays())

	watching_mob = user // Do it here in case the map errors out while opening for whatever reason. Makes it easier for admins to force close the map.
	if(holomap_datum.open_holomap(user, src))
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(watcher_moved), TRUE)
		icon_state = "[initial(icon_state)]_active"
		set_light(HOLOMAP_HIGH_LIGHT)
		update_use_power(ACTIVE_POWER_USE)

	return TRUE

/obj/machinery/holomap/attack_ai(mob/living/silicon/robot/user)
	attack_hand(user)

/obj/machinery/holomap/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/holomap/process()
	if((machine_stat & (NOPOWER | BROKEN)) || !anchored || panel_open || construction_state)
		close_map()

/obj/machinery/holomap/proc/watcher_moved()
	SIGNAL_HANDLER
	close_map(watching_mob)

/obj/machinery/holomap/proc/close_map()
	if(holomap_datum.close_holomap(src))
		UnregisterSignal(watching_mob, COMSIG_MOVABLE_MOVED)
		icon_state = initial(icon_state)
		set_light(HOLOMAP_LOW_LIGHT)

	update_use_power(IDLE_POWER_USE)

/obj/machinery/holomap/power_change()
	. = ..()
	update_icon()

	if(machine_stat & NOPOWER)
		close_map()
		set_light(HOLOMAP_LIGHT_OFF)
	else
		set_light(HOLOMAP_LOW_LIGHT)

/obj/machinery/holomap/proc/set_broken()
	machine_stat |= BROKEN
	update_icon()

/obj/machinery/holomap/update_icon()
	. = ..()
	if(!holomap_datum)
		return //Not yet.

	cut_overlays()
	if(machine_stat & BROKEN)
		icon_state = "[initial(icon_state)]_broken"
	else if (construction_state)
		icon_state = "[initial(icon_state)]_[construction_state]"
	else if(panel_open)
		icon_state = "[initial(icon_state)]_opened"
	else if((machine_stat & NOPOWER))
		icon_state = "[initial(icon_state)]_off"
	else
		icon_state = initial(icon_state)

		if(holomap_datum.bogus)
			holomap_datum.initialize_holomap_bogus()
		else
			small_station_map = image(SSholomaps.extra_holomaps["[HOLOMAP_EXTRA_STATIONMAPSMALL]_[current_z_level]"], dir = src.dir)
			add_overlay(small_station_map)

	// Put the little "map" overlay down where it looks nice
	if(floor_markings)
		floor_markings.dir = src.dir
		floor_markings.pixel_x = -src.pixel_x
		floor_markings.pixel_y = -src.pixel_y
		add_overlay(floor_markings)

/obj/machinery/holomap/examine(mob/user)
	. = ..()
	if(panel_open)
		if(construction_state)
			. += span_notice("It's missing some [span_bold("wires")].")
			. += span_notice("It could be [span_bold("pried")] off the wall.")
		else
			. += span_notice("The wires look like they could be [span_bold("cut")].")
		return

	. += span_notice("It looks like it's panel could be [span_bold("unscrewed")].")

/obj/machinery/holomap/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if (.)
		return

	if(construction_state == "unwired" && istype(tool, /obj/item/stack/cable_coil)) // Someone else can expand on holomap construction if they really want.
		var/obj/item/stack/cable_coil/coil = tool
		if(!coil.use(5))
			return TRUE

		construction_state = null
		update_icon()
		return TRUE

/obj/machinery/holomap/screwdriver_act(mob/living/user, obj/item/tool)
	if(construction_state)
		return TRUE // Stop folk from smacking it accidentally
	if(!default_deconstruction_screwdriver(user, "[initial(icon_state)]_opened", "[initial(icon_state)]", tool))
		return FALSE

	close_map()
	update_icon()

	if(!panel_open)
		setup_holomap()

	return TRUE

/obj/machinery/holomap/wirecutter_act(mob/living/user, obj/item/tool)
	if(construction_state || !panel_open)
		return TRUE

	tool.play_tool_sound(user, 50)
	construction_state = "unwired"
	new /obj/item/stack/cable_coil/five(get_turf(src))
	update_icon()
	return TRUE

/obj/machinery/holomap/multitool_act(mob/living/user, obj/item/tool)
	if(construction_state)
		to_chat(user, span_warning("You need to finish building this before you can change \the [src]'[p_s()] settings!"))
		return TRUE
	if(!panel_open)
		to_chat(user, span_warning("You need to open the panel to change \the [src]'[p_s()] settings!"))
		return TRUE
	if(!SSholomaps.valid_map_indexes.len > 1)
		to_chat(user, span_warning("There are no other maps available for \the [src]!"))
		return TRUE

	tool.play_tool_sound(user, 50)
	var/current_index = SSholomaps.valid_map_indexes.Find(current_z_level)
	if(current_index >= SSholomaps.valid_map_indexes.len)
		current_z_level = SSholomaps.valid_map_indexes[1]
	else
		current_z_level = SSholomaps.valid_map_indexes[current_index + 1]

	to_chat(user, span_info("You set \the [src]'[p_s()] database index to [current_z_level]."))
	return TRUE

/obj/machinery/holomap/crowbar_act(mob/living/user, obj/item/tool)
	. = default_deconstruction_crowbar(tool, custom_deconstruct = TRUE)

	if(!.)
		return

	tool.play_tool_sound(src, 50)
	if(machine_stat & BROKEN)
		var/obj/item/stack/stack = new /obj/item/stack/sheet/iron(get_turf(src))
		stack.amount = 2
	else
		new wall_frame_type(get_turf(src))
	qdel(src)

/obj/machinery/holomap/emp_act(severity)
	if(severity == EMP_LIGHT && !prob(50))
		return

	do_sparks(8, TRUE, src)
	set_broken()

/obj/machinery/holomap/proc/handle_overlays()
	// Each entry in this list contains the text for the legend, and the icon and icon_state use. Null or non-existent icon_state ignore hiding logic.
	// If an entry contains an icon,
	var/list/legend = list() + GLOB.holomap_default_legend

	var/list/z_transitions = SSholomaps.holomap_z_transitions["[current_z_level]"]
	if(length(z_transitions))
		legend += z_transitions

	return legend

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/holomap, 32)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/holomap/open, 32)

/obj/machinery/holomap/engineering
	name = "\improper engineering holomap"
	icon_state = "station_map_engi"
	wall_frame_type = /obj/item/wallframe/holomap/engineering

/obj/machinery/holomap/engineering/open
	panel_open = TRUE
	construction_state = "unwired"
	icon_state = "station_map_engi_unwired"

/obj/machinery/holomap/engineering/attack_hand(mob/user)
	. = ..()

	if(.)
		holomap_datum.update_map(handle_overlays())

/obj/machinery/holomap/engineering/handle_overlays()
	var/list/extra_overlays = ..()
	if(holomap_datum.bogus)
		return extra_overlays

	var/list/fire_alarms = list()
	for(var/obj/machinery/firealarm/alarm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/airalarm))
		if(alarm?.z == current_z_level && alarm?.my_area?.active_alarms[ALARM_FIRE])
			var/image/alarm_icon = image('modular_zubbers/icons/obj/machines/holomap/8x8.dmi', "fire_marker")
			alarm_icon.pixel_x = alarm.x + HOLOMAP_CENTER_X - 1
			alarm_icon.pixel_y = alarm.y + HOLOMAP_CENTER_Y
			fire_alarms += alarm_icon

	if(length(fire_alarms))
		extra_overlays["Fire Alarms"] = list("icon" = image('modular_zubbers/icons/obj/machines/holomap/8x8.dmi', "fire_marker"), "markers" = fire_alarms)

	var/list/air_alarms = list()
	for(var/obj/machinery/airalarm/air_alarm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/airalarm))
		if(air_alarm?.z == current_z_level && air_alarm?.my_area?.active_alarms[ALARM_ATMOS])
			var/image/alarm_icon = image('modular_zubbers/icons/obj/machines/holomap/8x8.dmi', "atmos_marker")
			alarm_icon.pixel_x = air_alarm.x + HOLOMAP_CENTER_X - 1
			alarm_icon.pixel_y = air_alarm.y + HOLOMAP_CENTER_Y
			air_alarms += alarm_icon

	if(length(air_alarms))
		extra_overlays["Air Alarms"] = list("icon" = image('modular_zubbers/icons/obj/machines/holomap/8x8.dmi', "atmos_marker"), "markers" = air_alarms)

	return extra_overlays

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/holomap/engineering, 32)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/holomap/engineering/open, 32)

#undef HOLOMAP_LOW_LIGHT
#undef HOLOMAP_HIGH_LIGHT
#undef HOLOMAP_LIGHT_OFF
