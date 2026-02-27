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
			return 0.7 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 0.8 SECONDS
		if(DOOR_DENY_ANIMATION)
			return 0.1 SECONDS

/obj/machinery/door/train/train_door/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 0.7 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 0.8 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 0.7 SECONDS

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
	flags_1 = NO_TURF_MOVEMENT_1

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
	var/current_code = ""

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
	ui_interact(user)

/obj/machinery/computer/trainstation_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainStationControl")
		ui.open()

/obj/machinery/computer/trainstation_control/ui_data(mob/user)
	var/list/data = list()
	data["unlocked"] = unlocked
	data["requires_password"] = station?.required_password
	data["station_name"] = station?.name
	data["entered_code"] = replacetextEx(current_code, ".", "*")
	return data

/obj/machinery/computer/trainstation_control/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(unlocked)
		return TRUE
	playsound(src, SFX_KEYBOARD, 40)

	switch(action)
		if("unlock")
			if(station.required_password)
				return TRUE
			unlock_station()
			return TRUE

		if("digit")
			if(!station.required_password)
				return TRUE

			var/dig = params["dig"]
			if(!isnum(text2num(dig)))
				return TRUE

			if(length(current_code) >= 5)
				return TRUE

			current_code += dig
			. = TRUE

		if("clear")
			if(!station.required_password)
				return TRUE

			current_code = ""
			. = TRUE

		if("enter")
			if(!station.required_password)
				return TRUE

			if(!do_after(usr, 1 SECONDS, src))
				return TRUE

			if(!station.is_right_code(current_code))
				balloon_alert(usr, "incorrect code!")
				current_code = ""
				return TRUE

			unlock_station()
			current_code = ""
			return TRUE

/obj/machinery/computer/trainstation_control/proc/unlock_station()
	station.blocking_moving = FALSE
	balloon_alert_to_viewers("Station unlocked!")
	priority_announce("Station's magnetic locks were disabled. Traffic permitted.", station?.name)
	SEND_SIGNAL(SStrain_controller, COMSIG_TRAINSTATION_UNLOCKED)
	unlocked = TRUE
	remove_filter("story_outline")

/obj/item/paper/trainstation_password
	name = "station security update"
	default_raw_text = \
	"<center><b>York-3 Higher Chamber Directive</b></center>\
	<BR>\
	Station: <b>%STATIONNAME%</b>\
	<BR><BR>\
	Magnetic interlock password has been changed.\
	<BR>\
	New code: <b>%STATIONPASSWORD%</b>\
	<BR><BR>\
	<b>CLASSIFIED – LEVEL III</b><BR>\
	This document is confidential.<BR>\
	Do not copy. Do not discuss. Do not leave unsecured.\
	<BR><BR>\
	<BR>\
	— York-3 Metropolitan Council"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/paper/trainstation_password/Initialize(mapload)
	var/datum/train_station/current_station = SStrain_controller?.loaded_station
	name = "[current_station.name] - security update"
	default_raw_text = replacetext(default_raw_text, "%STATIONNAME%", current_station.name)
	default_raw_text = replacetext(default_raw_text, "%STATIONPASSWORD%", current_station.get_password())
	SSpoints_of_interest.make_point_of_interest(src)
	return ..()


/obj/machinery/computer/train_control_terminal
	name = "Train control terminal"
	desc = "This computer is used to control the train and its movement from station to station."
	icon_screen = "command"
	icon_keyboard = "id_key"

	var/read_only = FALSE
	COOLDOWN_DECLARE(toggle_moving_cd)

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
	data["train_engine_active"] = TC.train_engine?.is_active() || FALSE
	data["current_station"] = TC.loaded_station?.name || "Unknown"
	data["planned_station"] = TC.planned_to_load?.name || "None"
	data["blocking"] = TC.loaded_station?.blocking_moving || FALSE
	data["progress"] = TC.is_moving() && TC.total_travel_time > 0 ? 1 - (TC.time_to_next_station / TC.total_travel_time) : 0
	data["time_remaining"] = TC.time_to_next_station || 0
	data["time_per_map_unit"] = TC.time_per_map_unit

	data["possible_next"] = list()
	if(!TC.is_moving() && TC.loaded_station)
		for(var/datum/train_station/next in TC.loaded_station.possible_next)
			data["possible_next"] += list(list(
				"name" = next.name,
				"type" = "[next.type]"
			))

	if(TC.global_map)
		TC.global_map.update_train_position()

	data["map_data"] = TC.global_map?.get_ui_data() || list(
		"objects" = list(),
		"paths" = list(),
		"train" = list("x" = 500, "y" = 500, "angle" = 0)
	)

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
			if(!TC.train_engine.is_active())
				balloon_alert_to_viewers("Train engine is not active!")
				return TRUE
			if(!COOLDOWN_FINISHED(src, toggle_moving_cd))
				balloon_alert_to_viewers("Please wait before toggling movement again.")
				return TRUE
			if(!TC.is_moving() && TC.planned_to_load && !TC.loaded_station?.blocking_moving)
				TC.attempt_start()
				COOLDOWN_START(src, toggle_moving_cd, 60 SECONDS)
			return TRUE
		if("stop_moving")
			if(!COOLDOWN_FINISHED(src, toggle_moving_cd))
				balloon_alert_to_viewers("Please wait before toggling movement again.")
				return TRUE
			if(TC.is_moving())
				COOLDOWN_START(src, toggle_moving_cd, 60 SECONDS)
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
	name = "Train terminal"
	read_only = TRUE

