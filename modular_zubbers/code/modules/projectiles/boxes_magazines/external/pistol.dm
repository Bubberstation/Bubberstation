/obj/item/ammo_box/magazine/security
	name = "pistol magazine (9mm Murphy)"
	desc = "A 9mm handgun magazine, suitable for the Service Pistol."
	ammo_type = /obj/item/ammo_casing/security
	max_ammo = 10
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	ammo_band_icon = "+9x19ab"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE
	var/murphy_eject_sound = 'sound/items/weapons/throwhard.ogg'
	var/was_ejected = 0

/obj/item/ammo_box/magazine/security/rocket
	name = "pistol magazine (9mm Murphy Rocket Eject)"
	desc = "A 9mm handgun magazine, suitable for the Service Pistol."
	ammo_type = /obj/item/ammo_casing/security
	max_ammo = 8
	ammo_band_color = "#ff9900"
	murphy_eject_sound = 'sound/items/weapons/gun/general/rocket_launch.ogg'

/obj/item/ammo_box/magazine/security/rocket/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(QDELETED(src))
		return
	if(was_ejected)
		playsound(get_turf(src.loc), 'sound/effects/explosion/explosion1.ogg', 40, 1)
		visible_message(span_warning("[src] crumbles into scrap from the force of the impact"))
		if(isliving(hit_atom))
			var/mob/living/hit_mob = hit_atom
			hit_mob.Knockdown(2 SECONDS)
			hit_mob.apply_damage(40, BRUTE, BODY_ZONE_CHEST)
		qdel(src)
