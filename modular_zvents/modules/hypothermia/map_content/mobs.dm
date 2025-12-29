#define SPECIES_MUTANT_ARCTIC "arctic_mutant"

/mob/living/carbon/human/species/arctic_mutant
	race = /datum/species/arctic_mutant


/datum/species/arctic_mutant
	name = "Arctic Mutant"
	id = SPECIES_MUTANT_ARCTIC
	sexes = TRUE
	meat = /obj/item/food/meat/slab/human
	mutanttongue = /obj/item/organ/tongue/arctic_mutant
	inherent_traits = list(
		TRAIT_BLOODY_MESS,
		TRAIT_EASILY_WOUNDED,
		TRAIT_EASYDISMEMBER,
		TRAIT_FAKEDEATH,
		TRAIT_LIMBATTACHMENT,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_NOBREATH,
		TRAIT_NODEATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NOHUNGER,
		TRAIT_NO_DNA_COPY,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_TOXIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_SUCCUMB_OVERRIDE,
		TRAIT_NIGHT_VISION,
	)
	mutantstomach = null
	mutantheart = null
	mutantliver = null
	mutantlungs = null
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN
	bodytemp_normal = T0C - 100
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_EXIST
	bodytemp_cold_damage_limit = MINIMUM_TEMPERATURE_TO_MOVE - 100
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/arctic_mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/arctic_mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/arctic_mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/arctic_mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/arctic_mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/arctic_mutant
	)

	var/do_spooks = list(
		'modular_zvents/sounds/mobs/mutant_spoke_1.ogg',
		'modular_zvents/sounds/mobs/mutant_spoke_2.ogg',
		'modular_zvents/sounds/mobs/mutant_spoke_3.ogg',
	)




/datum/species/arctic_mutant/spec_life(mob/living/carbon/carbon_mob, seconds_per_tick, times_fired)
	. = ..()
	if(!SPT_PROB(2, seconds_per_tick))
		playsound(carbon_mob, pick(do_spooks), 50, TRUE, 10)

/obj/item/organ/tongue/arctic_mutant
	name = "mutant tongue"
	desc = "Frozen, pale tongue adapted to cold."
	say_mod = "growls"

/obj/item/bodypart/head/arctic_mutant
	limb_id = SPECIES_MUTANT_ARCTIC
	icon_greyscale = 'modular_zvents/icons/mob/arctic_mutant_bodypart.dmi'
	is_dimorphic = FALSE
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_DEBRAIN

