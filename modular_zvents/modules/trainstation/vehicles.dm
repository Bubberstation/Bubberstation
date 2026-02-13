/obj/vehicle
	var/last_real_move

/obj/vehicle/Move(newloc, dir)
	. = ..()
	last_real_move = world.time

/obj/vehicle/attempt_moving_turf_step(turf/open/moving/moving_turf, direction)
	if(!moving_turf || !SStrain_controller.is_moving())
		return FALSE
	if(!has_buckled_mobs())
		return TRUE
	if(dir != SStrain_controller.abstract_moving_direction)
		return TRUE
	if(last_real_move + 1.5 SECONDS > world.time)
		return FALSE
	return TRUE

/datum/component/riding/vehicle/train_bike
	vehicle_move_delay = 1.5
	override_allow_spacemove = FALSE
	ride_check_flags = RIDER_NEEDS_LEGS | RIDER_NEEDS_ARMS | UNBUCKLE_DISABLED_RIDER

/datum/component/riding/vehicle/train_bike/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list( 0, -8),
		TEXT_SOUTH = list( 0,  4),
		TEXT_EAST =  list(-10, 5),
		TEXT_WEST =  list( 10, 5),
	)

/datum/component/riding/vehicle/train_bike/get_parent_offsets_and_layers()
	return list(
		TEXT_NORTH = list(-16, -16),
		TEXT_SOUTH = list(-16, -16),
		TEXT_EAST =  list(-18,   0),
		TEXT_WEST =  list(-18,   0),
	)

/obj/vehicle/ridden/trainstation
	name = "Badass vehicle"
	icon = 'modular_zvents/icons/vehicles/64x64.dmi'
	icon_state = "bike"
	layer = LYING_MOB_LAYER
	pixel_x = -16
	pixel_y = -16
	light_on = FALSE
	light_range = 5
	light_angle = 90
	light_color = COLOR_WHITE

	var/riding_component_type = /datum/component/riding/vehicle/train_bike
	var/cover_iconstate = "bike_cover"


/obj/vehicle/ridden/trainstation/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, riding_component_type)


/obj/vehicle/ridden/trainstation/buckle_mob(mob/living/M, force, check_loc)
	. = ..()
	M.flags_1 |= NO_TURF_MOVEMENT_1

/obj/vehicle/ridden/trainstation/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	. = ..()
	buckled_mob.flags_1 &= ~NO_TURF_MOVEMENT_1

/obj/vehicle/ridden/trainstation/post_buckle_mob(mob/living/user)
	. = ..()
	update_appearance()

/obj/vehicle/ridden/trainstation/post_unbuckle_mob()
	. = ..()
	update_appearance()

/obj/vehicle/ridden/trainstation/update_overlays()
	. = ..()
	if(has_buckled_mobs())
		var/mutable_appearance/cover_overlay = mutable_appearance(icon, cover_iconstate, ABOVE_MOB_LAYER, src, appearance_flags = KEEP_APART)
		cover_overlay = color_atom_overlay(cover_overlay)
		. += cover_overlay

/obj/vehicle/ridden/trainstation/Move(newloc, dir)
	var/turf/new_turf = newloc
	var/cracked = FALSE
	var/atom/cracked_atom
	for(var/atom/A in new_turf.contents)
		if(A.density)
			cracked = TRUE
			cracked_atom = A
			break
	if(!cracked)
		return ..()
	. = FALSE
	visible_message("[src] crashes into [cracked_atom] and flies back!")
	throw_away(REVERSE_DIR(dir))

/obj/vehicle/ridden/trainstation/proc/throw_away(dir)
	var/dist = rand(2, 4)
	var/turf/target_turf = get_ranged_target_turf(src, dir, dist)
	if(!target_turf)
		return
	throw_at(target_turf, dist, 3, diagonals_first = TRUE)
	Shake()
	for(var/mob/living/L in src.buckled_mobs)
		shake_camera(L, 10, 5)
	take_damage(rand(5, 10))

/obj/vehicle/ridden/trainstation/bike
	name = "Bike"
	icon_state = "bike"
	cover_iconstate = "bike_cover"

/obj/vehicle/ridden/trainstation/bike/red
	icon_state = "bike_scrambler"
	cover_iconstate = "bike_scrambler_cover"

/obj/vehicle/ridden/trainstation/bike/green
	icon_state = "bike_green"
	cover_iconstate = "bike_green_cover"

/obj/vehicle/ridden/trainstation/bike/blue
	icon_state = "bike_flamy"
	cover_iconstate = "bike_flamy_cover"
