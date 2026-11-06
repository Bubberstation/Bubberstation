/obj/projectile/bullet/pellet/shotgun_improvised
	damage = 5
	wound_bonus = -5
	demolition_mod = 3

/obj/projectile/bullet/pellet/shotgun_improvised/Initialize(mapload)
	. = ..()
	range = rand(3, 8)

/obj/projectile/bullet/pellet/shotgun_improvised/on_range()
	do_sparks(1, TRUE, src)
	return ..()
