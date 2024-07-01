/datum/controller/subsystem/processing/transport
	var/list/platform_doors = list()

/datum/transport_controller/linear/tram/New(obj/structure/transport/linear/tram/transport_module)
	. = ..()
	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(round_start))

/datum/transport_controller/linear/tram/proc/round_start()
	SIGNAL_HANDLER

	cycle_doors(CYCLE_OPEN)
	UnregisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING)

/obj/machinery/transport/tram_controller/sigma_octantis
	configured_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/machinery/computer/tram_controls/sigma_octantis
	icon = 'local/icons/obj/machines/computer.dmi'
	icon_screen = SIGMA_OCTANTIS_LINE_1
	specific_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/machinery/transport/destination_sign/sigma_octantis
	icon = 'local/icons/obj/tram/tram_display.dmi'
	configured_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/machinery/transport/destination_sign/indicator/sigma_octantis
	icon = 'local/icons/obj/tram/tram_indicator.dmi'
	configured_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/machinery/transport/destination_sign/Initialize(mapload)
	. = ..()
	LAZYADD(available_faces, SIGMA_OCTANTIS_LINE_1)

/obj/effect/landmark/transport/transport_id/sigma_octantis/line_1
	specific_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/sigma_octantis/engineering
	name = SIGMA_OCTANTIS_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS
	dir = NORTH

/obj/effect/landmark/transport/nav_beacon/tram/platform/sigma_octantis/engineering_station
	name = "Engineering"
	specific_transport_id = SIGMA_OCTANTIS_LINE_1
	platform_code = SIGMA_OCTANTIS_ENGINEERING_STATION
	tgui_icons = list("Engineering" = "wrench")

/obj/effect/landmark/transport/nav_beacon/tram/platform/sigma_octantis/supermatter_satellite
	name = "Supermatter Satellite"
	specific_transport_id = SIGMA_OCTANTIS_LINE_1
	platform_code = SIGMA_OCTANTIS_SUPERMATTER_SAT
	tgui_icons = list("Supermatter Satellite" = "satellite")

/obj/machinery/door/airlock/tram/half
	icon = 'local/icons/obj/doors/airlocks/tram/tram-half.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/tram/tram-half-overlays.dmi'
	multi_tile = FALSE
	bound_width = 32

/obj/machinery/door/window/tram/platform
	name = "platform door"
	desc = "Keeps idiots like you from walking onto the tram tracks."
	icon_state = "left"
	base_state = "left"
	can_atmos_pass = ATMOS_PASS_DENSITY // shaft is airtight when closed
	req_access = list(ACCESS_TCOMMS)
	/// Weakref to the tram we're attached
	var/datum/weakref/transport_ref
	autoclose = FALSE
	var/platform_linked_code

/obj/machinery/door/window/tram/platform/right
	icon_state = "left"
	base_state = "left"

/obj/machinery/door/window/tram/platform/right
	icon_state = "right"
	base_state = "right"

/obj/machinery/door/window/tram/platform/Initialize(mapload)
	. = ..()
	if(!id_tag)
		id_tag = assign_random_name()
	RemoveElement(/datum/element/atmos_sensitive, mapload)
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/door/window/tram/platform/post_machine_initialize()
	. = ..()
	//INVOKE_ASYNC(src, PROC_REF(open))
	SStransport.platform_doors += src
	find_tram()

/obj/machinery/door/window/tram/platform/Destroy()
	SStransport.platform_doors -= src
	return ..()

/**
 * Set the weakref for the tram we're attached to
 */
/obj/machinery/door/window/tram/platform/proc/find_tram()
	for(var/datum/transport_controller/linear/tram/tram as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(tram.specific_transport_id == transport_linked_id)
			transport_ref = WEAKREF(tram)

/obj/machinery/door/window/tram/platform/proc/validate_position(platform_code, travel_remaining)
	if(travel_remaining || platform_code != platform_linked_code)
		close()
	else
		open()

/datum/transport_controller/linear/tram/cycle_doors(door_status, rapid)
	. = ..()
	for(var/obj/machinery/door/window/tram/platform/platform_door as anything in SStransport.platform_doors)
		if(platform_door.transport_linked_id == specific_transport_id)
			INVOKE_ASYNC(platform_door, TYPE_PROC_REF(/obj/machinery/door/window/tram/platform, validate_position), idle_platform.platform_code, travel_remaining)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/tram/platform/left, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/tram/platform/right, 0)

