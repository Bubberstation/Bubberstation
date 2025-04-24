/obj/projectile/bullet/pellet/shotgun_cryoshot
	name = "cryoshot pellet"
	damage = 6
	sharpness = NONE
	var/temperature = -50

/obj/projectile/bullet/pellet/shotgun_cryoshot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

/obj/projectile/bullet/shotgun_slug/shotgun_uraniumslug
	name = "depleted uranium slug"
	damage = 25
	armour_penetration = 200 // he he funny round go through armor
	wound_bonus = -30

/obj/projectile/bullet/shotgun_slug/shotgun_uraniumslug/on_hit(atom/target)
	. = ..()
	if(ismob(target))
		return BULLET_ACT_FORCE_PIERCE


/obj/projectile/bullet/pellet/shotgun_anarchy
	name = "anarchy pellet"
	damage = 4 // 4x10 at point blank
	sharpness = NONE
	ricochets_max = 3
	reflect_range_decrease = 5
	ricochet_chance = 100

/obj/projectile/bullet/pellet/shotgun_anarchy/check_ricochet(atom/A)
	if(istype(A, /turf/closed))
		return TRUE
	return FALSE

/obj/projectile/bullet/pellet/shotgun_anarchy/check_ricochet_flag(atom/A)
	return TRUE

/obj/projectile/bullet/shotgun/slug/rip
	name = "ripslug"
	armour_penetration = -50 // aim for the legs :)
	damage =  30 //x2 because two slugs at once, on par with syndi slugs but with negative AP out the whazoo, and more drop off
	wound_bonus = -10

/obj/projectile/bullet/shotgun_slug/shotgun_thundershot
	name = "thundershot pellet"
	damage = 3
	sharpness = NONE
	hitsound = 'sound/effects/magic/lightningshock.ogg'

/obj/projectile/bullet/shotgun_slug/shotgun_thundershot/on_hit(atom/target)
	..()
	tesla_zap(target, rand(2, 3), 17500, ZAP_MOB_DAMAGE)
	return BULLET_ACT_HIT