/obj/machinery/recharge_station/train
	name = "train recharging station"
	desc = "A specialized recharging station for synthetics only. It slowly recharges and repairs silicon-based lifeforms."
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.05
	density = FALSE
	req_access = null
	state_open = TRUE
	processing_flags = NONE
	var/always_repair = TRUE
	var/always_charge = TRUE
	var/slow_recharge_speed = 500
	var/slow_repairs = 1

/obj/machinery/recharge_station/train/Initialize(mapload)
	. = ..()

	if(materials)
		QDEL_NULL(materials)
	sendmats = FALSE

	recharge_speed = slow_recharge_speed
	repairs = slow_repairs
	update_appearance()

/obj/machinery/recharge_station/train/RefreshParts()
	. = ..()
	recharge_speed = slow_recharge_speed
	repairs = slow_repairs

/obj/machinery/recharge_station/train/examine(mob/user)
	. = ..()
	. += span_notice("This station slowly recharges and repairs synthetics only.")

/obj/machinery/recharge_station/train/process(seconds_per_tick)
	if(QDELETED(occupant) || !is_operational)
		return

	update_use_power(ACTIVE_POWER_USE)
	SEND_SIGNAL(occupant, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, charge_cell, seconds_per_tick, repairs, FALSE)
	if(always_charge)
		if(iscyborg(occupant))
			var/mob/living/silicon/robot/robot = occupant
			if(robot.cell)
				robot.cell.give(slow_recharge_speed * seconds_per_tick * 0.5)
		if(ishuman(occupant) && issynthetic(occupant))
			var/mob/living/carbon/human/synth = occupant
			var/obj/item/organ/stomach/synth/synth_cell = synth.get_organ_slot(ORGAN_SLOT_STOMACH)
			if(synth_cell && !QDELETED(synth_cell))
				var/energy_delivered = slow_recharge_speed * seconds_per_tick * 0.5
				var/nutrition_gained = (energy_delivered / 200) / SSmachines.wait
				synth.nutrition = min(NUTRITION_LEVEL_FULL, synth.nutrition + nutrition_gained)


	if(always_repair)
		if(issilicon(occupant))
			var/mob/living/silicon/silicon = occupant
			silicon.adjust_brute_loss(-0.5 * seconds_per_tick)
			silicon.adjust_fire_loss(-0.5 * seconds_per_tick)
		if(ishuman(occupant) && issynthetic(occupant))
			var/mob/living/carbon/human/synth = occupant
			synth.adjust_brute_loss(-0.5 * seconds_per_tick)
			synth.adjust_fire_loss(-0.5 * seconds_per_tick)
	// No restocking or extra features
	sendmats = FALSE

/obj/item/key/master_key
	name = "train master key"
	desc = "A large key used to unlock train doors."

/obj/item/key/master_key/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(istype(interacting_with, /obj/machinery/door/train))
		var/obj/machinery/door/train/D = interacting_with
		D.balloon_alert_to_viewers("Begin opening!")
		D.visible_message(span_notice("[user] uses \the [src] on \the [D]."))
		if(!do_after(user, 5 SECONDS, D))
			D.balloon_alert_to_viewers("Opening cancelled!")
			return TRUE
		if(D.locked)
			D.unlock()
			balloon_alert(user, "You unlock the train door with the master key.")
		else
			D.lock()
			balloon_alert(user, "You lock the train door with the master key.")
		return TRUE

/obj/effect/turf_decal/train_sigh
	name = "Train sigh"
	icon = 'modular_zvents/icons/structures/train_sigh.dmi'
	icon_state = "sigh"

/obj/structure/prop/big/military_nuke
	name = "Military container"
	desc = "An incredibly sturdy, locked container. What could be inside?"
	icon = 'modular_zvents/icons/structures/props/goon/64x48.dmi'
	anchored = FALSE
	opacity = FALSE
	density = TRUE
	icon_state = "car-nukes"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1
	base_pixel_x = -16
	pixel_x = -16

/obj/structure/prop/big/military_nuke/examine(mob/user)
	. = ..()
	. += span_purple("This is an important cargo - it should not be lost.")

/obj/structure/prop/big/military_nuke/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)
