/obj/item/gun/ballistic/revolver/ocelot
	name = "Colt Peacemaker revolver"
	desc = "A modified Peacemaker revolver that chambers .357 ammo. Less powerful than the regular .357, but ricochets a lot more." // We need tension...conflict. The world today has become too soft. We're living in an age where true feelings are suppressed. So we're going to shake things up a bit. We'll create a world dripping with tension... ...a world filled with greed and suspicion, bravery and cowardice.
	icon_state = "c38_panther"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder

/obj/item/ammo_casing/a357/peacemaker
	name = ".357 Peacemaker bullet casing"
	desc = "A .357 Peacemaker bullet casing."
	caliber = CALIBER_357
	projectile_type = /obj/projectile/bullet/a357/peacemaker

/obj/projectile/bullet/a357/peacemaker
	name = ".357 Peacemaker bullet"
	damage = 25
	wound_bonus = 0
	ricochets_max = 6
	ricochet_chance = 200
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/datum/design/a357/peacemaker
	name = ".357 Peacemaker speed loader"
	id = "a357PM"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/a357/peacemaker
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED)

/obj/item/ammo_box/a357/peacemaker
	name = "speed loader (.357 Peacemaker)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357/peacemaker
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
