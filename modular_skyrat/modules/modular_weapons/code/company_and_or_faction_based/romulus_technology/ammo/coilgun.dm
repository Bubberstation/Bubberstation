/obj/item/ammo_casing/cacoil
	name = "coilgun driver (5.7mm)"
	desc = "A Commonwealth Standard coilgun casing. Contains a dart inside the metallic casing"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sl-casing"

	caliber = CALIBER_COIL
	projectile_type = /obj/projectile/bullet/cacoil
	can_be_printed = TRUE

/obj/projectile/bullet/cacoil
	name = "coilgun dart"
	damage = 15
	armour_penetration = 15
	wound_bonus = -10
	exposed_wound_bonus = 10