/obj/item/bodypart/head/arctic_mutant/Initialize(mapload)
	worn_ears_offset = new(
		attached_part = src,
		feature_key = OFFSET_EARS,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_head_offset = new(
		attached_part = src,
		feature_key = OFFSET_HEAD,
		offset_x = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_mask_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACEMASK,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_glasses_offset = new(
		attached_part = src,
		feature_key = OFFSET_GLASSES,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_face_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACE,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	return ..()

/obj/item/bodypart/chest/arctic_mutant
	limb_id = SPECIES_MUTANT_ARCTIC
	icon_greyscale = 'modular_zvents/icons/mob/arctic_mutant_bodypart.dmi'

	is_dimorphic = FALSE
	bodypart_traits = list(TRAIT_NO_UNDERWEAR)

/obj/item/bodypart/chest/arctic_mutant/Initialize(mapload)
	worn_neck_offset = new(
		attached_part = src,
		feature_key = OFFSET_NECK,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	return ..()

/obj/item/bodypart/arm/left/arctic_mutant
	limb_id = SPECIES_MUTANT_ARCTIC
	icon_greyscale = 'modular_zvents/icons/mob/arctic_mutant_bodypart.dmi'


/obj/item/bodypart/arm/right/arctic_mutant
	limb_id = SPECIES_MUTANT_ARCTIC
	icon_greyscale = 'modular_zvents/icons/mob/arctic_mutant_bodypart.dmi'


/obj/item/bodypart/leg/left/arctic_mutant
	limb_id = SPECIES_MUTANT_ARCTIC
	icon_greyscale = 'modular_zvents/icons/mob/arctic_mutant_bodypart.dmi'


/obj/item/bodypart/leg/right/arctic_mutant
	limb_id = SPECIES_MUTANT_ARCTIC
	icon_greyscale = 'modular_zvents/icons/mob/arctic_mutant_bodypart.dmi'


/mob/living/basic/arctic_mutant
	name = "Arctic Mutant"
	desc = "A pale, cold-adapted horror from the depths of Zvezda caves."
	icon = 'icons/mob/simple/simple_human.dmi'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	maxHealth = 150
	health = 150
	max_stamina_slowdown = 4
	melee_damage_lower = 15
	melee_damage_upper = 25
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'modular_zvents/sounds/mobs/mutant_spoke_3.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	combat_mode = TRUE
	speed = 1
	status_flags = CANPUSH | CANSTUN
	death_message = "collapses into frozen remains!"
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	faction = list(FACTION_HOSTILE)
	basic_mob_flags = DEL_ON_DEATH|FLAMMABLE_MOB
	ai_controller = /datum/ai_controller/basic_controller/arctic_mutant

	var/outfit = null
	var/r_hand = null
	var/l_hand = null

	var/datum/looping_sound/mutant_breath/breath_loop

/mob/living/basic/arctic_mutant/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, outfit, /datum/species/arctic_mutant, bloody_slots = ITEM_SLOT_OCLOTHING, r_hand = r_hand, l_hand = l_hand)
	AddElement(/datum/element/death_drops, /obj/effect/decal/remains/human)


	breath_loop = new(src, TRUE)
	ADD_TRAIT(src, TRAIT_NIGHT_VISION, INNATE_TRAIT)
	update_sight()


/mob/living/basic/arctic_mutant/death(gibbed)
	breath_loop.stop()
	. = ..()

/mob/living/basic/arctic_mutant/Destroy()
	. = ..()
	qdel(breath_loop)


/mob/living/basic/arctic_mutant/light
	name = "Arctic Mutant"
	desc = "A bare, feral mutant from the ice caves."
	outfit = /datum/outfit/arctic_survivor
	ghost_controllable = TRUE
	r_hand = /obj/item/claymore/bone
	l_hand = /obj/item/flashlight/lantern/on

	light_power = 2
	light_on = TRUE
	light_range = 3

/mob/living/basic/arctic_mutant/naked
	name = "Arctic Mutant"
	desc = "A bare, feral mutant from the ice caves."
	maxHealth = 70
	health = 70
	outfit = null
	ghost_controllable = TRUE
	r_hand = null
	l_hand = null

/mob/living/basic/arctic_mutant/armored
	name = "Armored Arctic Mutant"
	desc = "A mutant clad in makeshift armor, tougher in the cold."
	outfit = /datum/outfit/arctic_armored
	maxHealth = 200
	health = 200
	speed = 2
	ghost_controllable = TRUE
	r_hand = /obj/item/fireaxe/boneaxe
	l_hand = null

/mob/living/basic/arctic_mutant/spearman
	name = "Spear Arctic Mutant"
	desc = "A mutant armed with a crude spear, hunting in the shadows."
	outfit = /datum/outfit/arctic_spear
	melee_damage_lower = 25
	melee_damage_upper = 15
	r_hand = /obj/item/spear/bonespear
	l_hand = null

/datum/outfit/arctic_survivor
	name = "Arctic Survivor Corpse"
	head = /obj/item/clothing/head/helmet/skull
	uniform = /obj/item/clothing/under/misc/skyrat/gear_harness
	shoes = /obj/item/clothing/shoes/bone_greaves
	gloves = /obj/item/clothing/gloves/bracer


/datum/outfit/arctic_armored
	name = "Armored Arctic Mutant"
	head = /obj/item/clothing/head/helmet/skull
	suit = /obj/item/clothing/suit/armor/bone
	uniform = /obj/item/clothing/under/misc/skyrat/gear_harness
	shoes = /obj/item/clothing/shoes/bone_greaves
	gloves = /obj/item/clothing/gloves/bracer

/datum/outfit/arctic_spear
	name = "Spear Arctic Mutant"
	head = /obj/item/clothing/head/helmet/skull
	shoes = /obj/item/clothing/shoes/bone_greaves
	gloves = /obj/item/clothing/gloves/bracer
	uniform = /obj/item/clothing/under/misc/skyrat/gear_harness

#define BB_TEMP_TARGET "bb_temp_target"
#define BB_GROUP_LEADER "bb_formation_leader"

/datum/ai_planning_subtree/move_to_light

/datum/ai_planning_subtree/move_to_light/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(target)
		return
	var/turf/best_turf
	var/best_light = 0
	for(var/turf/visible_turf in view(7, controller.pawn))
		if(visible_turf.light_power > best_light)
			best_light = visible_turf.light_power
			best_turf = visible_turf
	if(best_turf)
		controller.blackboard[BB_TEMP_TARGET] = best_turf
		controller.queue_behavior(/datum/ai_behavior/move_to_temp_target)

/datum/ai_behavior/move_to_temp_target
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM
	required_distance = 1

/datum/ai_behavior/move_to_temp_target/perform(delta_time, datum/ai_controller/controller)
	var/atom/target = controller.blackboard[BB_TEMP_TARGET]
	if(!target)
		return AI_BEHAVIOR_FAILED
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_TEMP_TARGET)
	if(get_dist(controller.pawn, target) <= 1)
		controller.blackboard[BB_TEMP_TARGET] = null
		return AI_BEHAVIOR_SUCCEEDED
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

/datum/ai_planning_subtree/flock_together


/datum/ai_planning_subtree/flock_together/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return
	var/list/nearby_mutants = list()
	for(var/mob/living/basic/arctic_mutant/mutant in oview(5, pawn))
		if(mutant != controller.pawn && mutant.faction == pawn.faction)
			nearby_mutants += mutant
	if(length(nearby_mutants) < 3)
		var/mob/living/closest_ally
		var/closest_dist = INFINITY
		for(var/mob/living/basic/arctic_mutant/mutant in oview(10, pawn))
			if(mutant.client)
				closest_ally = mutant
				break
			if(mutant != controller.pawn && mutant.faction == pawn.faction)
				var/dist = get_dist(controller.pawn, mutant)
				if(dist < closest_dist)
					closest_dist = dist
					closest_ally = mutant
		if(closest_ally)
			controller.blackboard[BB_GROUP_LEADER] = closest_ally
			controller.queue_behavior(/datum/ai_behavior/follow_leader)
	else
		var/avg_x = 0
		var/avg_y = 0
		for(var/mob/living/mutant in nearby_mutants)
			avg_x += mutant.x
			avg_y += mutant.y
		avg_x /= nearby_mutants.len
		avg_y /= nearby_mutants.len
		var/turf/group_center = locate(round(avg_x), round(avg_y), controller.pawn.z)
		if(group_center && get_dist(controller.pawn, group_center) > 1)
			controller.blackboard[BB_TEMP_TARGET] = group_center
			controller.queue_behavior(/datum/ai_behavior/move_to_temp_target)

/datum/ai_behavior/follow_leader
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM
	required_distance = 2

/datum/ai_behavior/follow_leader/perform(delta_time, datum/ai_controller/controller)
	var/mob/living/leader = controller.blackboard[BB_GROUP_LEADER]
	if(!leader || leader.stat == DEAD)
		controller.blackboard[BB_GROUP_LEADER] = null
		return AI_BEHAVIOR_FAILED
	controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, leader)
	if(get_dist(controller.pawn, leader) <= 2)
		return AI_BEHAVIOR_SUCCEEDED
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

/datum/targeting_strategy/basic/arctic_mutant
	var/min_distance = 2

/datum/targeting_strategy/basic/arctic_mutant/can_attack(mob/living/living_mob, atom/the_target, vision_range)
	. = ..()
	if(!the_target || !.)
		return FALSE
	if(. && get_dist(living_mob, the_target) <= min_distance)
		return TRUE
	var/turf/target_turf = get_turf(the_target)
	if(. && (target_turf.get_lumcount() < 1))
		return FALSE

#undef BB_TEMP_TARGET
#undef BB_GROUP_LEADER

/datum/ai_controller/basic_controller/arctic_mutant
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/arctic_mutant,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/move_to_light,
		/datum/ai_planning_subtree/flock_together,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant
	name = "arctic mutant pod"
	desc = "A frozen pod containing a dormant mutant. Ghosts can enter to play as it."
	icon_state = "cryostasis_pod"
	mob_species = /datum/species/mutant
	mob_name = "Arctic Mutant"
	you_are_text = "You are an arctic mutant awakened from cryosleep."
	flavour_text = "Survive in the caves of Zvezda, hunt intruders."
	outfit = /datum/outfit/arctic_survivor
	restricted_species = list(/datum/species/mutant)


/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/special(mob/living/carbon/human/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(null,"Arctic Mutant")

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/naked
	outfit = null

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/armored
	outfit = /datum/outfit/arctic_armored

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/spearman
	outfit = /datum/outfit/arctic_spear


/obj/effect/spawner/random/arctic_mutant
	name = "arctic mutant spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x3"
	spawn_loot_count = 4
	loot = list(
		/mob/living/basic/arctic_mutant/light = 2,
		/mob/living/basic/arctic_mutant/naked = 3,
		/mob/living/basic/arctic_mutant/armored = 1,
		/mob/living/basic/arctic_mutant/spearman = 1,
	)

#undef SPECIES_MUTANT_ARCTIC

/datum/looping_sound/mutant_breath
	mid_sounds = list(
		'modular_zvents/sounds/mobs/mutant_idel_1.ogg' = 1,
		'modular_zvents/sounds/mobs/mutant_idel_2.ogg' = 1,,

	)
	mid_length = 1 SECONDS
	volume = 10
	falloff_exponent = 2



#define MUTANT_BOSS_CHARGE_COOLDOWN (7 SECONDS)
#define MUTANT_BOSS_TENTACLE_COOLDOWN (12 SECONDS)
#define MUTANT_BOSS_BONE_COOLDOWN (4 SECONDS)
#define MUTANT_BOSS_LEAP_COOLDOWN (8 SECONDS)
#define MUTANT_BOSS_PASSIVE_HEAL 3

#define MUTANT_ABILITY_CHARGE "bb_boss_charge"
#define MUTANT_ABILITY_TENTACLE "bb_boss_tentacle"
#define MUTANT_ABILITY_LEAP "bb_boss_leap"
#define MUTANT_ABILITY_BONE "bb_boss_bone"

/obj/effect/temp_visual/telegraphing/boss_hit
	duration = 5

/obj/effect/temp_visual/telegraphing/boss_hit/aoe
	duration = 10
	icon = 'icons/mob/telegraphing/telegraph_96x96.dmi'
	icon_state = "target_largebox"
	pixel_x = -32
	pixel_y = -32

/mob/living/basic/corrupted_mutant_boss
	name = "corrupted mutant boss"
	real_name = "corrupted mutant boss"
	desc = "A massive, horrifying mutant leader. It commands lesser mutants and unleashes devastating attacks."
	icon = 'modular_skyrat/modules/horrorform/icons/animal.dmi'
	icon_state = "horror"
	icon_living = "horror"
	icon_dead = "horror_dead"
	mob_biotypes = MOB_ORGANIC
	speed = 1
	maxHealth = 1500
	health = 1500
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	armour_penetration = 50
	melee_damage_lower = 30
	melee_damage_upper = 45
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/effects/blob/blobattack.ogg'
	gold_core_spawnable = FALSE

	var/playstyle_string = span_infoplain("<b><font size=3 color='red'>We are the Corrupted Mutant Boss!</font> We are extremely powerful with multiple abilities: charge, tentacles, bone shards, and leap. Use them wisely via action buttons. We regenerate health over time but watch our health!</b>")
	var/projectile_evade_cooldown = 2 SECONDS
	var/evade_steps = 3
	var/drop
	var/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/boss_charge = MUTANT_ABILITY_CHARGE,
		/datum/action/cooldown/mob_cooldown/boss_tentacle = MUTANT_ABILITY_TENTACLE,
		/datum/action/cooldown/mob_cooldown/boss_bone_shard = MUTANT_ABILITY_BONE,
		/datum/action/cooldown/mob_cooldown/boss_leap = MUTANT_ABILITY_BONE,
	)

	ai_controller = /datum/ai_controller/basic_controller/corrupted_mutant_boss
	COOLDOWN_DECLARE(projectile_evade)



/mob/living/basic/corrupted_mutant_boss/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/regenerator, regeneration_delay = 0, brute_per_second = MUTANT_BOSS_PASSIVE_HEAL)
	if(length(innate_actions))
		grant_actions_by_list(innate_actions)
	add_traits(list(TRAIT_NO_TELEPORT, TRAIT_MARTIAL_ARTS_IMMUNE, TRAIT_LAVA_IMMUNE,TRAIT_ASHSTORM_IMMUNE, TRAIT_NO_FLOATING_ANIM), MEGAFAUNA_TRAIT)
	AddComponent(/datum/component/seethrough_mob)
	AddElement(/datum/element/simple_flying)
	if(drop)
		AddElement(/datum/element/death_drops, drop)

