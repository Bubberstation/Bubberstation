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

/obj/item/ammo_casing/c9mm/rubber
	name = "9x25mm Mk.12 rubber casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This less than lethal round sure hurts to get shot by, but causes little physical harm."
	projectile_type = /obj/projectile/bullet/c9mm/rubber
	harmful = FALSE

/obj/projectile/bullet/c9mm/rubber
	name = "9x25mm rubber bullet"
	icon_state = "pellet"
	damage = 18
	stamina = 32
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 180
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/obj/projectile/bullet/c9mm
	damage = 25

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 30

/obj/projectile/bullet/c38/match/bouncy
	name = ".38 Rubber bullet"
	damage = 15
	stamina = 35
	weak_against_armour = TRUE
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_data = null

// premium .38 ammo from cargo, weak against armor, lower base damage, but excellent at embedding and causing slice wounds at close range
/obj/projectile/bullet/c38/dumdum
	name = ".38 DumDum bullet"
	damage = 20
	weak_against_armour = TRUE
	ricochets_max = 0
	sharpness = SHARP_EDGED
	wound_bonus = 35
	bare_wound_bonus = 30
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
