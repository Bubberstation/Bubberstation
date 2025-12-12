/**
 * Bullsquid (/mob/living/basic/blackmesa/xen/bullsquid)
 * An aggressive alien creature from Xen that uses both melee and ranged attacks.
 *
 * A hostile mob that switches between biting nearby targets and spitting acid at distant ones.
 * Uses standard melee attacks when adjacent and acid spit when at range.
 * Each bullsquid is hostile to other bullsquids, creating organic free-for-all combat.
 */
/mob/living/basic/blackmesa/xen/bullsquid
	name = "bullsquid"
	desc = "Some highly aggressive alien creature. Thrives in toxic environments."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "bullsquid"
	icon_living = "bullsquid"
	icon_dead = "bullsquid_dead"

	// Health and combat
	maxHealth = 110
	health = 110
	melee_damage_lower = 15
	melee_damage_upper = 18
	obj_damage = 50
	combat_mode = TRUE
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/attack1.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 1, OXY = 1)

	// Mob traits
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	basic_mob_flags = FLAMMABLE_MOB
	unsuitable_cold_damage = 15
	unsuitable_heat_damage = 15
	speak_emote = list("growls")

	// AI and behavior
	ai_controller = /datum/ai_controller/basic_controller/bullsquid
	gold_core_spawnable = HOSTILE_SPAWN

	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/detect1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/detect2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/detect3.ogg'
	)

/mob/living/basic/blackmesa/xen/bullsquid/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_listen_to_weather)
	// Add ranged attack component with proper targeting
	AddComponent(/datum/component/ranged_attacks, projectile_type = /obj/projectile/bullsquid, projectile_sound = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/goo_attack3.ogg', cooldown_time = 3 SECONDS)

/obj/item/ammo_casing/bullsquid
	name = "nasty ball of ooze"
	projectile_type = /obj/projectile/bullsquid

/obj/projectile/bullsquid
	name = "nasty ball of ooze"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = BURN
	knockdown = 20
	armor_flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin
	hitsound = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/splat1.ogg'
	hitsound_wall = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/splat1.ogg'
	pass_flags = PASSTABLE
	speed = 0.8

/// Creates toxic residue where the projectile hits
/obj/projectile/bullsquid/on_hit(atom/target, blocked = 0, pierce_hit)
	new /obj/effect/decal/cleanable/greenglow(target.loc)
	return ..()
