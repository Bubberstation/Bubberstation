#define MINIMAL_TEMPETURE_DIFF 10
#define GYROSCOPE_MAX_ANGLE 50
#define MINIMAL_GYRO_DIFF 30

#define CARGO_STORAGE_ATMOS GAS_N2 + "=100;TEMP=233.15"

/obj/machinery/train_cargo_dock
	name = "Cargo dock port"
	desc = "Metal port where reinforced cargo can be placed."
	icon = 'icons/obj/machines/bitrunning.dmi'
	icon_state = "byteforge"
	density = FALSE
	opacity = FALSE
	uses_integrity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1

	anchored = TRUE

/obj/machinery/train_cargo_dock/proc/cargo_connected(cargo)
	if(!istype(cargo, /obj/machinery/train_cargo))
		return
	alpha = 0
	invisibility = INVISIBILITY_ABSTRACT

/obj/machinery/train_cargo_part
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	uses_integrity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1
	use_power = FALSE
	idle_power_usage = 0

/obj/machinery/train_cargo
	name = "Strange cargo container"
	desc = "A large, sealed container with no markings. It hums with an unknown energy."
	icon = 'modular_zvents/icons/machinery/train_cargo.dmi'
	icon_state = "main"
	density = TRUE
	uses_integrity = FALSE
	processing_flags = START_PROCESSING_MANUALLY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1

	pixel_x = -32
	pixel_y = -18
	plane = MASSIVE_OBJ_PLANE
	power_channel = AREA_USAGE_EQUIP
	idle_power_usage = 2000 WATTS
	layer = ABOVE_TREE_LAYER

	// Основные параметры
	var/container_health = 100
	var/container_max_health = 100

	// Температура
	var/max_temperature = TM15C
	var/minimal_temperature = TM70C
	var/container_temperature = TM40C
	var/heat_expose = 10

	// ГИРОСКОП
	var/gyroscope_position = 0
	var/gyroscope_required = 0
	var/gyroscope_desired = 0

	var/gyroscope_drift_strength = 0.65
	var/gyroscope_follow_speed = 0.85
	var/gyroscope_convince_speed = 0.9

	var/last_damage_time = 0
	var/last_damage = 0

	var/sealed = TRUE

	var/damage_cooldown = 4 SECONDS
	var/heat_expose_cooldown = 5 SECONDS
	var/temp_anomaly_cooldown = 5 MINUTES
	var/gyro_anomaly_cooldown = 8.5 MINUTES

	COOLDOWN_DECLARE(damage_cd)
	COOLDOWN_DECLARE(heat_cd)
	COOLDOWN_DECLARE(temp_anomaly_cd)
	COOLDOWN_DECLARE(gyro_anomaly_cd)

	VAR_PRIVATE/list/parts = list()

/obj/machinery/train_cargo/Destroy(force)
	for(var/obj/machinery/train_cargo_part/part in parts)
		qdel(part)
	QDEL_NULL(parts)
	return ..()

/obj/machinery/train_cargo/process(seconds_per_tick)
	if(!istype(get_area(src), /area/trainstation))
		return

	var/has_power = powered()
	var/moving = SStrain_controller?.is_moving() || FALSE


	if(SPT_PROB(5, seconds_per_tick))
		var/drift_step = rand(-2.5, 2.5) * (moving ? 2 : 1)
		gyroscope_desired += drift_step
		gyroscope_desired = clamp(gyroscope_desired, -GYROSCOPE_MAX_ANGLE, GYROSCOPE_MAX_ANGLE)

	var/max_change = 1.5 * seconds_per_tick
	var/direction_to_target = gyroscope_required - gyroscope_position
	var/actual_change = clamp(direction_to_target * gyroscope_follow_speed, -max_change, max_change)
	if(abs(gyroscope_position - gyroscope_required) > 3)
		gyroscope_position += actual_change * gyroscope_convince_speed
	var/noise = rand(-0.4, 0.4) * (moving ? 2 : 0.2)
	gyroscope_position += noise
	gyroscope_position = clamp(gyroscope_position, -GYROSCOPE_MAX_ANGLE, GYROSCOPE_MAX_ANGLE)

	var/turf/T = get_turf(src)
	var/datum/gas_mixture/air = T?.return_air()
	if(air)
		var/temp_diff = container_temperature - air.temperature
		if(abs(temp_diff) > MINIMAL_TEMPETURE_DIFF)
			container_temperature -= temp_diff * 0.60 * seconds_per_tick

	var/gyro_dev = abs(gyroscope_position - gyroscope_desired)
	var/temp_bad = container_temperature > max_temperature || container_temperature < minimal_temperature
	var/should_damage = temp_bad || gyro_dev > MINIMAL_GYRO_DIFF || !has_power

	if(should_damage && COOLDOWN_FINISHED(src, damage_cd))
		var/damage = 0
		if(!has_power)
			damage += 0.8
		if(container_temperature > max_temperature)
			damage += (container_temperature - max_temperature) * 0.12
		if(container_temperature < minimal_temperature)
			damage += (minimal_temperature - container_temperature) * 0.12
		damage += gyro_dev * 0.09

		damage = clamp(damage, 0.5, last_damage + 1)

		container_health = max(0, container_health - damage)
		last_damage = damage
		last_damage_time = world.time

		if(prob(40))
			Shake(2, 2, 1.5 SECONDS)
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 75, TRUE)

		COOLDOWN_START(src, damage_cd, damage_cooldown)

	else if(world.time - last_damage_time > 7 SECONDS && has_power)
		var/reg = 0.7
		if(gyro_dev < 6)
			reg += 0.9
		container_health = min(container_max_health, container_health + reg * seconds_per_tick)

	if(COOLDOWN_FINISHED(src, heat_cd))
		if(air)
			air.temperature += heat_expose / air.heat_capacity()
			air_update_turf(FALSE, FALSE)
		COOLDOWN_START(src, heat_cd, heat_expose_cooldown)

	if(COOLDOWN_FINISHED(src, temp_anomaly_cd))
		if(prob(60))
			container_temperature += rand(15, 35)
			balloon_alert_to_viewers("Temperature anomaly detected!")
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 70, TRUE)
		COOLDOWN_START(src, temp_anomaly_cd, temp_anomaly_cooldown)

	if(COOLDOWN_FINISHED(src, gyro_anomaly_cd))
		if(prob(70))
			gyroscope_desired = rand(-45, 45)
			balloon_alert_to_viewers("Gyroscope anomaly detected!")
			Shake(4, 4, 2 SECONDS)
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 90, TRUE)
		COOLDOWN_START(src, gyro_anomaly_cd, gyro_anomaly_cooldown)


