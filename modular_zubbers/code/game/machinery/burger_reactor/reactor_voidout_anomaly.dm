/obj/machinery/power/rbmk2/proc/trigger_voidout()

	var/turf/origin_turf = get_turf(src)

	log_game("[src] triggered a voidout at [AREACOORD(origin_turf)]")
	investigate_log("triggered a voidout at [AREACOORD(origin_turf)]", INVESTIGATE_ENGINE)

	for(var/obj/machinery/power/rbmk2/found_engine in range(8,src))
		found_engine.on_voidout()

	var/obj/effect/voidout/voidout_effect = locate() in range(8,src)
	if(!voidout_effect)
		voidout_effect = new(origin_turf)

	return voidout_effect


/obj/machinery/power/rbmk2/proc/on_voidout()

	if(!stored_rod)
		return FALSE

	qdel(stored_rod)
	stored_rod = null
	active = FALSE

	update_appearance(UPDATE_ICON)

	return TRUE

/obj/effect/voidout
	name = "???"
	desc = "We've been burying them wrong."

	icon = 'modular_zubbers/icons/obj/voidout.dmi'
	icon_state = "voidout"

	var/mob/living/kill_target

	var/current_power = 0

	COOLDOWN_DECLARE(search_cooldown)

/obj/effect/voidout/Initialize(mapload)
	. = ..()
	if(!kill_target)
		var/mob/living/found_target = find_target()
		if(found_target)
			set_target(found_target)
	playsound(src, 'modular_zubbers/sound/machines/rbmk2/voidout.ogg', 50, FALSE, extrarange = 16, pressure_affected = FALSE, use_reverb = FALSE)
	START_PROCESSING(SSsinguloprocess, src)

/obj/effect/voidout/Destroy()
	STOP_PROCESSING(SSsinguloprocess, src)
	set_target(null)
	. = ..()

/obj/effect/voidout/process(seconds_per_tick)

	if(current_power < 10) //Give it some time before chasing. This is measured in seconds (not deciseconds!)
		current_power += seconds_per_tick
		return

	if(!kill_target)
		if(COOLDOWN_FINISHED(src, search_cooldown))
			var/mob/living/found_target = find_target()
			if(found_target)
				set_target(found_target)
		return

	if(QDELETED(kill_target) || kill_target.stat == DEAD)
		set_target(null)
		return

	var/turf/our_turf = get_turf(src)
	var/turf/their_turf = get_turf(kill_target)

	if(our_turf.z != their_turf.z)
		set_target(null)
		return

	if(our_turf == their_turf)
		kill_target.blood_volume = 0
		qdel(src) //Satisfied
		return

	step_towards(src,their_turf)

/obj/effect/voidout/proc/set_target(mob/living/desired_target)

	if(desired_target)
		desired_target.ominous_nosebleed()

	kill_target = desired_target

/obj/effect/voidout/proc/find_target()

	var/mob/living/carbon/human/best_target
	var/best_distance

	for(var/mob/living/carbon/human/potential_target in viewers(8,src))
		if(!potential_target.client)
			continue
		if(potential_target.stat == DEAD)
			continue
		if(potential_target.blood_volume <= 0)
			continue
		var/found_distance = get_dist(src,best_target)
		if(best_target && found_distance > best_distance) //If we have a best target and our distance is greater than the existing one, ignore it.
			continue
		best_target = potential_target
		best_distance = found_distance

	return best_target