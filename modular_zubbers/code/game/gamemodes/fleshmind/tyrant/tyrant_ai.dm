/datum/ai_controller/basic_controller/fleshmind/tyrant
	behavior_tree_json = "modular_zubbers/code/game/gamemodes/fleshmind/tyrant/tyrant.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
		BB_AGGRO_RANGE = 14,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 5,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 7
	)


/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_laser
	name = "Main Laser"
	desc = "Shoot a laser towards a target"
	button_icon = 'icons/obj/weapons/guns/projectiles.dmi'
	button_icon_state = "green_laser"
	cooldown_time = 3 SECONDS
	projectile_type = /obj/projectile/beam/emitter/hitscan
	var/list/laser_projectile_sounds = list(
		'modular_zubbers/sound/fleshmind/tyrant/laser_1.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/laser_2.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/laser_3.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/laser_4.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/laser_5.ogg',
		'modular_zubbers/sound/fleshmind/tyrant/laser_6.ogg',
	)

/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_laser/attack_sequence(mob/living/firer, atom/target)
	projectile_sound = pick(laser_projectile_sounds)
	return ..()

/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket
	name = "Shoot Rocket"
	desc = "Shoot a rocket towards a target"
	button_icon = 'icons/obj/weapons/guns/projectiles.dmi'
	button_icon_state = "low_yield_rocket"
	cooldown_time = 3 SECONDS
	projectile_type = /obj/projectile/bullet/rocket/weak
	projectile_sound = 'sound/items/weapons/gun/general/rocket_launch.ogg'
	can_move = FALSE

/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket/attack_sequence(mob/living/firer, atom/target)
	firer.balloon_alert_to_viewers("begins whirring violently!")
	playsound(src, 'modular_zubbers/sound/fleshmind/tyrant/charge_up.ogg', 100, TRUE)
	if(!do_after(firer, 2 SECONDS))
		return
	return ..()
