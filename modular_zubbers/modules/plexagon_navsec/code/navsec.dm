/// APC-based area navigator. Displays all station areas with APCs and points an arrow toward the selected one.
/datum/computer_file/program/radar/navsec
	filename = "plexagonnavsec"
	filedesc = "Plexagon NavSec"
	extended_desc = "Never get lost again. Plexagon NavSec indexes every area on the station and points you straight to it, no matter how obscure the name or unfamiliar the layout. Perfect for new crew and anyone transferred to a station they've never set foot on."
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	program_icon = "location-arrow"
	size = 2

/datum/computer_file/program/radar/navsec/find_atom()
	return ..() || (locate(selected) in SSmachines.processing_apcs)

/datum/computer_file/program/radar/navsec/scan()
	objects = list()
	var/list/name_to_apc = list()
	for(var/obj/machinery/power/apc/station_apc as anything in SSmachines.processing_apcs)
		var/area/apc_area = station_apc.area
		if(!istype(apc_area, /area/station))
			continue
		if(!trackable(station_apc))
			continue
		name_to_apc[apc_area.name] = station_apc
	sortTim(name_to_apc, /proc/cmp_text_asc)
	for(var/area_name in name_to_apc)
		var/obj/machinery/power/apc/station_apc = name_to_apc[area_name]
		var/list/apc_info = list(
			ref = REF(station_apc),
			name = area_name,
		)
		objects += list(apc_info)

/obj/item/modular_computer/pda/assistant/install_default_programs()
	. = ..()
	store_file(new /datum/computer_file/program/radar/navsec)
