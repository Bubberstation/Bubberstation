/area/dynamic
	name = "Dynamic area"
	icon = 'modular_zvents/icons/area/dynamic_area.dmi'
	icon_state = "dynamic_area"



/obj/effect/mapping_helpers/dynamic_area_marker
	name = "Dynamic area marker"
	icon = 'modular_zvents/icons/area/dynamic_area.dmi'
	icon_state = "marker"

	/// Name of future area
	var/area_name = "Dynamic Area"
	/// Is this dynamic area station
	var/station = FALSE

	var/requires_power = TRUE
	var/power_environ = FALSE
	var/power_light = FALSE
	var/power_equip = FALSE
	var/outdoors = FALSE
	var/daylight = FALSE


	var/static/list/createed_areas = list()
	late = TRUE

/obj/effect/mapping_helpers/dynamic_area_marker/Initialize(mapload)
	. = ..()
	build_dynamic_area()

/obj/effect/mapping_helpers/dynamic_area_marker/proc/validate_area_name(name)
	return name

/obj/effect/mapping_helpers/dynamic_area_marker/proc/build_new_area(area_name)
	if(createed_areas[area_name])
		return createed_areas[area_name]

	var/area/dynamic/new_area = new()
	new_area.name = area_name
	new_area.requires_power = src.requires_power
	new_area.power_environ = src.power_environ
	new_area.power_light = src.power_light
	new_area.power_equip = src.power_equip
	new_area.outdoors = src.outdoors
	new_area.daylight = src.daylight
	new_area.color = src.color
	createed_areas[area_name] = new_area
	if(station)
		GLOB.the_station_areas += new_area
	return new_area

/obj/effect/mapping_helpers/dynamic_area_marker/proc/build_dynamic_area()
	var/new_area_name = validate_area_name(area_name)
	var/area/dynamic/new_area = build_new_area(new_area_name)
	var/turf/our_turf = get_turf(src)
	var/old_area = get_area(our_turf)
	our_turf.change_area(old_area, new_area)
	qdel(src)


/obj/effect/mapping_helpers/dynamic_area_marker/colored

/obj/effect/mapping_helpers/dynamic_area_marker/colored/red
	name = "Red Dynamic Area Marker"
	color = COLOR_RED

/obj/effect/mapping_helpers/dynamic_area_marker/colored/blue
	name = "Blue Dynamic Area Marker"
	color = COLOR_BLUE

/obj/effect/mapping_helpers/dynamic_area_marker/colored/green
	name = "Green Dynamic Area Marker"
	color = COLOR_GREEN

/obj/effect/mapping_helpers/dynamic_area_marker/colored/yellow
	name = "Yellow Dynamic Area Marker"
	color = COLOR_YELLOW

/obj/effect/mapping_helpers/dynamic_area_marker/colored/purple
	name = "Purple Dynamic Area Marker"
	color = COLOR_PURPLE

/obj/effect/mapping_helpers/dynamic_area_marker/colored/orange
	name = "Orange Dynamic Area Marker"
	color = COLOR_ORANGE

/obj/effect/mapping_helpers/dynamic_area_marker/colored/pink
	name = "Pink Dynamic Area Marker"
	color = COLOR_PINK

/obj/effect/mapping_helpers/dynamic_area_marker/colored/cyan
	name = "Cyan Dynamic Area Marker"
	color = COLOR_CYAN

/obj/effect/mapping_helpers/dynamic_area_marker/colored/white
	name = "White Dynamic Area Marker"
	color = COLOR_WHITE

/obj/effect/mapping_helpers/dynamic_area_marker/colored/black
	name = "Black Dynamic Area Marker"
	color = COLOR_BLACK

/obj/effect/mapping_helpers/dynamic_area_marker/colored/gray
	name = "Gray Dynamic Area Marker"
	color = COLOR_GRAY
