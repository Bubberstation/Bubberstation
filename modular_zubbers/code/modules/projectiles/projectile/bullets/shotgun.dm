/obj/projectile/bullet/pellet/shotgun_cryoshot
	name = "cryoshot pellet"
	damage = 6
	sharpness = NONE
	var/temperature = -50

/obj/projectile/bullet/pellet/shotgun_cryoshot/on_hit(atom/target, blocked = FALSE, pierce_hit = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

/obj/projectile/bullet/shotgun_slug/shotgun_uraniumslug
	name = "depleted uranium slug"
	damage = 25
	armour_penetration = 100 // he he funny round go through armor
	wound_bonus = 10
	projectile_piercing = PASSMOB|PASSVEHICLE
	projectile_phasing = ~(PASSMOB|PASSVEHICLE)
	projectile_flags = MECH_HIT_PASSENGER
	max_pierces = 4
	phasing_ignore_direct_target = TRUE
	dismemberment = 0 //goes through clean.
	bare_wound_bonus = 0

/obj/projectile/bullet/pellet/shotgun_anarchy
	name = "anarchy pellet"
	damage = 4 // 4x10 at point blank
	sharpness = NONE
	ricochets_max = 3
	reflect_range_decrease = 0.5
	ricochet_chance = 100
	ricochet_incidence_leeway = 0

/obj/projectile/bullet/pellet/shotgun_anarchy/check_ricochet(atom/A)
	if(istype(A, /turf/closed))
		return TRUE
	return FALSE

/obj/projectile/bullet/pellet/shotgun_anarchy/check_ricochet_flag(atom/A)
	return TRUE

/obj/projectile/bullet/shotgun/slug/rip
	name = "ripslug"
	weak_against_armour = TRUE // aim for the legs :)
	damage =  30 //x2 because two slugs at once, on par with syndi slugs but with negative AP out the whazoo, and more drop off
	wound_bonus = -15

/obj/projectile/bullet/shotgun_slug/shotgun_thundershot
	name = "thundershot pellet"
	damage = 3
	sharpness = NONE
	hitsound = 'sound/effects/magic/lightningshock.ogg'

/obj/projectile/bullet/shotgun_slug/shotgun_thundershot/on_hit(atom/target, blocked = FALSE, pierce_hit = FALSE)
	..()
	tesla_zap(target, rand(2, 3), 17500, ZAP_MOB_DAMAGE)
	return BULLET_ACT_HIT
