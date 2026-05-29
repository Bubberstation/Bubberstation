/obj/item/ammo_box/magazine/wt550m9
	name = "\improper WT-550 magazine"

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "wt550 armour-piercing magazine"

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "wt550 incendiary magazine"

/obj/item/ammo_box/magazine/wt550m9/compressed
	name = "compressed wt550 magazine"
	ammo_type = /obj/item/ammo_casing/c46x30mm/compressed
	ammo_band_color = "#00618E"
	max_ammo = 40
/obj/item/ammo_box/magazine/wt550m9/compressed/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count()/2, 4)]"

/obj/item/ammo_box/magazine/wt550m9/compressed/super
	name = "hyper compressed wt550 magazine"
	ammo_band_color = "#072E40"
	max_ammo = 60
/obj/item/ammo_box/magazine/wt550m9/compressed/super/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count()/3, 4)]"
