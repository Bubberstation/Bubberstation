/mob/living/basic/trooper/robust
	icon = 'icons/mob/simple/simple_human.dmi'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	maxHealth = 250
	health = 250
	basic_mob_flags = DEL_ON_DEATH
	speed = 1.4
	melee_damage_lower = 20
	melee_damage_upper = 25
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	melee_attack_cooldown = 0.8 SECONDS
	combat_mode = TRUE


	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 7.5
	ai_controller = /datum/ai_controller/basic_controller/trooper


	corpse = /obj/effect/mob_spawn/corpse/human



/datum/outfit/syndy_raider_base
	name = "Syndicate Commando Corpse"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/mod/control/pre_equipped/nuclear
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/syndy_raider_base_elite
	name = "Syndicate Commando Corpse"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/mod/control/pre_equipped/elite
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative

/obj/effect/mob_spawn/corpse/human/syndy_raider_base
	name = "Syndicate Raider"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndy_raider_base

/obj/effect/mob_spawn/corpse/human/syndy_raider_base/elite
	name = "Elite Syndicate Raider"
	outfit = /datum/outfit/syndy_raider_base_elite

/mob/living/basic/trooper/robust/syndicate
	name = "Syndicate raider"
	desc = "Death to Nanotrasen."
	maxHealth = 300
	health = 300


	faction = list(ROLE_SYNDICATE)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/syndy_raider_base
	corpse = /obj/effect/gibspawner/human

	/// Is we range trooper
	var/ranged = FALSE
	/// Type of bullet we use
	var/casingtype = /obj/item/ammo_casing/c9mm
	/// Sound to play when firing weapon
	var/projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	/// number of burst shots
	var/burst_shots
	/// Time between taking shots
	var/ranged_cooldown = 1 SECONDS

	/// Is we using shield to deflect bullets?
	var/shielding = FALSE

	var/laser_block_chance = 30

	var/projectile_deflect_chance = 30

/mob/living/basic/trooper/robust/syndicate/Initialize(mapload)
	. = ..()

	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	if(ranged)
		AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
		burst_shots = burst_shots,\
		)
		if(ranged_cooldown <= 1 SECONDS)
			AddComponent(/datum/component/ranged_mob_full_auto)


/mob/living/basic/trooper/robust/syndicate/projectile_hit(obj/projectile/hitting_projectile, def_zone, piercing_hit, blocked)
	if(istype(hitting_projectile, /obj/projectile/energy) && laser_block_chance)
		visible_message(span_danger("[src] blocks [hitting_projectile] with its shield!"))
		return BULLET_ACT_BLOCK
	else if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [hitting_projectile] with its shield!"))
		return BULLET_ACT_BLOCK
	return ..()


/datum/ai_controller/basic_controller/raider/ranged
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "Reinforcements incoming!",
		BB_RAIDER_STRIKE_POINT = null,
		BB_RAIDER_ATTACK_METHOD = list(
			/datum/ai_behavior/basic_ranged_attack
		),
		BB_RAIDER_INTERESTING_ITEMS = list(
			/obj/item/stack/spacecash,
			/obj/item/stack/sheet,
			/obj/item/gun),
		BB_RAIDER_INTERESTING_TARGETS = list(),
		BB_RAIDER_MY_ROLE = BB_RAIDER_ROLE_MEMBER,
		BB_RAIDER_VALUABLE_OBJECTS = list(
			/obj/machinery/rnd/production/protolathe,
			/obj/machinery/rnd/production/protolathe/department,
		),
		BB_RAIDER_TEAM = null,
		BB_RAIDER_REACH_STRIKE_POINT = FALSE,
		BB_RAIDER_DESTRUCTION_TARGET = null,
		BB_RAIDER_LOOT_TARGET = null,
		BB_RAIDER_SEARCH_COOLDOWN_END = 0,
		BB_RAIDER_HOLD_COOLDOWN_END = 0,
	)


