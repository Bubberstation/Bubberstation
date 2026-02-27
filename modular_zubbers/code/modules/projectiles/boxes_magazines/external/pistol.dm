/obj/item/ammo_box/magazine/security
	name = "pistol magazine (9mm Murphy)"
	desc = "A 9mm handgun magazine, suitable for the Nanotrasen Service Pistol. It comes with a more robust spring than the average magazine and weight to boot."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/magazine.dmi'
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/security
	caliber = CALIBER_9MM_SEC
	max_ammo = 10
	ammo_band_color = null
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE
	var/murphy_eject_sound = 'sound/items/weapons/throwhard.ogg'
	var/was_ejected = 0

/obj/item/ammo_box/magazine/security/rocket
	name = "pistol magazine (9mm Murphy Rocket Eject)"
	desc = parent_type::desc + "With a small charge inside that sparks on ejection, this one has less room for ammo and a lethal velocity to it's ejections."
	ammo_type = /obj/item/ammo_casing/security
	max_ammo = 8
	base_icon_state = "9x19pI"
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

/obj/item/ammo_box/magazine/recharge/ntusp
	name = "small disabling power pack"
	desc = "A small, rechargeable power pack for the NT-USP. Synthesizes up to twelve .22HL bullets that tire targets."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	base_icon_state = "powerpack_small"
	icon_state = "powerpack_small-12"
	ammo_type = /obj/item/ammo_casing/caseless/c22hl
	max_ammo = 12

/obj/item/ammo_box/magazine/recharge/ntusp/laser
	name = "small lethal power pack"
	desc = "A small, rechargeable power pack for the NT-USP that has been modified. Synthesizes up to eight .22LS bullets that fire lasers."
	ammo_type = /obj/item/ammo_casing/caseless/c22ls
	base_icon_state = "powerpack_small-l"
	icon_state = "powerpack_small-l-8"
	max_ammo = 8

/obj/item/ammo_box/magazine/recharge/ntusp/laser/empty
	start_empty = TRUE // so you cant field convert mags to full laser ones

/obj/item/ammo_box/magazine/recharge/ntusp/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/recharge/ntusp/emp_act(severity) //shooting physical bullets wont stop you dying to an EMP
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		var/bullet_count = ammo_count()
		var/bullets_to_remove = round(bullet_count / severity)
		for(var/i = 0; i < bullets_to_remove; i++)
			qdel(get_round())
		update_icon()
