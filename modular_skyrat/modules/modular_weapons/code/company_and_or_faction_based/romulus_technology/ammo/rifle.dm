/obj/item/ammo_casing/caflechette
	name = "flechette steel penetrator"
	desc = "A Romfed standard rifle flechette."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40sol"

	caliber = CALIBER_FLECHETTE
	projectile_type = /obj/projectile/bullet/caflechette
	custom_materials = AMMO_MATS_SHOTGUN_FLECH
	advanced_print_req = TRUE
	can_be_printed = TRUE

/obj/item/ammo_casing/caflechette/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)


/obj/projectile/bullet/caflechette
	name = "flechette penetrator"
	damage = 15
	armour_penetration = 60
	wound_bonus = 10
	exposed_wound_bonus = 10
	embed_type = /datum/embedding/caflechette
	dismemberment = 0

/datum/embedding/caflechette
	embed_chance = 55
	pain_chance = 70
	fall_chance = 30
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 2 SECONDS

/obj/item/ammo_casing/caflechette/ripper
	name = "flechette silicon dart"
	desc = "A Romfed standard rifle flechette."
	projectile_type = /obj/projectile/bullet/caflechette/ripper
	custom_materials = AMMO_MATS_SHOTGUN_FLECH

/obj/projectile/bullet/caflechette/ripper
	name = "flechette dart"
	damage = 10
	wound_bonus = 25
	exposed_wound_bonus = 35
	embed_type = /datum/embedding/ripper
	armour_penetration = 40 //defeat basic armour

/datum/embedding/ripper
	embed_chance = 200
	pain_chance = 70
	fall_chance = 1
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 5 SECONDS

/obj/item/ammo_casing/caflechette/ballpoint
	name = "steel ball"
	desc = "A bullet casing with a large metallic ball as a projectile."
	projectile_type = /obj/projectile/bullet/caflechette/ballpoint
	custom_materials = AMMO_MATS_SHOTGUN_FLECH

/obj/projectile/bullet/caflechette/ballpoint
	name = "high velocity steel ball"
	damage = 10
	wound_bonus = 20
	sharpness = SHARP_EDGED
	wound_bonus = 0
	exposed_wound_bonus = 20
	armour_penetration = 10
	shrapnel_type = /obj/item/shrapnel/stingball
	embed_type = /datum/embedding/ballpoint
	stamina = 20
	ricochet_chance = 50
	ricochets_max = 3
	ricochet_auto_aim_angle = 90
	ricochet_auto_aim_range = 5

/datum/embedding/ballpoint
	embed_chance = 50
	fall_chance = 5
	jostle_chance = 5
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 2
	jostle_pain_mult = 3
	rip_time = 1 SECONDS

/obj/item/ammo_casing/caflechette/magnesium
	name = "magnesium rod"
	projectile_type = /obj/projectile/bullet/caflechette/magnesium
	custom_materials = AMMO_MATS_SHOTGUN_PLASMA

/obj/projectile/bullet/caflechette/magnesium
	name = "high velocity magnesium rod"
	damage = 5
	wound_bonus = 15
	exposed_wound_bonus = 5
	embed_type = /datum/embedding/magnesium
	armour_penetration = 100 //does really low damage

/datum/embedding/magnesium
	embed_chance = 80
	pain_chance = 10
	fall_chance = 10
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 10 SECONDS

/obj/projectile/bullet/caflechette/magnesium/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(12)
		M.ignite_mob()