/mob/living/basic/corrupted_mutant_boss/Life()
	. = ..()

/mob/living/basic/corrupted_mutant_boss/death()
	. = ..()
	visible_message(span_warning("[src] lets out a final roar and collapses!"))
	playsound(src, 'modular_zvents/sounds/mobs/mutant_boss_death.ogg', 40, TRUE)


/mob/living/basic/corrupted_mutant_boss/bullet_act(obj/projectile/proj, def_zone, piercing_hit, blocked)
	if(!prob(80))
		return ..()
	if(!COOLDOWN_FINISHED(src, projectile_evade))
		return ..()
	var/evade_dir = angle2dir(proj.dir)

	if(proj.dir & (proj.dir - 1))
		evade_dir = prob(50) ? turn(proj.dir, 90) : turn(proj.dir, -90)
	else
		evade_dir = prob(50) ? turn(proj.dir, 90) : turn(proj.dir, -90)

	INVOKE_ASYNC(src, PROC_REF(do_strafe_evade), evade_dir)
	return BULLET_ACT_FORCE_PIERCE

/mob/living/basic/corrupted_mutant_boss/proc/do_strafe_evade(move_dir)
	COOLDOWN_START(src, projectile_evade, projectile_evade_cooldown)
	visible_message(span_warning("[src] straifes!"))
	playsound(src, 'modular_zvents/sounds/mobs/mutant_boss_hit.ogg', 40, TRUE)

	var/step_count = 0
	while(step_count <= evade_steps)
		var/turf/next_turf = get_step(src, move_dir)
		if(!next_turf || next_turf.density || next_turf.is_blocked_turf(TRUE))
			move_dir = turn(move_dir, 180)
			next_turf = get_step(src, move_dir)
			if(!next_turf || next_turf.density || next_turf.is_blocked_turf(TRUE))
				break
		new /obj/effect/temp_visual/decoy/fading/halfsecond(loc, src)
		forceMove(next_turf)
		step_count++
		CHECK_TICK
		sleep(0.1)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(loc, src)
	playsound(src, 'sound/effects/bang.ogg', 50, TRUE, -1)