/datum/ai_controller/basic_controller/raider/melee
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "Reinforcements incoming!",
		BB_RAIDER_STRIKE_POINT = null,
		BB_RAIDER_ATTACK_METHOD = list(
			/datum/ai_behavior/basic_melee_attack
		),
		BB_RAIDER_INTERESTING_ITEMS = list(
			/obj/item/stack/spacecash,
			/obj/item/stack/sheet,
			/obj/item/gun),
		BB_RAIDER_INTERESTING_TARGETS = list(),
		BB_RAIDER_MY_ROLE = BB_RAIDER_ROLE_MEMBER,
		BB_RAIDER_VALUABLE_OBJECTS = list(
			/obj/machinery/rnd/production/protolathe,
			/obj/machinery/rnd/production/protolathe/department,
		),
		BB_RAIDER_TEAM = null,
		BB_RAIDER_REACH_STRIKE_POINT = FALSE,
		BB_RAIDER_DESTRUCTION_TARGET = null,
		BB_RAIDER_LOOT_TARGET = null,
		BB_RAIDER_SEARCH_COOLDOWN_END = 0,
		BB_RAIDER_HOLD_COOLDOWN_END = 0,
	)


/mob/living/basic/trooper/robust/syndicate/c20r
	ranged = TRUE
	r_hand = /obj/item/gun/ballistic/automatic/c20r
	l_hand = /obj/item/shield/energy/advanced
	ai_controller = /datum/ai_controller/basic_controller/raider/ranged
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/items/weapons/gun/smg/shot.ogg'
	shielding = TRUE
	burst_shots = 3
	ranged_cooldown = 5
	laser_block_chance = 50
	projectile_deflect_chance = 50

/mob/living/basic/trooper/robust/syndicate/buldog
	ranged = TRUE
	r_hand = /obj/item/gun/ballistic/shotgun/bulldog
	ai_controller = /datum/ai_controller/basic_controller/raider/ranged
	casingtype = /obj/item/ammo_casing/shotgun/buckshot/milspec
	projectilesound = 'sound/items/weapons/gun/shotgun/shot_alt.ogg'
	burst_shots = 2
	ranged_cooldown = 1.5 SECONDS


/mob/living/basic/trooper/robust/syndicate/buldog/antimaterial
	ranged = TRUE
	r_hand = /obj/item/gun/ballistic/rifle/sniper_rifle
	ai_controller = /datum/ai_controller/basic_controller/raider/ranged
	casingtype = /obj/item/ammo_casing/p50
	projectilesound = 'sound/items/weapons/gun/sniper/shot.ogg'
	burst_shots = 1
	ranged_cooldown = 7 SECONDS


/mob/living/basic/trooper/robust/syndicate/esword
	ai_controller = /datum/ai_controller/basic_controller/raider/melee
	r_hand = /obj/item/melee/energy/sword
	l_hand = /obj/item/shield/energy/advanced
	shielding = TRUE
	laser_block_chance = 50
	projectile_deflect_chance = 50
	melee_damage_lower = 35
	melee_damage_upper = 35


/mob/living/basic/trooper/robust/syndicate/elite
	name = "Elite Syndicate Raider"
	damage_coeff = list(BRUTE = 0.6, BURN = 0.6, TOX = 0, STAMINA = 0, OXY = 0)
	ai_controller = /datum/ai_controller/basic_controller/raider
	corpse = /obj/effect/mob_spawn/corpse/human/syndy_raider_base/elite
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 35
	armour_penetration = 50

	r_hand = /obj/item/dualsaber_fake
	shielding = TRUE
	laser_block_chance = 100
	projectile_deflect_chance = 50
	light_on = TRUE
	light_system = OVERLAY_LIGHT
	light_color = LIGHT_COLOR_INTENSE_RED
	light_range = 4

/mob/living/basic/trooper/robust/syndicate/elite/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(prob(30))
		dance_rotate(src, CALLBACK(src, TYPE_PROC_REF(/mob, dance_flip)))

/mob/living/basic/trooper/robust/syndicate/elite/Life(seconds_per_tick, times_fired)
	. = ..()
	set_light_color(pick(COLOR_SOFT_RED, LIGHT_COLOR_GREEN, LIGHT_COLOR_LIGHT_CYAN, LIGHT_COLOR_LAVENDER))

/obj/item/dualsaber_fake
	name = "double-bladed energy sword"
	desc = "Handle with care."
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	icon_state = "dualsaberrainbow1"
	inhand_icon_state = "dualsaberrainbow1"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
