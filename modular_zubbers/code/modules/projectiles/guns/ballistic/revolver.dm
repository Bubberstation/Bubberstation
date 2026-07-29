//Niim Pocket Reolver - Fires Murphy ammo
/obj/item/gun/ballistic/revolver/protector_revolver
	name = "\improper 'Protector' Revolver"
	desc = "The Protector was designed to be a compact backup gun for NT law enforcement. Features a built in light and carefully polished action to ensure functionality no matter the environment, chambered in the same NT issue 9mm Murphy to maintain ammo compatibility. 'Murphy' magazines can be notched onto the cylinder for easy reloading."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimpocketrevolver_sec"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/sec9mm
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 40
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_SMALL
	force = 9.5 //slightly worse than murphy/batong

/obj/item/gun/ballistic/revolver/protector_revolver/add_seclight_point()
	// The revolver's light comes attached but is unremovable.
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		light_overlay_icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi', \
		light_overlay = "niimpocketrevolver_light")


/obj/item/gun/ballistic/revolver/defender_revolver
	name = "\improper 'Defender' revolver"
	desc = "The Defender is a cheap, subpar Martian made knockoff of the Protector series, albeit street lore is that both came out of the same factories. Fires .38 rounds. The poor quality of the machining slightly reduces the round's power and accuracy."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimpocketrevolver_civvie"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/defender38
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 50
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_SMALL
	projectile_damage_multiplier = 0.8
	spread = 10
	force = 9.5 //slightly worse than murphy/batong