/mob/living/basic/corrupted_mutant_boss/real
	drop = list(/obj/item/keycard/important/hypothermia/ship_control_key, /obj/item/storage/belt/utility/chief/full)
	maxHealth = 1800
	health = 1800


/mob/living/basic/corrupted_mutant_boss/real/death()
	. = ..()
	for(var/mob/living/player in orange(20, src))
		if(!player.client)
			continue
		player.client.give_award(/datum/award/achievement/petrov_kill, player)

/datum/action/cooldown/mob_cooldown/boss_charge
	name = "Charge"
	desc = "Charge towards a targeted location, dealing heavy damage on impact."
	button_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	button_icon_state = "goliath_baby"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	click_to_activate = TRUE
	cooldown_time = MUTANT_BOSS_CHARGE_COOLDOWN
	melee_cooldown_time = 0
	shared_cooldown = NONE

	var/max_range = 10
	var/charge_sound = 'modular_zvents/sounds/mobs/mutant_boss_attack_01.ogg'
	var/charge_delay = 5

/datum/action/cooldown/mob_cooldown/boss_charge/PreActivate(atom/target)
	target = get_turf(target)
	if (get_dist(owner, target) > max_range)
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/boss_charge/Activate(atom/target)
	var/dist = get_dist(owner, target) - 1
	if(dist <= 1)
		owner.balloon_alert(owner, "To close!")
		return
	INVOKE_ASYNC(src, PROC_REF(do_charge), get_turf(target))
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/boss_charge/proc/do_charge(turf/target)
	owner.visible_message(span_danger("[owner] charges towards [target]!"))
	if(charge_delay)
		new /obj/effect/temp_visual/telegraphing/boss_hit(target)
		if(!do_after(owner, charge_delay))
			owner.balloon_alert(owner, "Interupted!")
	if(charge_sound)
		playsound(owner, charge_sound, 40)
	var/dist = get_dist(owner, target) - 1
	for(var/i = 1 to dist)
		if(get_dist(owner, target) <= 1)
			break
		new /obj/effect/temp_visual/decoy/fading/halfsecond(owner.loc, owner)
		owner.forceMove(get_step_towards(owner, target))

	for(var/mob/living/living_target in target.contents)
		if(get_dist(owner, living_target) <= 1)
			var/damage = rand(20, 30)
			if(!(living_target.check_block(owner, damage, armour_penetration = 50) == SUCCESSFUL_BLOCK))
				living_target.take_bodypart_damage(damage)
				living_target.Knockdown(10)
				shake_camera(living_target)
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 100, TRUE)




