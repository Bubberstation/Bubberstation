/obj/item/ammo_box/magazine/beandog
	name = "shotgun magazine (12g beanbag)"
	desc = "A custom drum magazine of shotgun shells, suitable only for the Beandog combat shotgun."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "m12gbb"
	base_icon_state = "m12gbb"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	caliber = CALIBER_SHOTGUN
	max_ammo = 8
	casing_phrasing = "shell"

/obj/item/ammo_box/magazine/beandog/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[CEILING(ammo_count(FALSE)/8, 1)*8]"
