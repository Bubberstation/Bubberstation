/obj/projectile/bullet/arrow
	damage = 20
	armour_penetration = 0
	weak_against_armour = TRUE
	wound_bonus = CANT_WOUND
	bare_wound_bonus = 0
	range = 16
	dismemberment = 0
	catastropic_dismemberment = 0
	embedding = list(
		embed_chance = 100,
		fall_chance = 0,
		jostle_chance = 0,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 1,
		jostle_pain_mult = 1,
		rip_time = 1 SECONDS
	)
	sharpness = SHARP_POINTY
	var/tribal_damage_bonus = 20 //If you're an icemoon dweller, or an ashwalker.
	faction_bonus_force = 10 //Bonus force dealt against certain factions
	nemesis_paths = list(
		/mob/living/simple_animal/hostile/asteroid,
		/mob/living/basic/mining,
		/mob/living/basic/wumborian_fugu,
	)

/obj/projectile/bullet/arrow/prehit_pierce(mob/living/target, mob/living/carbon/human/user)

	if(isnull(target))
		return ..()

	if(user?.mind?.special_role == ROLE_LAVALAND)
		damage += tribal_damage_bonus
		weak_against_armour = FALSE

	return ..()

/obj/projectile/bullet/arrow/holy
	damage = 20
	armour_penetration = 0
	weak_against_armour = TRUE
	wound_bonus = CANT_WOUND
	bare_wound_bonus = 0
	faction_bonus_force = 10
	embedding = list(
		embed_chance = 100,
		fall_chance = 0,
		jostle_chance = 0,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 1,
		jostle_pain_mult = 1,
		rip_time = 1 SECONDS
	)

/obj/projectile/bullet/arrow/ash
	damage = 20
	armour_penetration = 20
	weak_against_armour = TRUE
	wound_bonus = CANT_WOUND
	bare_wound_bonus = 0
	faction_bonus_force = 20
	embedding = list(
		embed_chance = 100,
		fall_chance = 0,
		jostle_chance = 0,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 1,
		jostle_pain_mult = 1,
		rip_time = 1 SECONDS
	)

/obj/projectile/bullet/arrow/bone
	damage = 25
	armour_penetration = 30
	weak_against_armour = TRUE
	wound_bonus = CANT_WOUND
	bare_wound_bonus = 0
	faction_bonus_force = 30
	embedding = list(
		embed_chance = 100,
		fall_chance = 0,
		jostle_chance = 0,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 1,
		jostle_pain_mult = 1,
		rip_time = 1 SECONDS
	)

/obj/projectile/bullet/arrow/bronze
	damage = 30
	armour_penetration = 30
	weak_against_armour = FALSE
	wound_bonus = CANT_WOUND
	bare_wound_bonus = 0
	faction_bonus_force = 90
	embedding = list(
		embed_chance = 100,
		fall_chance = 0,
		jostle_chance = 0,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 1,
		jostle_pain_mult = 1,
		rip_time = 1 SECONDS
	)