/datum/action/cooldown/mob_cooldown/boss_tentacle
	name = "Tentacle Grasp"
	desc = "Unleash tentacles that grasp nearby players, pull them to you, deal damage, and knock them away."
	button_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	button_icon_state = "goliath_tentacle_wiggle"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"
	click_to_activate = FALSE
	cooldown_time = MUTANT_BOSS_TENTACLE_COOLDOWN
	melee_cooldown_time = 0
	shared_cooldown = NONE
	var/tentacle_range = 5
	var/pull_delay = 1 SECONDS
	var/grasp_delay = 1 SECONDS
	var/use_sound = 'modular_zvents/sounds/mobs/mutant_boss_attack_02.ogg'

/datum/action/cooldown/mob_cooldown/boss_tentacle/Activate(atom/target)
	INVOKE_ASYNC(src, PROC_REF(do_grasp))
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/boss_tentacle/proc/do_grasp()
	owner.visible_message(span_danger("[owner] unleashes grasping tentacles around itself!"))
	var/list/targets = list()
	for(var/mob/living/L in oview(tentacle_range, owner))
		if(L == owner || L.stat == DEAD || !isliving(L))
			continue
		targets += L
		new /obj/effect/temp_visual/telegraphing/boss_hit(get_turf(L))
	if(!do_after(owner, grasp_delay, owner))
		owner.balloon_alert(owner, "Interrupted!")
		return
	for(var/mob/living/L in targets)
		if(!L)
			continue
		var/turf/original_turf = get_turf(L)
		if(use_sound)
			playsound(owner, use_sound, 50, TRUE)
		addtimer(CALLBACK(src, PROC_REF(pull_target), L, original_turf), pull_delay)
		addtimer(CALLBACK(src, PROC_REF(aoe_effect)), pull_delay + 1 SECONDS)

