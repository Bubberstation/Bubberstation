/obj/machinery/door/train
	name = "Train door"

/obj/machinery/door/train/lock()
	. = ..()
	locked = TRUE

/obj/machinery/door/train/unlock()
	. = ..()
	locked = FALSE

/obj/machinery/door/train/open(forced)
	if(locked)
		if(usr)
			balloon_alert(usr, "Locked!")
			to_chat(usr, "Door is locked from other side!")
		return
	return ..()

/obj/machinery/door/train/close(forced)
	if(locked)
		if(usr)
			balloon_alert(usr, "Locked!")
			to_chat(usr, "Door is locked!")
		return
	return ..()

/obj/machinery/door/train/train_door
	name = "Train door"
	desc = "A solid metal door, often used in train carriages."
	icon = 'modular_zvents/icons/doors/train_door.dmi'
	has_access_panel = FALSE
	opacity = FALSE

/obj/machinery/door/train/train_door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/redirect_attack_hand_from_turf, interact_check = CALLBACK(src, PROC_REF(drag_check)))

/obj/machinery/door/train/train_door/proc/drag_check(mob/user)
	if(user.pulling)
		return FALSE
	return TRUE

/obj/machinery/door/train/train_door/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.5 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 1.5 SECONDS
		if(DOOR_DENY_ANIMATION)
			return 0.1 SECONDS

/obj/machinery/door/train/train_door/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 1.4 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.5 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 1.5 SECONDS

/obj/machinery/door/airlock/train_locomotive
	name = "Train locomotive"
	desc = "A solid metal door, often used in train carriages."
	icon = 'modular_zvents/icons/doors/locomotive_door.dmi'
	aiControlDisabled = AI_WIRE_DISABLED
	air_tight = TRUE

/obj/machinery/door/airlock/train_locomotive/glass
	icon = 'modular_zvents/icons/doors/locomotive_door_glass.dmi'


/obj/machinery/door/train/coupe_door
	name = "Coupe door"
	desc = "A solid metal door, often used in train carriages."
	icon = 'modular_zvents/icons/doors/coupe_door.dmi'
	has_access_panel = FALSE

/obj/structure/table/train_table
	name = "Train table"
	desc = "A square piece of iron standing on metal leg. It can not move."
	icon = 'modular_zvents/icons/structures/trainstructures.dmi'
	icon_state = "table"
	base_icon_state = "table"
	density = TRUE
	anchored = TRUE
	pass_flags_self = PASSTABLE | LETPASSTHROW
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	max_integrity = 250
	integrity_failure = 0.33
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
	can_flip = FALSE

/obj/structure/table/train_shelf
	name = "Train shelf"
	desc = "A metal simple shelf for storing things."
	icon = 'modular_zvents/icons/structures/trainstructures.dmi'
	icon_state = "shelf_metal"
	base_icon_state = "shelf_metal"
	density = FALSE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	max_integrity = 250
	integrity_failure = 0.33
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
	can_flip = FALSE

/obj/structure/table/train_shelf/wood
	name = "Train wooden shelf"
	icon_state = "shelf_wood"
	base_icon_state = "shelf_wood"
	max_integrity = 150
	custom_materials = list(/datum/material/wood =SHEET_MATERIAL_AMOUNT)


/obj/structure/gangway
	name = "Train gangway"
	desc = "A durable insulated cover connecting two railcars together."
	icon = 'modular_zvents/icons/structures/trainstructures.dmi'
	icon_state = "gangway_still"
	base_icon_state = "gangway_still"
	max_integrity = 1000
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	flags_1 = NO_TURF_MOVEMENT

/obj/structure/gangway/Initialize(mapload)
	. = ..()
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_BEGIN_MOVING, PROC_REF(on_train_begin_moving))
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_STOP_MOVING, PROC_REF(on_train_stop_moving))

/obj/structure/gangway/Destroy(force)
	. = ..()
	UnregisterSignal(SStrain_controller, list(COMSIG_TRAIN_BEGIN_MOVING, COMSIG_TRAIN_STOP_MOVING))

/obj/structure/gangway/proc/on_train_begin_moving()
	SIGNAL_HANDLER

	icon_state = "gangway_moving"

/obj/structure/gangway/proc/on_train_stop_moving()
	SIGNAL_HANDLER

	icon_state = "gangway_still"



/obj/machinery/button/auto_detect
	// Устройство к которому мы подключены
	var/list/atom/connected_device = null
	// Предустановленный билд
	var/prebuild_type = null
	// Радиус поиска цели для коннекта
	var/find_range = 1
	// Список всех типов устройст к которым мы можем быть подключены
	var/static/connectable_devices = list(
		/obj/machinery/door,
		/obj/structure/curtain,
	)


/obj/machinery/button/auto_detect/Initialize(mapload)
	. = ..()
	detect_and_connect()

/obj/machinery/button/auto_detect/proc/is_avaible(atom/object)
	if(!istype(object))
		return FALSE
	if(prebuild_type && istype(object, prebuild_type))
		return TRUE
	for(var/type in connectable_devices)
		if(istype(object, type))
			return TRUE
	return FALSE

