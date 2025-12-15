/obj/effect/shark_infested_waters
	name = "a carp with a fricken laser rifle attached to their head"
	desc = "An ill-tempered endangered species of territorial water carp with a laser rifle on its head. Captured and trained to kill any who attempt to cross its waters. Pretty much killable."
	icon = 'modular_zubbers/icons/effects/shark_infested_waters.dmi'
	icon_state = "shark"
	glide_size = 32

	plane = GAME_PLANE
	layer = MOB_LAYER

	//Defines. Feel free to change.
	var/obj/projectile/projectile_type = /obj/projectile/beam/laser/carbine
	var/turf/valid_turf_type = /turf/open/water/moonstation/infested

	//Internal. Do not change.
	var/woke = FALSE
	var/last_hit
	var/mob/living/current_target

	var/datum/proximity_monitor/proximity_monitor

/obj/effect/shark_infested_waters/Destroy()
	QDEL_NULL(proximity_monitor)
	current_target = null
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/effect/shark_infested_waters/Initialize(mapload)
	proximity_monitor = new(src, 6)


/obj/effect/shark_infested_waters/HasProximity(atom/movable/arrived)
	. = ..()
	if(!current_target && isliving(arrived) && is_target_valid(arrived))
		set_target(arrived)

/obj/effect/shark_infested_waters/proc/wake_up()

	if(woke)
		return FALSE

	START_PROCESSING(SSprocessing, src)
	last_hit = world.time

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
		wake_up()
		. = TRUE


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
		return src.Move(step_turf)

	setDir(desired_dir)

	return FALSE

/obj/effect/shark_infested_waters/proc/check_on_hit(atom/movable/firer, atom/target, angle, hit_limb, blocked, pierce_hit)

	SIGNAL_HANDLER

	if(target == current_target)
		last_hit = world.time


/obj/effect/shark_infested_waters/process(seconds_per_tick)

	if(current_target && !is_target_valid(current_target,check_water = FALSE))
		set_target(null)
		go_to_sleep()

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
					RegisterSignal(fired_projectile, COMSIG_PROJECTILE_ON_HIT, PROC_REF(check_on_hit))
					fired_projectile.fire()

		if( (last_hit + 10 SECONDS) <= world.time)
			go_to_sleep()


