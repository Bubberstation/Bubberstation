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
	pellets = 5
	variance = 9
	projectile_type = /obj/projectile/bullet/cacoil/fp

/obj/projectile/bullet/cacoil/fp

	name = "coilgun fragmenting dart"
	damage = 2
	armour_penetration = 0
	wound_bonus = 15
	exposed_wound_bonus = 15
	weak_against_armour = TRUE
	embed_type = /datum/embedding/fp

/datum/embedding/fp
	embed_chance = 25
	pain_chance = 35
	fall_chance = 25
	jostle_chance = 10
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.5
	pain_mult = 1
	rip_time = 1 SECONDS

/obj/item/ammo_casing/cacoil/fp/hornet
	pellets = 8
	variance = 16
	projectile_type = /obj/projectile/bullet/cacoil/fp/hornet

/obj/projectile/bullet/cacoil/fp/hornet

	name = "coilgun hornet dart"
	damage = 2
	armour_penetration = 10
	wound_bonus = 0
	exposed_wound_bonus = 15
	stamina = 5 // 5*8 for 40 stamina is quite okay, it's only slightly more than a disabler

/obj/item/ammo_casing/cacoil/match

	projectile_type = /obj/projectile/bullet/cacoil/match

/obj/projectile/bullet/cacoil/match
	name = "coilgun hedge dart"
	damage = 12
	armour_penetration = 10
	wound_bonus = 5
	exposed_wound_bonus = 10
	ricochet_chance = 100
	ricochets_max = 1
	ricochet_auto_aim_angle = 90
	ricochet_auto_aim_range = 3

