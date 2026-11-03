//9mm Magazines
/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9x25mm)"
	multiple_sprites = AMMO_BOX_PER_BULLET
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/magazine.dmi'

/obj/item/ammo_box/magazine/m9mm
	custom_premium_price = 50

//Extended 9mm
/obj/item/ammo_box/magazine/m9mm/stendo
	name = "pistol magazine (9x25mm)"
	ammo_type = /obj/item/ammo_casing/c9mm
	base_icon_state = "g18"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	max_ammo = 33

/obj/item/ammo_box/magazine/m9mm/stendo/fire
	name = "pistol magazine (9x25mm Incendiary)"
	ammo_type = /obj/item/ammo_casing/c9mm/fire
	base_icon_state = "g18_r"

/obj/item/ammo_box/magazine/m9mm/stendo/hp
	name = "pistol magazine (9x25mm Hollow Point)"
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	base_icon_state = "g18_hp"

/obj/item/ammo_box/magazine/m9mm/stendo/ap
	name = "pistol magazine (9x25mm Armour Piercing)"
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	base_icon_state = "g18_ihdf"

//Shotgun Internal Tube

/obj/item/ammo_box/magazine/internal/shot/extended
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/shot/somewhatextended
	name = "combat shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/shot/less_lethal
	name = "less-lethal shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/shot/less_lethal/is_compatible_round(obj/item/ammo_casing/new_round)
	var/static/list/allowed_rounds = list(
		/obj/item/ammo_casing/shotgun/antitide,
		/obj/item/ammo_casing/shotgun/beanbag,
		/obj/item/ammo_casing/shotgun/beehive,
		/obj/item/ammo_casing/shotgun/breacher,
		/obj/item/ammo_casing/shotgun/frangible,
		/obj/item/ammo_casing/shotgun/honkshot,
		/obj/item/ammo_casing/shotgun/hunter,
		/obj/item/ammo_casing/shotgun/incapacitate,
		/obj/item/ammo_casing/shotgun/rubbershot,
		/obj/item/ammo_casing/shotgun/stunslug,
	)
	return (new_round?.type in allowed_rounds)

//10mm Stuff
