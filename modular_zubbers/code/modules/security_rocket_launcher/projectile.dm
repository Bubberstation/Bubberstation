//The projectile itself
/obj/projectile/bullet/security_missile
	name = "active radar HE rocket"
	desc = "If you can read this, you're too close."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket_launched"

	damage = 25 //Bonk
	sharpness = NONE
	embed_type = null
	shrapnel_type = null
	ricochets_max = 0
	speed = 0.5
	var/ignition_speed = 2 //Speed is set to this value after meeting minimium range.
	//Note that range measurements are not measured in turfs, but rather ticks.
	range = 100
	var/minimum_range = 5

	var/cached_range = 0 //Cheaper than calling initial(range) constantly.

/obj/projectile/bullet/security_missile/Initialize(mapload)
	. = ..()
	cached_range = range
	original = null //Sets the original target to null since we don't need that.

/obj/projectile/bullet/security_missile/reduce_range()
	. = ..()
	if(speed != ignition_speed)
		if(speed > 0.1)
			speed = max(0.1,speed-0.01)
		if(range <= (cached_range - minimum_range))
			speed = ignition_speed
			icon_state = "rocket_ignition"
			if(istype(fired_from,/obj/item/gun/ballistic/rocketlauncher/security))
				var/obj/item/gun/ballistic/rocketlauncher/security/missile_launcher = fired_from
				if(missile_launcher.self_targeting)
					set_homing_target(fired_from)
				else
					initialize_radar()
					process_radar()

			do_sparks(2, FALSE, src)

/obj/projectile/bullet/security_missile/on_hit(atom/target, blocked = 0, pierce_hit)

	..()

	if(range >= cached_range - minimum_range)
		var/turf/found_turf = get_turf(src)
		if(found_turf)
			new /obj/item/broken_missile/security(found_turf)
			if(isliving(firer) && prob(5))
				var/mob/living/mercenary = firer
				mercenary.say("A DUD!!", forced = "rocket dud")
		return BULLET_ACT_BLOCK

	explosion(target, devastation_range = -1, light_impact_range = 2, explosion_cause = src)
	return BULLET_ACT_HIT

/obj/projectile/bullet/security_missile/proc/initialize_radar()
	addtimer(CALLBACK(src, PROC_REF(process_radar)), 1 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)

/obj/projectile/bullet/security_missile/proc/process_radar()

	//This is probably a little expensive to run, so it should be called every second or so at most.
	//I sure hope an admin doesn't give the crew like 60 of these. That would be a diaster. Haha. Ha.

	if(!isnum(angle)) //Our current angle. can be null
		return

	var/scanning_angle = homing_target ? (range/cached_range)*45 : 45 //Field of view decreases as time goes on.

	if(scanning_angle <= 0)
		return

	//Gets all the turfs that it can see.
	var/list/possible_turfs = circle_view_turfs(src,6)

	var/list/turf_to_weight = list()

	var/debug_color = pick("#FF0000","#00FF00","#0000FF")

	for(var/turf/found_turf as null|anything in possible_turfs)

		if(!found_turf)
			continue

		//Check the angle of incidence and filter it out to stuff in front of it.
		var/found_angle_difference = 0
		if(found_turf != src.loc)
			var/turf_angle = get_angle(src,found_turf)
			found_angle_difference = abs( closer_angle_difference(turf_angle,angle) )
			if(found_angle_difference > scanning_angle)
				continue

		//This is where the fun begins.
		var/calculated_weight = 0

		//Check the turf itself.
		if(found_turf.turf_flags & IS_SOLID)
			if(isopenturf(found_turf)) //Floors, chasms, space, etc
				if(!isspaceturf(found_turf)) //Not space!
					calculated_weight = (found_turf.uses_integrity ? found_turf.max_integrity : 100)*0.25
			else if(isclosedturf(found_turf))
				calculated_weight = found_turf.uses_integrity ? found_turf.max_integrity : 100
				continue //No point in checking contents!

		found_turf.color = debug_color

		//Check the contents of the turf. Will add to the calculated weight.
		var/scan_limit = 30 //Prevents shinegeansans.
		for(var/atom/movable/found_movable as null|anything in found_turf.contents)
			scan_limit--
			if(scan_limit <= 0)
				break
			if(found_movable.invisibility > INVISIBILITY_REVENANT) //No radar signature.
				continue
			if(found_movable.uses_integrity)
				calculated_weight += found_movable.max_integrity
				continue
			if(isliving(found_movable))
				var/mob/living/found_living = found_movable
				calculated_weight += min(found_living.maxHealth,400) //400 is the health of a space dragon.
				continue

		if(calculated_weight > 0)
			calculated_weight /= (1 + get_dist(src,found_turf)/3) //Half weight at 3 tiles distance.
			calculated_weight /= (1 + found_angle_difference/90) //Half weight at 90 degrees difference.
			turf_to_weight[found_turf] = CEILING(calculated_weight,1)

	if(!length(turf_to_weight))
		//Reset homing. Using set_homing_target(null) does not work.
		homing = FALSE
		homing_target = null
		homing_offset_x = 0
		homing_offset_y = 0
		return


	var/turf/targeting_turf = pick_weight(turf_to_weight)
	set_homing_target(targeting_turf)
	original = targeting_turf

	return TRUE





