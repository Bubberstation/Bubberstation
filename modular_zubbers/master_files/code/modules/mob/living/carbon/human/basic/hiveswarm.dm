#define DOAFTER_HARVESTER "harvester_interaction"
#define DOAFTER_CHAFF "chaff_interaction"

/mob/living/basic/hiveswarm
	name = "hiveswarm"
	desc = "The base hiveswarm to rip apart your station"
	icon = 'modular_zubbers/icons/mob/hivebots.dmi'
	var/obj/structure/bubber_hivebot_beacon/our_beacon
	basic_mob_flags = DEL_ON_DEATH
	faction = list(FACTION_HIVESWARM)
	melee_damage_type = BRUTE
	wound_bonus = 10
	melee_damage_upper = 1
	melee_damage_lower = 1
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, STAMINA = 0, OXY = 0)
	unsuitable_atmos_damage = 0
	ai_controller = /datum/ai_controller/basic_controller/hiveswarm

/mob/living/basic/hiveswarm/Initialize()
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/simple_flying)
	var/list/death_loot = string_list(list(/obj/effect/gibspawner/robot))
	AddElement(/datum/element/death_drops, death_loot)

/mob/living/basic/hiveswarm/Destroy()
	our_beacon = null
	return ..()

/mob/living/basic/hiveswarm/harvester
	name = "hiveswarm harvester"
	desc = "It almost looks cheerful while ripping your station apart"
	icon_state = "hivebotharvester"
	maxHealth = 300
	health = 300
	ai_controller = /datum/ai_controller/basic_controller/hiveswarm/harvester
	var/laser_attack = /datum/action/cooldown/mob_cooldown/projectile_attack/harvester_laser

/mob/living/basic/hiveswarm/harvester/Initialize()
	. = ..()
	var/datum/action/cooldown/mob_cooldown/projectile_attack/harvester_laser/laser = new laser_attack(src)
	laser.Grant(src)
	ai_controller.set_blackboard_key(BB_HIVESWARM_LASER_ABILITY, laser)
	AddElement(/datum/element/wall_tearer, allow_reinforced = TRUE, tear_time = 5 SECONDS, reinforced_multiplier = 3, do_after_key = DOAFTER_HARVESTER)

/datum/action/cooldown/mob_cooldown/projectile_attack/harvester_laser
	name = "Main Laser"
	desc = "Shoot a laser at a target"
	button_icon = 'icons/obj/weapons/guns/projectiles.dmi'
	button_icon_state = "green_laser"
	cooldown_time = 3 SECONDS
	projectile_type = /obj/projectile/beam/emitter/hitscan/harvester
	projectile_sound = 'sound/items/weapons/laser.ogg'
	unset_after_click = FALSE

/mob/living/basic/hiveswarm/basic
	name = "hiveswarm chaff"
	desc = "A very basic looking robot filled with blades"
	icon_state = "hivebot"
	maxHealth = 30
	health = 30
	speed = 0.7
	sharpness = SHARP_EDGED
	melee_damage_upper = 15
	melee_damage_lower = 15
	armour_penetration = 20
	ai_controller = /datum/ai_controller/basic_controller/hiveswarm/basic

/mob/living/basic/hiveswarm/basic/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_preattack))

/mob/living/basic/hiveswarm/basic/Destroy()
	UnregisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET)
	return ..()

