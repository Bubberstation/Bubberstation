/obj/effect/shark_infested_waters
	name = "a carp with a fricken laser rifle attached to their head"
	desc = "An ill-tempered endangered species of territorial water carp with a laser rifle on its head. \
	Captured and trained to kill any who attempt to cross its waters. Pretty much unkillable."
	icon = 'modular_zubbers/icons/effects/shark_infested_waters.dmi'
	icon_state = "shark"
	glide_size = 32

	plane = GAME_PLANE
	layer = MOB_LAYER

	//Defines. Feel free to change.
	var/obj/projectile/projectile_type = /obj/projectile/beam/laser/rapid
	var/turf/valid_turf_type = /turf/open/water/moonstation/infested

	//Internal. Do not change.
	var/woke = FALSE
	var/last_detect
	var/mob/living/current_target

	var/datum/proximity_monitor/proximity_monitor

	COOLDOWN_DECLARE(growl_cooldown)

/obj/effect/shark_infested_waters/Destroy()
	QDEL_NULL(proximity_monitor)
	current_target = null
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/effect/shark_infested_waters/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 6)
	src.setDir(pick(GLOB.cardinals))

/obj/effect/shark_infested_waters/HasProximity(atom/movable/arrived)
	. = ..()
	if(!current_target && isliving(arrived))

		if(is_target_valid(arrived))
			set_target(arrived)
		else
			src.setDir(get_dir(src,arrived))
			if(COOLDOWN_FINISHED(src,growl_cooldown) && !prob(80)) // Growl optimization
				COOLDOWN_START(src,growl_cooldown,3 SECONDS)
				src.audible_message(
					span_warning("[src] growls at [arrived]..."),
					hearing_distance = COMBAT_MESSAGE_RANGE
				)

/obj/effect/shark_infested_waters/proc/wake_up()

	if(woke)
		return FALSE

	START_PROCESSING(SSprocessing, src)

	return TRUE

/obj/effect/shark_infested_waters/proc/go_to_sleep()

	if(!woke)
		return FALSE

	set_target(null)

	STOP_PROCESSING(SSprocessing, src)

	return TRUE

/obj/effect/shark_infested_waters/proc/set_target(mob/living/desired_target)

	. = FALSE

	if(current_target)
		current_target = null
		. = TRUE

	if(desired_target)
		current_target = desired_target
		last_detect = world.time
		. = TRUE

	if(current_target)
		wake_up()
	else
		go_to_sleep()


/obj/effect/shark_infested_waters/proc/is_target_valid(mob/living/target_to_check,check_water = TRUE, check_distance = TRUE)

	if(!target_to_check || QDELETED(target_to_check))
		return FALSE

	if(target_to_check.stat & DEAD)
		return FALSE

	if(target_to_check.health >= 1000)
		return FALSE

	if(check_distance && get_dist(src,target_to_check) > 8)
		return FALSE

	var/turf/T = get_turf(target_to_check)

	if(check_water && !istype(T,valid_turf_type))
		return FALSE

	return TRUE

/obj/effect/shark_infested_waters/proc/do_step(desired_dir=0x0)

	if(!desired_dir)
		return FALSE

	var/turf/step_turf = get_step(src,desired_dir)

	if(step_turf && istype(step_turf,valid_turf_type))
		if(locate(/obj/effect/shark_infested_waters) in step_turf) //Prevents stacking.
			return FALSE
		return src.Move(step_turf)

	setDir(desired_dir)

	return FALSE

/obj/effect/shark_infested_waters/process(seconds_per_tick)

	if(current_target && !is_target_valid(current_target,check_water = FALSE))
		set_target(null)

	if(current_target)
		var/target_direction = get_dir(src,current_target)
		if(target_direction)
			do_step(target_direction)
			if(projectile_type)
				var/turf/our_turf = get_turf(src)
				if(our_turf)
					var/obj/projectile/fired_projectile = new projectile_type(our_turf)
					fired_projectile.original = current_target
					fired_projectile.fired_from = src
					fired_projectile.firer = src
					fired_projectile.impacted = list(WEAKREF(src) = TRUE)
					fired_projectile.aim_projectile(current_target, src)
					fired_projectile.fire()

		var/turf/target_turf = get_turf(current_target)
		if(target_turf && istype(target_turf,valid_turf_type))
			last_detect = world.time
		else if((last_detect + 5 SECONDS) <= world.time)
			set_target(null)

