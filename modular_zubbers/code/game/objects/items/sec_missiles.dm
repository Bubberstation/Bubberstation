/obj/item/gun/ballistic/rocketlauncher/security
	name = "\improper \"VARS\" Variable Active Radar Missile System"
	desc = "A (relatively) cheap, reusable missile launcher cooked up by the crackpots in the Nanotrasen weapons development labs meant to deal with those pesky space tiders. \
	Uses special patented 69mm \"fire and fuhgeddaboudit\" missiles that home in on targets with large radar signatures, including walls, floors, and most importantly, people."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	worn_icon_state = "rocketlauncher"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/security_rocketlauncher
	fire_sound = 'modular_zubbers/sound/weapons/sec_missile.ogg'
	cartridge_wording = "missile"
	pin = /obj/item/firing_pin
	backblast = FALSE

//Internal Magazine
/obj/item/ammo_box/magazine/internal/security_rocketlauncher
	name = "missile launcher internal magazine"
	ammo_type = /obj/item/ammo_casing/security_missile
	caliber = CALIBER_69MM
	max_ammo = 1

//The ammo casing
/obj/item/ammo_casing/security_missile
	name = "\improper \"VARS\" HE rocket"
	desc = "An 69mm High Explosive missile with built-in radar technology. Fire at people and forget, because it's honestly best to forget what happened if you accidentally hit a stray assistant with these."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket"
	base_icon_state = "rocket"

	caliber = CALIBER_69MM
	projectile_type = /obj/projectile/bullet/security_missile
	newtonian_force = 2

/obj/item/ammo_casing/security_missile/Initialize(...)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/security_missile/update_icon_state()
	. = ..()
	icon_state = base_icon_state

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
	speed = 1
	range = 100

/obj/projectile/bullet/security_missile/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	explosion(target, devastation_range = -1, light_impact_range = 2, explosion_cause = src)
	return BULLET_ACT_HIT

/obj/projectile/bullet/security_missile/Initialize(...)

	. = ..()
	original = null
	addtimer(CALLBACK(src, PROC_REF(process_radar)), 1 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)


/obj/projectile/bullet/security_missile/proc/process_radar()

	//This is probably a little expensive to run, so it should be called every second or so at most.
	//I sure hope an admin doesn't give the crew like 60 of these. That would be a diaster. Haha. Ha.

	if(!isnum(angle)) //can be null
		return

	var/scanning_angle = homing_target ? 25 : 45

	//Gets all the turfs that it can see, in its FOV, based on the current projectile's angle.
	var/turf/list/possible_turfs = slice_off_turfs(
		src,
		circle_view_turfs(src,6), //6x6 = 36. Ends up checking (in reality) at most 25% of that, which is about 9 turfs.
		angle - scanning_angle,
		angle + scanning_angle
	)

	var/list/turf_to_weight = list()
	for(var/turf/found_turf as null|anything in possible_turfs)
		if(!found_turf)
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
				calculated_weight += found_living.maxHealth
				continue

		if(calculated_weight > 0)
			turf_to_weight[found_turf] = calculated_weight / max(1,get_dist(src,found_turf))

	if(!length(turf_to_weight))
		return

	set_homing_target(pick_weight(turf_to_weight))

	return TRUE





