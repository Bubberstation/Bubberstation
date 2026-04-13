/mob/living/basic/trooper/cin_soldier
	name = "Coalition Operative"
	desc = "Death to SolFed."
	melee_damage_lower = 15
	melee_damage_upper = 20
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/ancient_milsim
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/blade1.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	faction = list(ROLE_SYNDICATE)
	corpse = /obj/effect/mob_spawn/corpse/human/cin_soldier
	mob_spawner = /obj/effect/mob_spawn/corpse/human/cin_soldier

/datum/ai_controller/basic_controller/trooper/calls_reinforcements/ancient_milsim
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_REINFORCEMENTS_SAY = "Call contact at nine dash two."
	)

/datum/ai_controller/basic_controller/trooper/calls_reinforcements/ancient_milsim/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)

/mob/living/basic/trooper/cin_soldier/melee
	r_hand = /obj/item/melee/energy/sword/saber/purple
	l_hand = /obj/item/shield/energy
	loot = list(/obj/effect/spawner/random/ancient_milsim/melee)
	var/projectile_deflect_chance = 20

/mob/living/basic/trooper/cin_soldier/melee/bullet_act(obj/projectile/projectile)
	if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [projectile] with their shield!"))
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/basic/trooper/cin_soldier/ranged
	melee_damage_lower = 5
	melee_damage_upper = 10
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/ancient_milsim/ranged
	r_hand = /obj/item/gun/ballistic/automatic/miecz
	loot = list(/obj/effect/spawner/random/ancient_milsim/ranged)
	/// Type of bullet we use
	var/casingtype = /obj/item/ammo_casing/c27_54cesarzowa
	/// Sound to play when firing weapon
	var/projectilesound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'
	/// number of burst shots
	var/burst_shots = 2
	/// Time between taking shots
	var/ranged_cooldown = 0.45 SECONDS

/mob/living/basic/trooper/cin_soldier/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
		burst_shots = burst_shots,\
	)

/mob/living/basic/trooper/cin_soldier/ranged/shotgun_revolver
	r_hand = /obj/item/gun/ballistic/revolver/shotgun_revolver
	l_hand = /obj/item/shield/ballistic
	ai_controller = /datum/ai_controller/basic_controller/trooper/ranged/shotgunner
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	projectilesound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	burst_shots = 1
	ranged_cooldown = 1.25 SECONDS
	var/projectile_deflect_chance = 10

/mob/living/basic/trooper/cin_soldier/ranged/shotgun_revolver/bullet_act(obj/projectile/projectile)
	if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [projectile] with their shield!"))
		return BULLET_ACT_BLOCK
	return ..()

/datum/modular_mob_segment/cin_mobs
	max = 3
	mobs = list(
		/mob/living/basic/trooper/cin_soldier/ranged,
		/mob/living/basic/trooper/cin_soldier/ranged/shotgun_revolver,
		/mob/living/basic/trooper/cin_soldier/melee,
	)

/obj/effect/mob_spawn/corpse/human/cin_soldier
	name = "Coalition Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/cin_soldier_corpse
	mob_name = "Echo One"
