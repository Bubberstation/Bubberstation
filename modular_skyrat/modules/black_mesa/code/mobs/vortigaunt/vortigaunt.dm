/**
 * Vortigaunt - Allied alien being capable of ranged attacks
 *
 * A friendly alien that uses beam attacks and maintains distance from enemies.
 * Uses ranged skirmish AI to maintain optimal distance while attacking.
 */
/mob/living/basic/blackmesa/xen/vortigaunt
	name = "vortigaunt"
	desc = "There is no distance between us. No false veils of time or space may intervene."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "vortigaunt"
	icon_living = "vortigaunt"
	icon_dead = "vortigaunt_dead"
	gender = MALE
	faction = list(FACTION_STATION, FACTION_NEUTRAL)
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)

	maxHealth = 130
	health = 130
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_sound = 'sound/items/weapons/bite.ogg'
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)

	ai_controller = /datum/ai_controller/basic_controller/vortigaunt
	gold_core_spawnable = FRIENDLY_SPAWN

	/// Sounds played when spotting enemies
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert01b.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert06.ogg',
	)

/**
 * Initialize the vortigaunt with ranged attack capabilities
 */
/mob/living/basic/blackmesa/xen/vortigaunt/Initialize(mapload)
	. = ..()
	// Add ranged attack component
	AddComponent(\
		/datum/component/ranged_attacks,\
		projectile_type = /obj/projectile/beam/emitter/hitscan,\
		projectile_sound = 'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/attack_shoot4.ogg',\
		cooldown_time = 5 SECONDS,\
		burst_shots = 1\
	)

/**
 * Slave Vortigaunt - Hostile variant that fights for the Xen forces
 */
/mob/living/basic/blackmesa/xen/vortigaunt/slave
	name = "slave vortigaunt"
	desc = "Bound by the shackles of a sinister force. He does not want to hurt you."
	icon_state = "vortigaunt_slave"
	faction = list(FACTION_XEN)
