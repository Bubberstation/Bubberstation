/**
 * Headcrab Zombies
 * Various types of zombies created by headcrabs latching onto different personnel.
 *
 * Base zombie type with common behaviors and properties.
 * Each variant (scientist, guard, HECU, HEV) has different health values and corpses.
 */
/mob/living/basic/blackmesa/xen/headcrab_zombie
	name = "headcrab zombie"
	desc = "This unlucky person has had a headcrab latch onto their head. Ouch."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "zombie"
	base_icon_state = "zombie"
	icon_dead = "zombie_dead"

	// Health and combat
	maxHealth = 110
	health = 110
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_sound = 'modular_skyrat/modules/black_mesa/sound/mobs/zombies/claw_strike.ogg'
	obj_damage = 21
	combat_mode = TRUE

	// Movement and behavior
	speed = 1
	move_force = MOVE_FORCE_STRONG
	move_resist = MOVE_FORCE_STRONG
	pull_force = MOVE_FORCE_STRONG

	// Mob traits
	mob_biotypes = MOB_ORGANIC | MOB_HUMANOID
	basic_mob_flags = NONE
	faction = list(FACTION_XEN)
	ai_controller = /datum/ai_controller/basic_controller/headcrab_zombie
	gold_core_spawnable = HOSTILE_SPAWN
	can_be_shielded = FALSE  // Zombies are corrupted humans, not true Xen allies

	/// What type of corpse to spawn when this zombie dies
	var/corpse_type = null
	/// The human that was zombified (for freeing on death)
	var/mob/living/carbon/human/zombified_human = null
	// Alert Sound System - Inherited from /mob/living/basic/blackmesa
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert3.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert4.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert5.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert6.ogg'
	)

/mob/living/basic/blackmesa/xen/headcrab_zombie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_smasher, strength_flag = ENVIRONMENT_SMASH_STRUCTURES)

/mob/living/basic/blackmesa/xen/headcrab_zombie/death(gibbed)
	if(!gibbed && prob(30))
		new /mob/living/basic/blackmesa/xen/headcrab(loc) // Headcrab detaches and survives!
	if(zombified_human)
		zombified_human.forceMove(get_turf(src))
		zombified_human = null
		qdel(src) // To ensure the non-player body gets deleted instead of there being two.
	else
		return ..()

/mob/living/basic/blackmesa/xen/headcrab_zombie/Destroy()
	if(zombified_human)
		zombified_human.forceMove(get_turf(src))
		zombified_human = null
	return ..()

/**
 * Zombie Variants
 * Different types of zombies with varying stats and corpses.
 */

/// Scientist zombie - baseline zombie with standard stats
/mob/living/basic/blackmesa/xen/headcrab_zombie/scientist
	name = "zombified scientist"
	desc = "Even after death, I still have to wear this horrible tie!"
	icon_state = "scientist_zombie"
	base_icon_state = "scientist_zombie"
	corpse_type = /obj/effect/mob_spawn/corpse/human/scientist_zombie

/// Security guard zombie - medium armor
/mob/living/basic/blackmesa/xen/headcrab_zombie/guard
	name = "zombified guard"
	desc = "About that brain I owed ya!"
	icon_state = "security_zombie"
	base_icon_state = "security_zombie"
	maxHealth = 140
	health = 140
	corpse_type = /obj/effect/mob_spawn/corpse/human/guard_zombie

/// HECU Marine zombie - heavy armor
/mob/living/basic/blackmesa/xen/headcrab_zombie/hecu
	name = "zombified marine"
	desc = "MY. ASS. IS. DEAD."
	icon_state = "hecu_zombie"
	base_icon_state = "hecu_zombie"
	maxHealth = 190
	health = 190
	corpse_type = /obj/effect/mob_spawn/corpse/human/hecu_zombie

/// HEV zombie - extremely tough due to the HEV suit
/mob/living/basic/blackmesa/xen/headcrab_zombie/hev
	name = "zombified hazardous environment specialist"
	desc = "User death... surpassed."
	icon_state = "hev_zombie"
	base_icon_state = "hev_zombie"
	maxHealth = 250
	health = 250

	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv3.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv4.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv5.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv6.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv7.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv8.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv9.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv10.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv11.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv12.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv13.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv14.ogg'
	)
