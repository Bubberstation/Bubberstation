/**
 * Black Mesa Human NPCs
 * Various human NPCs from Black Mesa including HECU, Security, and Black Ops.
 */

/// Base type for all Black Mesa human NPCs
/mob/living/basic/blackmesa/human
	// Mob traits
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	basic_mob_flags = DEL_ON_DEATH // Handle death manually for corpse spawning
	status_flags = CANPUSH

	// Combat stats
	speed = 0
	combat_mode = TRUE
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'

	// Environmental resistances
	unsuitable_atmos_damage = 7.5
	habitable_atmos = list(
		"min_oxy" = 5, "max_oxy" = 0,
		"min_tox" = 0, "max_tox" = 1,
		"min_co2" = 0, "max_co2" = 5,
		"min_n2" = 0, "max_n2" = 0
	)
	minimum_survivable_temperature = T0C - 50
	maximum_survivable_temperature = T0C + 50

	// AI behavior
	ai_controller = /datum/ai_controller/basic_controller

	// Death handling
	/// The chance (0-100) to spawn a corpse instead of gibbing
	var/corpse_chance = 20
	/// The type of corpse to spawn on death
	var/obj/effect/mob_spawn/corpse/human/corpse
	/// The item to hold in the right hand
	var/obj/item/r_hand


/mob/living/basic/blackmesa/human/death(gibbed)
	if(!gibbed)
		var/turf/T = get_turf(src)
		if(T)
			// Clean up any components with active timers first
			new /obj/effect/gibspawner/human(T)

			if(prob(corpse_chance) && corpse)
				new corpse(T)

			// Clean up any casings at our feet
			for(var/obj/item/ammo_casing/casing in T)
				qdel(casing)

		qdel(src)
		return
	return ..()

/mob/living/basic/blackmesa/human/hecu
	name = "HECU Grunt"
	desc = "I didn't sign on for this shit. Monsters, sure, but civilians? Who ordered this operation anyway?"
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "hecu_melee"
	icon_living = "hecu_melee"
	icon_dead = "hecu_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 10
	faction = list(FACTION_HECU)
	ai_controller = /datum/ai_controller/basic_controller/hecu
	corpse = /obj/effect/mob_spawn/corpse/human/hecu
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert08.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert10.ogg'
	)


/mob/living/basic/blackmesa/human/hecu/ranged
	icon_state = "hecu_ranged"
	icon_living = "hecu_ranged"
	ai_controller = /datum/ai_controller/basic_controller/hecu/ranged
	corpse = /obj/effect/mob_spawn/corpse/human/hecu_ranged
	r_hand = /obj/item/gun/ballistic/automatic/pistol/deagle

/mob/living/basic/blackmesa/human/hecu/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = /obj/item/ammo_casing/a50ae,\
		projectile_sound = 'sound/items/weapons/gun/pistol/shot.ogg',\
		cooldown_time = 5 SECONDS,\
		burst_shots = 1\
	)

/mob/living/basic/blackmesa/human/hecu/ranged/smg
	icon_state = "hecu_ranged_smg"
	icon_living = "hecu_ranged_smg"
	ai_controller = /datum/ai_controller/basic_controller/hecu/ranged
	corpse = /obj/effect/mob_spawn/corpse/human/hecu_smg
	r_hand = /obj/item/gun/ballistic/automatic/c20r

/mob/living/basic/blackmesa/human/hecu/ranged/smg/Initialize(mapload)
	. = ..()
	// Override parent's pistol component with SMG settings
	qdel(GetComponent(/datum/component/ranged_attacks))
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = /obj/item/ammo_casing/c45,\
		projectile_sound = 'sound/items/weapons/gun/smg/shot.ogg',\
		cooldown_time = 3 SECONDS,\
		burst_shots = 3\
	)

/mob/living/basic/blackmesa/human/sec
	name = "Security Guard"
	desc = "About that beer I owe'd ya!"
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "security_guard_melee"
	icon_living = "security_guard_melee"
	icon_dead = "security_guard_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 100
	health = 100
	melee_damage_lower = 7
	melee_damage_upper = 7
	faction = list(FACTION_STATION, FACTION_NEUTRAL)
	ai_controller = /datum/ai_controller/basic_controller/sec
	corpse = /obj/effect/mob_spawn/corpse/human/security_guard
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance08.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance09.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance10.ogg'
	)

/mob/living/basic/blackmesa/human/sec/ranged
	icon_state = "security_guard_ranged"
	icon_living = "security_guard_ranged"
	ai_controller = /datum/ai_controller/basic_controller/sec/ranged
	corpse = /obj/effect/mob_spawn/corpse/human/security_guard/ranged
	r_hand = /obj/item/gun/ballistic/automatic/pistol/sol

/mob/living/basic/blackmesa/human/sec/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = /obj/item/ammo_casing/c35sol,\
		projectile_sound = 'sound/items/weapons/gun/pistol/shot.ogg',\
		cooldown_time = 5 SECONDS,\
		burst_shots = 1\
	)

/mob/living/basic/blackmesa/human/blackops
	name = "black operative"
	desc = "Why do we always have to clean up a mess the grunts can't handle?"
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "blackops"
	icon_living = "blackops"
	icon_dead = "blackops"
	icon_gib = "syndicate_gib"
	maxHealth = 200
	health = 200
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "strikes"
	attack_verb_simple = "strikes"
	attack_sound = 'sound/effects/woodhit.ogg'
	faction = list(FACTION_BLACKOPS)
	ai_controller = /datum/ai_controller/basic_controller/blackops
	corpse = /obj/effect/mob_spawn/corpse/human/black_ops
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert08.ogg'
	)


/mob/living/basic/blackmesa/human/blackops/ranged
	icon_state = "blackops_ranged"
	icon_living = "blackops_ranged"
	ai_controller = /datum/ai_controller/basic_controller/blackops/ranged
	attack_sound = 'sound/items/weapons/punch1.ogg'
	corpse = /obj/effect/mob_spawn/corpse/human/black_ops/ranged
	r_hand = /obj/item/gun/ballistic/automatic/sol_rifle

/mob/living/basic/blackmesa/human/blackops/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = /obj/item/ammo_casing/c40sol,\
		projectile_sound = 'sound/items/weapons/gun/rifle/shot.ogg',\
		cooldown_time = 4 SECONDS,\
		burst_shots = 3\
	)
