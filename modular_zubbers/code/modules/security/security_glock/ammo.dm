/obj/projectile/bullet/c9mm/flathead
	name = "9x25mm flathead bullet"

	damage = 24
	stamina = 5 //Knocks the wind out of you.

	wound_bonus = CANT_WOUND
	exposed_wound_bonus = CANT_WOUND

	weak_against_armour = TRUE
	sharpness = NONE
	shrapnel_type = null
	embed_type = null


/obj/item/ammo_casing/c9mm/flathead
	name = "9x25mm Mk.12 flathead bullet casing"
	desc = "A modern 9x25mm Mk.12 flathead bullet casing."
	projectile_type = /obj/projectile/bullet/c9mm/flathead


/obj/item/ammo_box/magazine/m9mm/flathead //m9mm is not a typo
	name = "pistol magazine (9x25mm flathead)"
	desc = "A gun magazine. Loaded with lethal rounds with flathead tips."
	ammo_type = /obj/item/ammo_casing/c9mm/flathead

/obj/item/ammo_box/magazine/m9mm/rubber //m9mm is not a typo
	name = "pistol magazine (9x25mm rubber)"
	desc = "A gun magazine. Loaded with less-than-lethal rounds with rubber tips."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber


/obj/item/ammo_box/c9mm/flathead
	name = "9x25mm flathead box"
	ammo_type = /obj/item/ammo_casing/c9mm/flathead