/datum/action/cooldown/mob_cooldown/boss_tentacle/proc/aoe_effect()
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 100, TRUE)
	new /obj/effect/temp_visual/telegraphing/boss_hit/aoe(get_turf(owner))
	sleep(1 SECONDS)
	CHECK_TICK
	new /obj/effect/temp_visual/explosion/fast(get_turf(owner))
	for(var/mob/living/L in orange(1, owner))
		if(L == owner)
			continue
		L.throw_at(get_edge_target_turf(owner, pick(GLOB.cardinals)), 3, 2, owner)
		L.take_bodypart_damage(20, 5)

/datum/action/cooldown/mob_cooldown/boss_tentacle/proc/pull_target(mob/living/target, turf/original_turf)
	if(!target || target.stat == DEAD)
		return
	if(!get_dist(owner, target) > tentacle_range)
		return
	if(get_turf(target) != original_turf)
		return
	if(target.check_block(owner, armour_penetration = 50) == SUCCESSFUL_BLOCK)
		return
	owner.Beam(target, icon_state = "tentacle", time = 5)
	sleep(5)
	CHECK_TICK
	target.Knockdown(3 SECONDS)
	target.throw_at(owner, speed = 3, range = get_dist(owner, target), force = TRUE)
	target.take_bodypart_damage(20, 5)
	owner.visible_message(span_danger("[owner] slams [target] and knocks them away!"))



