/datum/train_station/near_station/cargo_station
	name = "Nearstation - Cargo station"
	map_path = "_maps/modular_events/trainstation/nearstations/static_cargo_station.dmm"

/datum/train_station/cargo_station
	name = "Cargo station"
	map_path = "_maps/modular_events/trainstation/cargo_station.dmm"
	desc = "An old but reliable station for loading cargo onto freight trains. \
			This particular one is located inside a mountain range."

	possible_nearstations = list(/datum/train_station/near_station/cargo_station)
	station_flags = TRAINSTATION_NO_SELECTION
	region = TRAINSTATION_REGION_THUNDRA
	station_type = TRAINSTATION_TYPE_CARGO
	required_password = FALSE
	required_stations = 0
	maximum_visits = INFINITY
	threat_level = THREAT_LEVEL_SAFE
	creator = "Fenysha"

/datum/train_station/cargo_station/thundra_1
	name = "Emergency Cargo station"

/datum/train_station/cargo_station/thundra_2
	name = "River Cargo station"
	map_path = "_maps/modular_events/trainstation/cargo_station_river.dmm"
	desc = "An old but reliable station for loading cargo onto freight trains. \
			This particular one is located inside a mountain range."

/datum/train_station/cargo_station/after_load()
	. = ..()
	if(!SSshuttle.supply)
		if(SSshuttle.load_template(new /datum/map_template/shuttle/cargo/cargo_train()))
			SSshuttle.moveShuttle(SSshuttle.supply, "cargo_away", TRUE)
	else if(SSshuttle.supply && !istype(SSshuttle.supply, /obj/docking_port/mobile/supply/cargo_train))
		SSshuttle.supply.jumpToNullSpace()
		if(SSshuttle.load_template(new /datum/map_template/shuttle/cargo/cargo_train()))
			SSshuttle.moveShuttle(SSshuttle.supply, "cargo_away", TRUE)

/datum/train_station/cargo_station/pre_unload()
	. = ..()
	if(SSshuttle.supply && SSshuttle.supply.getDockedId() != "cargo_away")
		SSshuttle.moveShuttle(SSshuttle.supply, "cargo_away", TRUE)

/obj/machinery/computer/cargo
	var/is_train_cargo = FALSE

/obj/machinery/computer/cargo/train_cargo
	name = "Cargo train console"
	desc = "Used to order supplies, approve requests, and control the cargo train."
	safety_warning = "For safety and ethical reasons, the automated cargo train cannot transport live organisms, \
		human remains, classified nuclear weaponry, mail, undelivered departmental order crates, syndicate bombs, \
		homing beacons, unstable eigenstates, fax machines, or machinery housing any form of artificial intelligence."
	is_train_cargo = TRUE

/obj/machinery/computer/cargo/interact(mob/user, special_state)
	if(SStrain_controller.mode_active && !is_train_cargo)
		balloon_alert_to_viewers("Cargo shuttl will not work on this planet!")
		return
	return ..()

/obj/structure/train_car_blank
	name = "Train cargo"
	desc = "Moving train cargo, better not to stay on it's way!"
	icon = 'modular_zvents/icons/structures/train_blank.dmi'
	icon_state = "normal"
	density = TRUE
	uses_integrity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1

	plane = MASSIVE_OBJ_PLANE
	appearance_flags = LONG_GLIDE

	var/obj/structure/train_car_blank/parent = null

	var/car_width = 17
	var/car_height = 12

	/// How often fake wagons move, in deciseconds
	var/step_delay = 2

/obj/structure/train_car_blank/proc/get_length_for_dir(direction)
	if(direction == EAST || direction == WEST)
		return car_width
	return car_height

/obj/structure/train_car_blank/proc/get_covered_turfs()
	return block(get_turf(src), locate(x + car_width, y + car_height, z))

