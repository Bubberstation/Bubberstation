//Rifle Magazine
/obj/item/ammo_box/magazine/cacoil
	name = "coilgun driver magazine (5.7mm)"
	desc = "Contains ferro-magnetic projectile. Do not leave near Teshari."
	ammo_type = /obj/item/ammo_casing/cacoil
	caliber = CALIBER_COIL
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "pcr"
	max_ammo = 15
	multitype = TRUE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL
	ammo_band_icon = "+pcr_ammo_band"
	ammo_band_color = null

/obj/item/ammo_box/magazine/cacoil/match
	name = "coilgun magazine (5.7mm Match)"
	desc = parent_type::desc + " These specialised driver have a more rounded edge, intended for bouncing on impact."
	ammo_type = /obj/item/ammo_casing/cacoil/match


/obj/item/ammo_casing/cacoil
	name = "coilgun driver (5.7mm)"
	desc = "A Commonwealth Standard coilgun casing. Contains a dart inside the metallic casing"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sl-casing"

	caliber = CALIBER_COIL
	projectile_type = /obj/projectile/bullet/cacoil

/obj/item/ammo_casing/cacoil/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/bullet/cacoil
	name = "coilgun dart"
	damage = 15
	armour_penetration = 10
	wound_bonus = 15