/datum/action/cooldown/mob_cooldown/boss_bone_shard
	name = "Hurl Bone Shards"
	desc = "Hurl a barrage of bone shards at a targeted location after a delay."
	button_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	button_icon_state = "legion_turret"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	click_to_activate = TRUE
	cooldown_time = MUTANT_BOSS_BONE_COOLDOWN
	melee_cooldown_time = 0
	shared_cooldown = NONE
	var/max_range = 15
	var/shard_delay = 4
	var/shard_sound = 'sound/effects/splat.ogg'

/datum/action/cooldown/mob_cooldown/boss_bone_shard/PreActivate(atom/target)
	target = get_turf(target)
	if (get_dist(owner, target) > max_range)
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/boss_bone_shard/Activate(atom/target)
	INVOKE_ASYNC(src, PROC_REF(do_hurl), get_turf(target))
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/boss_bone_shard/proc/do_hurl(turf/target)
	owner.visible_message(span_danger("[owner] prepares to hurl bone shards at [target]!"))
	new /obj/effect/temp_visual/telegraphing/boss_hit(target)
	sleep(shard_delay)
	owner.visible_message(span_danger("[owner] hurls bone shards!"))
	if(shard_sound)
		playsound(owner, shard_sound, 50, TRUE)
	for(var/i = 1 to 5)
		owner.fire_projectile(/obj/projectile/bullet/pellet/bone_fragment, target, firer = owner)
		sleep(0.1 SECONDS)


/datum/action/cooldown/mob_cooldown/boss_leap
	name = "Leap"
	desc = "Leap towards a targeted location after a delay, dealing AOE damage on landing."
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	click_to_activate = TRUE
	cooldown_time = MUTANT_BOSS_LEAP_COOLDOWN
	melee_cooldown_time = 0
	shared_cooldown = NONE
	var/max_range = 10
	var/leap_delay = 1 SECONDS
	var/leap_sound = 'modular_zvents/sounds/mobs/mutant_boss_attack_03.ogg'

