#define PEANUT_MAX_PATH_DISTANCE 40
#define PEANUT_MAX_SEARCH_DISTANCE DEFAULT_SIGHT_DISTANCE + 2

/obj/structure/peanut

	name = "Peanut"
	desc = "It's peanut!"

	icon = 'modular_zubbers/icons/obj/peanut.dmi'
	icon_state = "peanut"

	density = TRUE

	var/list/mob/living/current_grudges = list()
	var/mob/living/current_target = null

	var/datum/proximity_monitor/proximity_monitor

	var/woke = FALSE

	var/list/current_path

	var/new_proximity = FALSE

	COOLDOWN_DECLARE(pathing_cooldown)

	var/path_step = 0

/obj/structure/peanut/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	current_target = null
	QDEL_NULL(proximity_monitor)
	current_path = null
	current_grudges = null
	. = ..()

/obj/structure/peanut/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, PEANUT_MAX_SEARCH_DISTANCE)

/obj/structure/peanut/proc/wake_up()

	if(woke)
		return FALSE

	START_PROCESSING(SSfastprocess, src)

	return TRUE

/obj/structure/peanut/proc/go_to_sleep()

	if(!woke)
		return FALSE

	STOP_PROCESSING(SSfastprocess, src)
	current_path = null
	current_target = null

	return TRUE


/obj/structure/peanut/proc/is_valid_target(mob/living/possible_target)
	return

/obj/structure/peanut/HasProximity(mob/living/proximity_check as mob) //When something enters our proximity for the first time.

	. = ..()

	if(isliving(proximity_check) && proximity_check.stat != DEAD)
		wake_up()
		current_grudges |= proximity_check

/obj/structure/peanut/process()

	if(!length(current_grudges))
		go_to_sleep()
		return

	var/mob/living/closest_killable_target
	var/closest_killable_distance = PEANUT_MAX_PATH_DISTANCE

	var/is_being_watched = FALSE

	var/turf/our_turf = get_turf(src)
	
	var/list/mob/living/found_viewers //This is set when we need it.

	for(var/mob/living/possible_victim as anything in current_grudges)

		//Check if the target is valid.
		if(QDELETED(possible_victim) || possible_victim.stat == DEAD)
			current_grudges -= possible_victim
			continue

		//Check if the target is even possible to get to.
		var/turf/victim_turf = get_turf(possible_victim)
		if(victim_turf.z != our_turf.z)
			current_grudges -= possible_victim
			continue

		var/victim_distance = get_dist(victim_turf,our_turf)

		//Too far away to path to.
		if(victim_distance > PEANUT_MAX_PATH_DISTANCE)
			current_grudges -= possible_victim
			continue

		//Check if the target is looking at us.
		//We don't need to keep checking for the code inside this if we know we're being watched.
		if(!is_being_watched)

			//Check if we're close enough, if we're conscious, we're facing a target, and we're not blind 
			if(victim_distance <= PEANUT_MAX_SEARCH_DISTANCE && (possible_victim.stat <= SOFT_CRIT) && is_source_facing_target(possible_victim,src) && !possible_victim.is_blind())		
				if(!found_viewers)
					found_viewers = viewers(DEFAULT_SIGHT_DISTANCE,src)
				//Are we actually able to see the target?
				if(possible_victim in found_viewers)
					is_being_watched = TRUE
					continue

			//Check if we already have a closer victim.
			if(victim_distance >= closest_killable_distance)
				continue

			closest_killable_target = possible_victim
			closest_killable_distance = victim_distance

	//If we're being watched, clear our current path.
	if(is_being_watched)
		current_path = null
		return

	//We have a target.
	if(closest_killable_target)

		if(closest_killable_distance <= 1)

			if(ishuman(closest_killable_target))
				src.say("Buenos dias [closest_killable_target.name].")
				closest_killable_target.audible_message(
					span_warning("[src] slaps [closest_killable_target]'s ass!"),
					span_danger("[src] slaps your ass!"),
				)
				playsound(closest_killable_target, 'sound/effects/emotes/assslap.ogg', 90)

				closest_killable_target.investigate_log("has been killed by [src]", INVESTIGATE_DEATHS)

				var/turf/target_turf = get_edge_target_turf(closest_killable_target, get_dir(src,closest_killable_target))
				closest_killable_target.throw_at(target_turf, 255, 4, src, force = MOVE_FORCE_OVERPOWERING) //Shamelessly copied from tram throw code.
			else
				closest_killable_target.investigate_log("has been killed by [src]", INVESTIGATE_DEATHS)
				playsound(closest_killable_target, 'sound/effects/wounds/crack1.ogg', 90)

			closest_killable_target.death(FALSE)

			return

		if(closest_killable_target != current_target)
			current_path = null //Update the path.
		current_target = closest_killable_target

	if(COOLDOWN_FINISHED(src,pathing_cooldown) && !length(current_path) && current_target)
		COOLDOWN_START(src,pathing_cooldown,1 SECONDS)
		var/list/possible_path = get_path_to(src,current_target,max_distance=PEANUT_MAX_PATH_DISTANCE)
		if(!length(possible_path))
			current_grudges -= current_target
			current_target = null
			return
		current_path = possible_path
		path_step = 1

	if(length(current_path))
		var/turf/next_turf = current_path[path_step]
		src.Move(next_turf)
		path_step++
		if(length(current_path) < path_step)
			current_path = null



#undef PEANUT_MAX_PATH_DISTANCE
#undef PEANUT_MAX_SEARCH_DISTANCE