/mob/living/basic/hiveswarm/basic/proc/on_preattack(mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	if (target == src)
		return COMPONENT_HOSTILE_NO_ATTACK

	if (DOING_INTERACTION(source, DOAFTER_CHAFF))
		balloon_alert(source, "busy!")
		return COMPONENT_HOSTILE_NO_ATTACK

	if(istype(target, /obj/item))
		INVOKE_ASYNC(src, PROC_REF(consume_materials), target)
	var/mob/living/living_target = target
	if(!istype(living_target))
		return COMPONENT_HOSTILE_NO_ATTACK
	if (living_target.stat != DEAD)
		return
	return COMPONENT_HOSTILE_NO_ATTACK

// Move logic to basic AI controller

/mob/living/basic/hiveswarm/basic/proc/consume_materials(target)
	var/obj/item/item = target
	if(isnull(item.custom_materials))
		balloon_alert(src, "can't convert!")
		return
	if(do_after(src, 1 SECONDS, item))
		var/list/materials = item.get_material_composition()
		var/amount = 0
		for(var/material_key in materials)
			amount += materials[material_key]
		var/datum/storage/storage_thing = item.atom_storage
		storage_thing?.remove_all(item.loc)

		our_beacon?.material_storage += amount
		apply_wibbly_filters(item)
		animate(item, 3 SECONDS, easing = CIRCULAR_EASING|EASE_OUT, alpha = 0, color = "#00e1ff")
		QDEL_IN(item, 3 SECONDS)

/mob/living/basic/hiveswarm/bomber
	name = "hiveswarm bomber"
	desc = "An awkwardly floating robot. It has a fucking bomb on it."
	icon_state = "hivebotbomber"
	maxHealth = 20
	health = 20
	ai_controller = /datum/ai_controller/basic_controller/hiveswarm/bomber
	var/explode_attack = /datum/action/cooldown/mob_cooldown/bomber_explode
	var/obj/item/ammo_casing/hivebomber/shrapnel

/mob/living/basic/hiveswarm/bomber/Initialize()
	. = ..()
	var/datum/action/cooldown/mob_cooldown/bomber_explode/explode = new explode_attack(src)
	explode.Grant(src)
	ai_controller.set_blackboard_key(BB_HIVESWARM_BOMB_ABILITY, explode)

/datum/action/cooldown/mob_cooldown/bomber_explode
	name = "Explode"
	desc = "Detonate our bomb"
	button_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "frag"
	var/exploded = FALSE

/datum/action/cooldown/mob_cooldown/bomber_explode/PreActivate(atom/target)
	var/mob/living/bomb = owner
	if(!istype(bomb))
		return FALSE
	owner.add_filter("detonating_glow", 2, list("type" = "outline", "color" = "#ff0000ff", "size" = 2))
	owner.light_range = 2
	owner.light_color = "#ff0000ff"
	owner.balloon_alert_to_viewers("DETONATING", "DETONATING", world.view)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/nerfed_bump)
	return ..()

/datum/action/cooldown/mob_cooldown/bomber_explode/Activate(atom/target)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(detonate), target), 3 SECONDS)

/datum/action/cooldown/mob_cooldown/bomber_explode/proc/detonate(atom/target)
	var/mob/living/bomb = owner
	if(exploded)
		return

	var/obj/item/ammo_casing/hivebomber/shrapnel = new /obj/item/ammo_casing/hivebomber(bomb)
	var/explosion_angle = get_angle(bomb, target)
	exploded = TRUE
	shrapnel.fire_casing(target, bomb, null, 0, 0, null, 0, bomb)
	explosion(owner, 0, 1, 4, 0, 6, FALSE, protect_epicenter = TRUE, explosion_direction = explosion_angle, explosion_arc = 60)
	bomb.death()

/mob/living/basic/hiveswarm/guardian //beefcake
	name = "hiveswarm guardian"
	desc = "A larger, tankier robot"
	icon_state = "hivebotguardian"
	maxHealth = 200
	health = 200
	speed = 2
	armour_penetration = 30
	melee_damage_upper = 25
	melee_damage_lower = 25

/mob/living/basic/hiveswarm/ranged
	name = "hiveswarm gunner"
	desc = "Ouch, what the hell was that? A metal spike?"
	icon_state = "hivebotranged"
	maxHealth = 50
	health = 50
	ai_controller = /datum/ai_controller/basic_controller/hiveswarm/ranged

/mob/living/basic/hiveswarm/ranged/Initialize()
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		cooldown_time = 5 SECONDS,\
		projectile_type = /obj/projectile/bullet/needle,\
		projectile_sound = 'sound/items/weapons/gun/smg/shot_suppressed.ogg',\
		burst_shots = 3,\
	)

/mob/living/basic/hiveswarm/proc/beacon_death()
	SIGNAL_HANDLER
	our_beacon = null
