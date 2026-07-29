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

//10mm Stuff
