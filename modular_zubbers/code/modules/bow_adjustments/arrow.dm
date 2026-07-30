/datum/embedding/arrow
	embed_chance = 100
	fall_chance = 0
	jostle_chance = 0
	pain_mult = 3
	jostle_pain_mult = 3
	rip_time = 1 SECONDS

/obj/projectile/bullet/arrow
	damage = 20
	weak_against_armour = TRUE
	wound_bonus = CANT_WOUND
	range = 16
	embed_type = /datum/embedding/arrow
	/// If you're an icemoon dweller, or an ashwalker, you gain this on top of being more effective against armor.
	var/tribal_damage_bonus = 20
	/// Does this arrow benefit from being a tribal?
	var/gets_tribal_bonus = TRUE
	/// If TRUE, this arrow will not obtain any benefits from being used by tribals or from a powerful bow.
	var/already_effective = FALSE
	faction_bonus_force = 10 //Bonus force dealt against certain factions
	nemesis_paths = list(
		/mob/living/simple_animal/hostile/asteroid,
		/mob/living/basic/mining,
		/mob/living/basic/wumborian_fugu,
	)

/obj/item/gun/ballistic/bow
	/// If this bow counts as being effectively used, which makes arrows not weak to armor and enables wounding.
	var/effective = FALSE

/obj/item/gun/ballistic/bow/divine
	effective = TRUE

/obj/projectile/bullet/arrow/prehit_pierce(mob/living/target)
	if (already_effective)
		return ..()

	var/mob/living/carbon/human/user = firer
	if(isnull(target))
		return ..()

	var/effective_usage = FALSE

	if(!isnull(fired_from) && istype(fired_from, /obj/item/gun/ballistic/bow))
		var/obj/item/gun/ballistic/bow/bow = fired_from
		if (bow.effective)
			effective_usage = TRUE
	if(gets_tribal_bonus && istype(user?.mind?.assigned_role, /datum/job/ash_walker) || istype(user?.mind?.assigned_role, /datum/job/primitive_catgirl))
		damage += tribal_damage_bonus
		effective_usage = TRUE

	if(effective_usage)
		weak_against_armour = FALSE
		if (wound_bonus <= CANT_WOUND)
			wound_bonus = -10

	return ..()

/obj/projectile/bullet/arrow/poison
	damage = 20

/obj/projectile/bullet/arrow/sticky
	damage = 3 // decrease from 30 - makes it less lethal on initial impact and awful to tear out
	stamina = 30

/obj/projectile/bullet/arrow/holy
	damage = 25 // Increase from 20
	embed_type = /datum/embedding/arrow

/obj/projectile/bullet/arrow/ash
	damage = 20
	armour_penetration = 20 // Buff from 0
	faction_bonus_force = 20 // Nerf from 60
	embed_type = /datum/embedding/arrow

/obj/projectile/bullet/arrow/bone
	damage = 25
	armour_penetration = 30 // Buff from 20
	wound_bonus = CANT_WOUND
	faction_bonus_force = 30 // Nerf from 35
	embed_type = /datum/embedding/arrow

/obj/projectile/bullet/arrow/bronze
	damage = 30
	armour_penetration = 30
	wound_bonus = CANT_WOUND
	faction_bonus_force = 90
	embed_type = /datum/embedding/arrow

/obj/projectile/bullet/arrow/plastic
	already_effective = TRUE
