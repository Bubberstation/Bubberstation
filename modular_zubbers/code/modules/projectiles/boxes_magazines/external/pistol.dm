/obj/item/ammo_box/magazine/m9mm/security
	name = "pistol magazine (9mm Security)"
	desc = "A 9mm handgun magazine, suitable for the Service Pistol."
	ammo_type = /obj/item/ammo_casing/c9mm/security
	max_ammo = 10
	ammo_band_color = "#971313"
	var/murphy_eject_sound = 'sound/items/weapons/throwhard.ogg'
	var/was_ejected = 0

/obj/item/ammo_box/magazine/m9mm/security/rocket
	name = "pistol magazine (9mm Rocket Eject)"
	desc = "A 9mm handgun magazine, suitable for the Service Pistol."
	ammo_type = /obj/item/ammo_casing/c9mm/security
	max_ammo = 8
	ammo_band_color = "#ff9900"
	murphy_eject_sound = 'sound/items/weapons/gun/general/rocket_launch.ogg'

/obj/item/ammo_box/magazine/m9mm/security/rocket/throw_impact(mob/living/hit_mob, datum/thrownthing/throwingdatum)
	. = ..()
	if(!QDELETED(hit_mob) && was_ejected )
		hit_mob.Knockdown(2 SECONDS)
		hit_mob.apply_damage(40, BRUTE, BODY_ZONE_CHEST)
		playsound(get_turf(src.loc), 'sound/effects/explosion/explosion1.ogg', 40, 1)
		qdel(src)