/obj/machinery/button/auto_detect/proc/detect_and_connect()
	var/turf/our_turf = get_turf(src)
	for(var/atom/A in range(our_turf, find_range))
		if(isturf(A))
			continue
		if(!is_avaible(A))
			continue
		LAZYADD(connected_device, A)

/obj/machinery/button/auto_detect/attempt_press(mob/user)
	. = ..()
	if(!.)
		return
	if(!length(connected_device))
		return
	for(var/atom/A in connected_device)
		if(istype(A, /obj/machinery/door))
			var/obj/machinery/door/D = A
			if(D.locked)
				D.unlock()
			else
				D.lock()
		if(istype(A, /obj/structure/curtain))
			var/obj/structure/curtain/C = A
			C.toggle()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/button/auto_detect, 24)



/obj/machinery/computer/trainstation_control
	name = "Station control"
	desc = "This computer is used to control the station's locking system. Use it to continue on your way."
	icon_screen = "command"
	icon_keyboard = "id_key"

	interaction_flags_machine = INTERACT_MACHINE_REQUIRES_LITERACY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	var/unlocked = FALSE
	var/datum/train_station/station = null

/obj/machinery/computer/trainstation_control/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	LAZYADD(SStrain_controller.station_terminals, src)

/obj/machinery/computer/trainstation_control/Destroy(force)
	. = ..()
	LAZYREMOVE(SStrain_controller.station_terminals, src)

/obj/machinery/computer/trainstation_control/proc/set_station(datum/train_station/new_station)
	station = new_station
	name = "[station.name] - control terminal"
	SSpoints_of_interest.make_point_of_interest(src)
	add_filter("story_outline", 2, list("type" = "outline", "color" = "#fa3b3b", "size" = 1))

/obj/machinery/computer/trainstation_control/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return

/obj/machinery/computer/trainstation_control/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return

/obj/machinery/computer/trainstation_control/screwdriver_act(mob/living/user, obj/item/I)
	return

/obj/machinery/computer/trainstation_control/interact(mob/user, special_state)
	. = ..()
	if(unlocked)
		return
	if(world.time > next_clicksound && isliving(user))
		next_clicksound = world.time + rand(50, 150)
		playsound(src, SFX_KEYBOARD, 40)
	if(!do_after(user, 3 SECONDS, src))
		return

	unlock_station()
	remove_filter("story_outline")

/obj/machinery/computer/trainstation_control/proc/unlock_station()
	station.blocking_moving = FALSE
	balloon_alert_to_viewers("Station unlocked!")
	SEND_SIGNAL(SStrain_controller, COMSIG_TRAINSTATION_UNLOCKED)
	unlocked = TRUE



/obj/machinery/computer/train_control_terminal
	name = "Train control terminal"
	desc = "This computer is used to control the train and its movement from station to station."
	icon_screen = "command"
	icon_keyboard = "id_key"

	var/read_only = FALSE

/obj/machinery/computer/train_control_terminal/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainControlTerminal")
		ui.open()

/obj/machinery/computer/train_control_terminal/ui_state(mob/user)
	return GLOB.conscious_state

/obj/machinery/computer/train_control_terminal/ui_data(mob/user)
	var/datum/controller/subsystem/train_controller/TC = SStrain_controller
	var/list/data = list()

	data["read_only"] = read_only
	data["is_moving"] = TC.is_moving()
	data["current_station"] = TC.loaded_station?.name || "Unknown"
	data["planned_station"] = TC.planned_to_load?.name || "None"
	data["blocking"] = TC.loaded_station?.blocking_moving || FALSE
	data["possible_next"] = list()
	if(!TC.is_moving() && TC.loaded_station)
		for(var/datum/train_station/next in TC.loaded_station.possible_next)
			data["possible_next"] += list(
				list(
					"name" = next.name,
					"type" = "[next.type]"
				)
			)
	if(TC.is_moving() && TC.total_travel_time > 0)
		data["progress"] = 1 - (TC.time_to_next_station / TC.total_travel_time)
	else
		data["progress"] = 0
	data["time_remaining"] = TC.time_to_next_station || 0

	return data

/obj/machinery/computer/train_control_terminal/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	if(read_only)
		return
	var/datum/controller/subsystem/train_controller/TC = SStrain_controller
	switch(action)
		if("start_moving")
			if(!TC.is_moving() && TC.planned_to_load && !TC.loaded_station?.blocking_moving)
				TC.start_moving()
			return TRUE
		if("stop_moving")
			if(TC.is_moving())
				TC.stop_moving()
			return TRUE
		if("choose_next")
			var/station_type = text2path(params["station_type"])
			if(!station_type)
				return
			var/datum/train_station/next = locate(station_type) in TC.known_stations
			if(!next || !TC.loaded_station || !(next in TC.loaded_station.possible_next))
				return
			TC.planned_to_load = next
			return TRUE

/obj/machinery/computer/train_control_terminal/read_only
	read_only = TRUE

/obj/machinery/power/turbine
