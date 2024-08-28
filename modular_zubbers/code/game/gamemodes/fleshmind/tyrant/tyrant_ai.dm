/datum/ai_controller/basic_controller/fleshmind/tyrant
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability/tyrant,
		/datum/ai_planning_subtree/maintain_distance,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/tyrant,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind,
	)
/datum/ai_planning_subtree/targeted_mob_ability/tyrant
	ability_key = BB_TYRANT_LASER
	use_ability_behaviour = /datum/ai_behavior/targeted_mob_ability/tyrant
	finish_planning = FALSE

/datum/ai_planning_subtree/basic_ranged_attack_subtree/tyrant
	end_planning = FALSE

/datum/ai_behavior/targeted_mob_ability/tyrant
	var/secondary_ability_key = BB_TYRANT_ROCKET

/datum/ai_behavior/targeted_mob_ability/tyrant/get_ability_to_use(datum/ai_controller/controller, ability_key)
	if(prob(50))
		return controller.blackboard[secondary_ability_key]
	return controller.blackboard[ability_key]

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
	projectile_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	can_move = FALSE

/datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket/attack_sequence(mob/living/firer, atom/target)
	firer.balloon_alert_to_viewers("begins whirring violently!")
	playsound(src, 'modular_zubbers/sound/fleshmind/tyrant/charge_up.ogg', 100, TRUE)
	if(!do_after(firer, 2 SECONDS))
		return
	return ..()
