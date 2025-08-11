//Rifle Magazine
/obj/item/ammo_box/magazine/cacoil
	name = "coilgun driver magazine (5.7mm)"
	desc = "Contains specialised casing that house a smaller dart. Do not leave near Teshari."
	ammo_type = /obj/item/ammo_casing/cacoil
	caliber = CALIBER_COIL
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "pcr"
	max_ammo = 20
	multitype = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL
	ammo_band_icon = "+pcr_ammo_band"
	ammo_band_color = null

/obj/item/ammo_box/magazine/caflechette
	name = "flechette penetrator box"
	ammo_type = /obj/item/ammo_casing/caflechette
	caliber = CALIBER_FLECHETTE
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "cmg_penetrator"
	max_ammo = 25
	multitype = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/caflechette/ripper
	name = "flechette ripper box"
	ammo_type = /obj/item/ammo_casing/caflechette/ripper
	icon_state = "cmg_ripper"

/obj/item/ammo_box/magazine/caflechette/ballpoint
	name = "ballpoint box"
	ammo_type = /obj/item/ammo_casing/caflechette/ballpoint
	icon_state = "cmg_ballpoint"

/obj/item/ammo_box/magazine/caflechette/magnesium
	name = "magnesium rod box"
	ammo_type = /obj/item/ammo_casing/caflechette/magnesium
	icon_state = "cmg_incend"

/obj/item/ammo_casing/cacoil
	name = "coilgun driver (5.7mm)"
	desc = "A Commonwealth Standard coilgun casing. Contains a dart inside the metallic casing"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sl-casing"

	caliber = CALIBER_COIL
	projectile_type = /obj/projectile/bullet/cacoil
	can_be_printed = TRUE

/obj/item/ammo_casing/cacoil/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)


/obj/projectile/bullet/cacoil
	name = "coilgun dart"
	damage = 15
	armour_penetration = 10
	wound_bonus = 15