/datum/action/cooldown/mob_cooldown/boss_leap/PreActivate(atom/target)
	target = get_turf(target)
	if (get_dist(owner, target) > max_range)
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/boss_leap/Activate(atom/target)
	INVOKE_ASYNC(src, PROC_REF(do_leap), get_turf(target))
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/boss_leap/proc/do_leap(turf/target)
	owner.visible_message(span_danger("[owner] prepares to leap towards [target]!"))
	new /obj/effect/temp_visual/telegraphing/boss_hit/aoe(target)
	if(!do_after(owner, leap_delay, owner))
		owner.balloon_alert(owner, "Interrupted!")
		return
	if(leap_sound)
		playsound(owner, leap_sound, 50, TRUE)
	owner.throw_at(target, get_dist(owner, target), 3, owner, spin = FALSE)
	addtimer(CALLBACK(src, PROC_REF(leap_land), target), 1)

/datum/action/cooldown/mob_cooldown/boss_leap/proc/leap_land(atom/target)
	var/turf/land_turf = get_turf(owner)
	new /obj/effect/temp_visual/explosion(land_turf)
	playsound(land_turf, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	for(var/mob/living/L in range(1, land_turf))
		if(L == owner)
			continue
		L.throw_at(get_edge_target_turf(owner, pick(GLOB.cardinals)), 3, 2, owner)
		L.take_bodypart_damage(30, 10)
		L.Knockdown(3 SECONDS)
		shake_camera(L)

#define MIN_TIME_TO_ABILITY (1 SECONDS)

/datum/ai_controller/basic_controller/corrupted_mutant_boss
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_ALWAYS_IGNORE_FACTION = TRUE,
		BB_AGGRO_RANGE = 20,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_charge,
		/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_leap,
		/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_tentacle,
		/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_bone_shard,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/corrupted_mutant_boss,
	)

/datum/ai_planning_subtree/basic_melee_attack_subtree/corrupted_mutant_boss
	operational_datums = list(/datum/component/ai_target_timer)
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/corrupted_mutant_boss

/datum/ai_behavior/basic_melee_attack/corrupted_mutant_boss/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	var/list/ability_keys = list(MUTANT_ABILITY_CHARGE, MUTANT_ABILITY_LEAP, MUTANT_ABILITY_TENTACLE, MUTANT_ABILITY_BONE)
	for(var/key in ability_keys)
		var/datum/action/cooldown/mob_cooldown/ability = controller.blackboard[key]
		if(istype(ability) && ability.IsAvailable())
			return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	return ..()

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_charge
	ability_key = MUTANT_ABILITY_CHARGE
	min_range = 4
	max_range = 12
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_charge/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return
	return ..()

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_leap
	ability_key = MUTANT_ABILITY_LEAP
	min_range = 6
	max_range = 10
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_leap/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return
	return ..()

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_tentacle
	ability_key = MUTANT_ABILITY_TENTACLE
	min_range = 3
	max_range = 5
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_tentacle/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return
	return ..()

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_bone_shard
	ability_key = MUTANT_ABILITY_BONE
	min_range = 2
	max_range = 10
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/min_range/boss_bone_shard/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return
	return ..()

#undef MIN_TIME_TO_ABILITY

/datum/ai_planning_subtree/targeted_mob_ability/min_range
	var/min_range = 0
	var/max_range = 0

/datum/ai_planning_subtree/targeted_mob_ability/min_range/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(!.)
		return

	var/mob/living/pawn = controller.pawn
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return

	var/dist = get_dist(pawn, target)

	if(min_range && dist <= min_range)
		return
	if(max_range && dist > max_range)
		return

	controller.queue_behavior(/datum/ai_behavior/targeted_mob_ability, ability_key, BB_BASIC_MOB_CURRENT_TARGET)
	if(finish_planning)
		return SUBTREE_RETURN_FINISH_PLANNING


#undef MUTANT_BOSS_CHARGE_COOLDOWN
#undef MUTANT_BOSS_TENTACLE_COOLDOWN
#undef MUTANT_BOSS_BONE_COOLDOWN
#undef MUTANT_BOSS_LEAP_COOLDOWN
#undef MUTANT_BOSS_PASSIVE_HEAL
