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
	wound_bonus = -20
	exposed_wound_bonus = 15

/obj/item/ammo_casing/cacoil/fp

	projectile_type = /obj/projectile/bullet/cacoil/fp

/obj/projectile/bullet/cacoil/fp

	name = "coilgun fragmenting dart"
	damage = 10
	armour_penetration = 0
	wound_bonus = 15
	exposed_wound_bonus = 20
	weak_against_armour = TRUE


/obj/item/ammo_casing/cacoil/match

	projectile_type = /obj/projectile/bullet/cacoil/match

/obj/projectile/bullet/cacoil/match

	name = "coilgun hedge dart"
	damage = 12
	armour_penetration = 10
	wound_bonus = 5
	exposed_wound_bonus = 10