/obj/machinery/train_cargo/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	var/turf/new_turf = get_turf(src)
	for(var/atom/movable/A in new_turf.contents)
		if(istype(A, /obj/machinery/train_cargo_dock))
			if(connect_to_dock(A))
				break

/obj/machinery/train_cargo/proc/connect_to_dock(dock)
	if(!istype(dock, /obj/machinery/train_cargo_dock))
		return FALSE
	balloon_alert_to_viewers("Connecting to dock!")
	var/failed = FALSE
	for(var/turf/T in orange(1, src))
		if(isclosedturf(T))
			T.balloon_alert_to_viewers("Blocked by closed turf!")
			failed = TRUE
	if(failed)
		return FALSE
	var/obj/machinery/train_cargo_dock/d = dock
	d.cargo_connected(src)
	anchored = TRUE
	INVOKE_ASYNC(src, PROC_REF(after_connect))
	return TRUE

/obj/machinery/train_cargo/proc/after_connect()
	balloon_alert_to_viewers("Initialize the containment procedure!")
	for(var/turf/T in orange(1, src))
		var/obj/machinery/train_cargo_part/part = new(T)
		part.name = name
		part.desc = desc
		parts += part
	sleep(5 SECONDS)
	Shake(5, 5, 5 SECONDS, 3)
	sleep(5 SECONDS)
	begin_processing()
	set_light(6, 2, COLOR_CARP_DARK_BLUE, l_on = TRUE)
	balloon_alert_to_viewers("Initialized!")

/obj/machinery/computer/train_cargo_control
	name = "Cargo control console"
	desc = "Abnormal cargo control console."
	icon_state = "computer"
	density = TRUE
	uses_integrity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	// circuit = /obj/item/circuitboard/computer/train_cargo_control

	var/obj/machinery/train_cargo/linked_cargo

/obj/machinery/computer/train_cargo_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(!linked_cargo)
		find_linked_cargo()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainCargoControl")
		ui.open()

/obj/machinery/computer/train_cargo_control/ui_data(mob/user)
	var/list/data = list()

	if(linked_cargo)
		data["connected"] = TRUE
		data["container_health"] = linked_cargo.container_health
		data["container_temperature"] = linked_cargo.container_temperature
		data["max_temperature"] = linked_cargo.max_temperature
		data["minimal_temperature"] = linked_cargo.minimal_temperature
		data["gyro_position"] = linked_cargo.gyroscope_position
		data["gyro_required"] = linked_cargo.gyroscope_required
		data["gyro_desired"] = linked_cargo.gyroscope_desired
		data["moving"] = SStrain_controller?.is_moving() || FALSE
		data["powered"] = linked_cargo.powered()
	else
		data["connected"] = FALSE

	return data

/obj/machinery/computer/train_cargo_control/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(!linked_cargo)
		return

	switch(action)
		if("set_gyro_target")
			var/value = text2num(params["value"])
			if(isnum(value))
				value = clamp(value, -50, 50)
				linked_cargo.gyroscope_required = value
				. = TRUE
			else
				. = FALSE

/obj/machinery/computer/train_cargo_control/Initialize(mapload)
	. = ..()
	find_linked_cargo()

/obj/machinery/computer/train_cargo_control/proc/find_linked_cargo()
	for(var/obj/machinery/train_cargo/C in range(7, src))
		linked_cargo = C
		return

/turf/open/floor/plating/cold_cargo_storage
	initial_gas_mix = CARGO_STORAGE_ATMOS

/turf/open/floor/iron/dark/cold_cargo_storage
	initial_gas_mix = CARGO_STORAGE_ATMOS

/turf/open/floor/catwalk_floor/iron_dark/cold_cargo_storage
	initial_gas_mix = CARGO_STORAGE_ATMOS
