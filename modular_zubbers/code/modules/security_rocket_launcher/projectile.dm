//The projectile itself
/obj/projectile/bullet/security_missile
	name = "active radar HE rocket"
	desc = "If you can read this, you're too close."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket_launched"

	damage = 13 //Bonk. Same as a toolbox.
	sharpness = NONE
	embed_type = null
	shrapnel_type = null
	ricochets_max = 0
	speed = 0.35
	//Note that range measurements are not measured in turfs, but rather ticks.
	range = 100
	can_hit_turfs = FALSE

	var/explosion_damage = 50 //A light explosion is 30.
	var/ignition_speed = 1 //Speed is set to this value after meeting minimium range.
	var/minimum_range = 2
	var/cached_range = 0 //Cheaper than calling initial(range) constantly.


/obj/projectile/bullet/security_missile/Initialize(mapload)
	. = ..()
	cached_range = range
	original = null //Sets the original target to null since we don't need that.

/obj/projectile/bullet/security_missile/reduce_range()
	. = ..()
	if(speed != ignition_speed)
		if(speed > 0.1)
			speed = max(0.1, speed-0.01)
		if(range <= (cached_range - minimum_range))
			speed = ignition_speed
			icon_state = "rocket_ignition"
			playsound(src, 'modular_zubbers/sound/weapons/gun/sec_missile/launch.ogg', 50, FALSE, -1)
			if(istype(fired_from, /obj/item/gun/ballistic/rocketlauncher/security))
				var/obj/item/gun/ballistic/rocketlauncher/security/missile_launcher = fired_from
				if(missile_launcher.self_targeting)
					set_homing_target(fired_from)
				else
					initialize_radar()
					process_radar()

			do_sparks(2, FALSE, src)

/obj/projectile/bullet/security_missile/on_hit(atom/target, blocked = 0, pierce_hit)

	var/turf/our_turf = get_turf(src) //get our current turf before the below code is called.

	. = ..()

	if(. == BULLET_ACT_FORCE_PIERCE)
		return .

	if(!our_turf)
		return BULLET_ACT_BLOCK //Some fuckery afoot.

	if(speed < ignition_speed) //We're not fast enough to explode.
		new /obj/item/broken_missile/security(our_turf)
		if(isliving(target))
			var/mob/living/target_as_living = target

			if(. != BULLET_ACT_BLOCK && blocked < 15 && target_as_living.Stun(1.5 SECONDS)) //If it was a hit, you have less than 15 armor on that spot, and the stun went through...
				playsound(target, 'modular_zubbers/code/modules/emotes/sound/effects/bonk.ogg', 50, FALSE, -1) //Bonk!
				return .

			if(isliving(firer) && prob(5))
				var/mob/living/firer_as_living = firer
				firer_as_living.say("A DUD!!", forced = "rocket dud")

		playsound(target, 'sound/items/weapons/smash.ogg', 50, TRUE, -1)

		return . //Will still do damage (if not blocked), but it won't explode like below.

	fake_explode(src, explosion_damage, src)

	return .


/obj/projectile/bullet/security_missile/proc/initialize_radar()
	addtimer(CALLBACK(src, PROC_REF(process_radar)), 0.25 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)

/obj/projectile/bullet/security_missile/proc/process_radar()

	//This is probably a little expensive to run, so it should be called every second or so at most.
	//I sure hope an admin doesn't give the crew like 60 of these. That would be a diaster. Haha. Ha.

	if(!isnum(angle)) //Our current angle. can be null
		return

	var/scanning_angle = homing_target ? (range/cached_range) * 45 : 45 //Field of view decreases as time goes on.

	if(scanning_angle <= 0)
		return

	//Gets all the turfs that it can see.
	var/list/possible_turfs = circle_view_turfs(src, 7) - loc

	var/list/turf_to_weight = list()

	for(var/turf/found_turf as null|anything in possible_turfs)

		if(!found_turf)
			continue

		//Check the angle of incidence and filter it out to stuff in front of it.
		var/found_angle_difference = 0
		if(found_turf != loc)
			var/turf_angle = get_angle(src, found_turf)
			found_angle_difference = abs(closer_angle_difference(turf_angle, angle))
			if(found_angle_difference > scanning_angle)
				continue

		var/calculated_weight = 0
		if(found_turf.density && (found_turf.turf_flags & IS_SOLID)) //A wall or floor.
			var/heat_capacity_compare = /turf/open/misc::heat_capacity //Compare it to a regular floor.
			if(found_turf.heat_capacity == INFINITY)
				calculated_weight = /turf/closed/wall/r_wall::heat_capacity / heat_capacity_compare
			else
				calculated_weight = (found_turf.heat_capacity / heat_capacity_compare)
		else //A floor.
			//Check the contents of the turf. Will add to the calculated weight.
			var/scan_limit = 30 //Prevents shinegeansans.
			for(var/atom/movable/found_movable as null|anything in found_turf.contents)
				scan_limit--
				if(scan_limit <= 0)
					break
				if(found_movable.invisibility > INVISIBILITY_REVENANT) //No radar signature.
					continue
				if(found_movable.uses_integrity)
					calculated_weight += found_movable.max_integrity/HUMAN_MAXHEALTH
					continue
				if(isliving(found_movable))
					var/mob/living/found_living = found_movable
					calculated_weight += clamp(found_living.maxHealth/HUMAN_MAXHEALTH,1,4)*2 //4 times human health is roughly the same as a space dragon.
					continue

		if(calculated_weight > 0)
			calculated_weight *= 100 //Increases precision for the below calculations.
			calculated_weight /= (1 + max(1, get_dist(src, found_turf))/5) //Half weight at 5 tiles distance, however with a minimum value of 1 for distance Remember, max means get largest.
			calculated_weight /= (1 + found_angle_difference/45) //Half weight at 45 degrees difference.
			calculated_weight = FLOOR(calculated_weight, 1)
			if(calculated_weight > 0) //The calculation above can set this to 0.
				turf_to_weight[found_turf] = calculated_weight

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
	can_hit_turfs = TRUE

	return TRUE