/obj/structure/train_car_blank/proc/crush_contents()
	var/list/turfs = get_covered_turfs()
	if(!turfs?.len)
		return

	for(var/turf/T as anything in turfs)
		for(var/atom/movable/AM in T)
			if(AM == src)
				continue
			if(istype(AM, /obj/structure/train_car_blank))
				continue
			if(AM.plane >= plane || isobserver(AM) || iseffect(AM))
				continue
			if(isclosedturf(AM))
				qdel(AM)
				continue
			if(isliving(AM))
				var/mob/living/L = AM
				L.apply_damage(60, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
				L.apply_damage(40,  BRUTE, BODY_ZONE_HEAD)
				L.apply_damage(30,  BRUTE, BODY_ZONE_L_ARM)
				L.apply_damage(25,  BRUTE, BODY_ZONE_R_ARM)
				L.apply_damage(25,  BRUTE, BODY_ZONE_L_LEG)
				L.apply_damage(25,  BRUTE, BODY_ZONE_R_LEG)

				if(T.z < world.maxz && isopenturf(locate(T.x, T.y, T.z + 1)))
					var/turf/target = get_step_multiz(L, UP)
					if(target && isopenturf(target))
						L.throw_at(target, 10, 4, src, TRUE)
					else
						var/turf/down = get_step_multiz(L, DOWN)
						if(down && isopenturf(down))
							L.throw_at(down, 10, 4, src, TRUE)
						else
							L.Paralyze(60)
							L.emote("scream")

				else if(T.z > 1 && isopenturf(locate(T.x, T.y, T.z - 1)))
					var/turf/target = get_step_multiz(L, DOWN)
					if(target && isopenturf(target))
						L.throw_at(target, 10, 4, src, TRUE)
					else
						L.Paralyze(60)
						L.emote("scream")

				else
					var/dir = pick(GLOB.cardinals)
					var/turf/target = get_edge_target_turf(L, dir, 10)
					L.throw_at(target, 10, 4, src, TRUE)
					L.Paralyze(40)
				continue
			if(AM.density)
				playsound(AM, 'sound/effects/meteorimpact.ogg', 40, TRUE)
				qdel(AM)
				continue

/obj/structure/train_car_blank/proc/step_and_crush(direction)
	dir = direction
	crush_contents()
	var/turf/next = get_step(src, direction)
	if(!next)
		qdel(src)
		return FALSE
	step(src, direction)
	crush_contents()
	return TRUE


/datum/map_template/shuttle/cargo/cargo_train
	prefix = "_maps/modular_events/"
	suffix = "trainstation"
	name = "Cargo train"

/obj/docking_port/mobile/supply/cargo_train
	name = "Cargo train"
	callTime = 3 MINUTES

	var/fake_car_count = 3
	var/fake_step_delay = 0.1 SECONDS
	var/arrival_pre_tiles = 20
	var/arrival_post_tiles = 255


/obj/docking_port/mobile/supply/cargo_train/proc/get_forward_dir_for_dock(obj/docking_port/stationary/dock)
	if(!dock)
		return dir
	return EAST

/obj/docking_port/mobile/supply/cargo_train/proc/get_wagon_length(direction)
	if(direction == EAST || direction == WEST)
		return initial(/obj/structure/train_car_blank::car_width)
	return initial(/obj/structure/train_car_blank::car_height)

/obj/docking_port/mobile/supply/cargo_train/proc/get_offset_turf(turf/start, direction, distance)
	if(!start || !direction || !distance)
		return start
	var/turf/current = start
	for(var/i in 1 to distance)
		current = get_step(current, direction)
		if(!current)
			break
	return current

/obj/docking_port/mobile/supply/cargo_train/proc/play_arrival_train(obj/docking_port/stationary/cargo_station/dock)
	if(!dock)
		return

	var/turf/anchor = get_turf(dock)
	if(!anchor)
		return

	var/forward_dir = get_forward_dir_for_dock(dock)
	var/arrive_dir = REVERSE_DIR(forward_dir)

	var/len = get_wagon_length(forward_dir)
	var/spacing = len + 1

	var/list/cars = list()

	for(var/i = 0, i < fake_car_count, i++)
		var/dist = arrival_pre_tiles + i * spacing
		var/turf/spawn_loc = get_offset_turf(anchor, arrive_dir, dist)
		if(!spawn_loc)
			continue
		var/obj/structure/train_car_blank/C = new(spawn_loc)
		C.dir = arrive_dir
		cars += C

	var/total_steps = arrival_pre_tiles + arrival_post_tiles
	for(var/step_index = 1, step_index <= total_steps, step_index++)
		var/any = FALSE
		for(var/obj/structure/train_car_blank/C as anything in cars)
			if(QDELETED(C))
				continue
			any = TRUE
			if(!C.step_and_crush(arrive_dir))
				continue
		if(!any)
			break
		sleep(fake_step_delay)

	for(var/obj/structure/train_car_blank/C as anything in cars)
		if(!QDELETED(C))
			qdel(C)

/obj/docking_port/mobile/supply/cargo_train/proc/play_departure_train(obj/docking_port/stationary/cargo_station/dock)
	if(!dock)
		return

	var/turf/anchor = get_turf(dock)
	if(!anchor)
		return

	var/forward_dir = get_forward_dir_for_dock(dock)
	var/len = get_wagon_length(forward_dir)
	var/spacing = len + 1

	var/list/cars = list()
	for(var/i = 0, i < fake_car_count, i++)
		var/dist = i * spacing
		var/turf/spawn_loc = get_offset_turf(anchor, forward_dir, dist)
		if(!spawn_loc)
			continue
		var/obj/structure/train_car_blank/C = new(spawn_loc)
		C.dir = forward_dir
		cars += C

	ASYNC
		while(TRUE)
			var/any = FALSE
			for(var/obj/structure/train_car_blank/C as anything in cars)
				if(QDELETED(C))
					continue
				any = TRUE
				if(!C.step_and_crush(forward_dir))
					continue
				var/turf/T = get_turf(C)
				if(!T)
					qdel(C)
					continue
				if(T.x <= 1 || T.x >= world.maxx || T.y <= 1 || T.y >= world.maxy)
					qdel(C)
			if(!any)
				break
			sleep(fake_step_delay)

/obj/docking_port/mobile/supply/cargo_train/initiate_docking(obj/docking_port/stationary/new_dock, force=FALSE)
	var/obj/docking_port/stationary/old_dock = get_docked()

	if(istype(new_dock, /obj/docking_port/stationary/cargo_station))
		play_arrival_train(new_dock)
		return ..(new_dock, force)

	var/result = ..(new_dock, force)

	if(result == DOCKING_SUCCESS && istype(old_dock, /obj/docking_port/stationary/cargo_station))
		play_departure_train(old_dock)

	return result

/obj/docking_port/mobile/supply/cargo_train/canDock(obj/docking_port/stationary/stationary_dock)
	return SHUTTLE_CAN_DOCK


/obj/docking_port/stationary/cargo_station
	name = "Cargo train dock"
	override_can_dock_checks = TRUE
	shuttle_id = "cargo_home"

