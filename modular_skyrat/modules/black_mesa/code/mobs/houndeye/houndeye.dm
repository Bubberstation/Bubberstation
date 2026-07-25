/mob/living/basic/blackmesa/xen/houndeye
	name = "houndeye"
	desc = "Some highly aggressive alien creature that attacks using sonic waves."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "houndeye"
	base_icon_state = "houndeye"
	icon_living = "houndeye"
	icon_dead = "houndeye_dead"

	// Stats
	maxHealth = 100
	health = 100
	melee_damage_lower = 15
	melee_damage_upper = 15
	obj_damage = 50
	attack_sound = 'sound/items/tools/welder.ogg'
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"

	// Sonic blast vars
	/// Whether we're currently charging up a sonic blast
	var/charging_sonic = FALSE
	/// World time when we can next use sonic blast
	var/next_sonic_blast = 0
	/// Sounds to play when charging sonic blast
	var/static/list/charge_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/charge1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/charge2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/charge3.ogg'
	)

	// Movement
	speed = 1
	ai_controller = /datum/ai_controller/basic_controller/houndeye
	basic_mob_flags = NONE

	// Mob properties
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	gold_core_spawnable = HOSTILE_SPAWN

	// Environmental resistances
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500

	// Alert sounds from parent type will be used
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert3.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert4.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/houndeye/he_alert5.ogg'
	)

/**
 * Visual effect for sonic blast charging
 *
 * Creates a charging effect that follows the houndeye
 */
/obj/effect/temp_visual/spirit_hound_charge
	icon = 'icons/effects/effects.dmi'
	icon_state = "lightning"
	duration = 1.5 SECONDS
	randomdir = FALSE
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	/// The mob we're attached to for following
	var/mob/attached_mob

/obj/effect/temp_visual/spirit_hound_charge/Initialize(mapload)
	. = ..()
	if(attached_mob)
		loc = attached_mob.loc

/**
 * Visual effect for the sonic blast wave
 *
 * Creates a visible indicator of the sonic blast's area of effect
 */
/obj/effect/temp_visual/sonicblast
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldsparkles"
	duration = 5
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE
