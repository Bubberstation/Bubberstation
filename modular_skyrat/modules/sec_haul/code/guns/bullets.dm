/*
*	9x25mm Mk.12
*/

/obj/item/ammo_casing/c9mm
	name = "9x25mm Mk.12 bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing."

/obj/item/ammo_casing/c9mm/ap
	name = "9x25mm Mk.12 armor-piercing bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires an armor-piercing projectile."
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/hp
	name = "9x25mm Mk.12 hollow-point bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a hollow-point projectile. Very lethal to unarmored opponents."
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/fire
	name = "9x25mm Mk.12 incendiary bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This incendiary round leaves a trail of fire and ignites its target."
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/security
	name = "9x25mm Mk.12 security casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a law-enfocement grade round, making it less deadly than most, but still lethal enough to do it's job."
	caliber = CALIBER_9MM_SEC
	projectile_type = /obj/projectile/bullet/security

/obj/projectile/bullet/security
	name = "9x25mm Murphy bullet"
	damage = 20
	wound_bonus = -20

/obj/projectile/bullet/c9mm
	damage = 25

/obj/projectile/bullet/c9mm
	damage = 25

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 30

// premium .38 ammo from cargo, weak against armor, lower base damage, but excellent at embedding and causing slice wounds at close range
/obj/projectile/bullet/c38/dumdum
	name = ".38 DumDum bullet"
	damage = 20
	weak_against_armour = TRUE
	ricochets_max = 0
	sharpness = SHARP_EDGED
	wound_bonus = 35
	exposed_wound_bonus = 30
	embed_type = /datum/embedding/dumdum
	wound_falloff_tile = -8
	embed_falloff_tile = -20

/datum/embedding/dumdum
	embed_chance = 90
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS
