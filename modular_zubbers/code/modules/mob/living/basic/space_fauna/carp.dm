/mob/living/basic/carp
	health = 50
	maxHealth = 50

/mob/living/basic/carp/advanced
	health = 100
	maxHealth = 100

/mob/living/basic/carp/mega/Initialize(mapload)
	. = ..()
	maxHealth += rand(15, 40)

/mob/living/basic/carp/mega/queen
	name = "Royal Space Carp"
	desc = "A ferocious, fang bearing creature that resembles a shark. The scales visibly gleam in the pale light. Sure looks tough."
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 25

/mob/living/basic/carp/metacarp
	name = "Metacarp"
	desc = "A carp-shaped portal to the carp-filled dimension."
	icon = 'modular_zubbers/icons/mob/simple/carp.dmi'
	icon_state = "metacarp"
	health = 450
	maxHealth = 450
	basic_mob_flags = parent_type::basic_mob_flags | DEL_ON_DEATH
	//current living carp
	var/mob/living/basic/carp/mycarp
	var/time_between_carp_spawns = 10 SECONDS
	var/carp_spawn_on_violent_death = 3

	var/is_anomaly_containable = FALSE
	var/anomaly_destabilize_threshhold = 0.5
	var/anomaly_type = /obj/item/assembly/signaler/anomaly/dimensional

/mob/living/basic/carp/metacarp/Initialize(mapload)
	. = ..()
	spawn_carp_after_delay()

/mob/living/basic/carp/metacarp/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	spawn_carp_after_delay()
	is_anomaly_containable = FALSE

/// Metacarp regularly spawn lesser carp while alive
/mob/living/basic/carp/metacarp/proc/spawn_carp_after_delay()
	if(!isnull(mycarp))
		UnregisterSignal(mycarp, COMSIG_LIVING_DEATH)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/basic/carp/metacarp, spawn_carp)), time_between_carp_spawns)
/mob/living/basic/carp/metacarp/proc/spawn_carp()
	mycarp = new(get_turf(src))
	RegisterSignal(mycarp, COMSIG_LIVING_DEATH, PROC_REF(spawn_carp_after_delay))

/// Metacarp can be killed at <= 50% HP via anomaly stabilizer
/mob/living/basic/carp/metacarp/apply_damage(
	damage = 0,
	damagetype = BRUTE,
	def_zone = null,
	blocked = 0,
	forced = FALSE,
	spread_damage = FALSE,
	wound_bonus = 0,
	exposed_wound_bonus = 0,
	sharpness = NONE,
	attack_direction = null,
	attacking_item,
	wound_clothing = TRUE,
)
	. = ..()
	if(!is_anomaly_containable && health <= maxHealth * anomaly_destabilize_threshhold)
		is_anomaly_containable = TRUE
		balloon_alert_to_viewers("destabilized!")
		Shake(3, 3, 20 SECONDS)
	else if(is_anomaly_containable && istype(attacking_item, /obj/item/anomaly_neutralizer/))
		anomaly_stabilize()
		qdel(attacking_item)

/mob/living/basic/carp/metacarp/proc/anomaly_stabilize()
	new /obj/effect/particle_effect/fluid/smoke/bad(loc)
	if (SSresearch.is_core_available(anomaly_type))
		SSresearch.increment_existing_anomaly_cores(anomaly_type)
		new anomaly_type(get_turf(src))
	else // You exceeded the cap sorry
		visible_message(span_warning("The anomaly core loses its lustre as it falls to the ground, there is too little ambient energy to support another core of this type."))
		new /obj/item/inert_anomaly(get_turf(src))
	qdel(src)

/mob/living/basic/carp/metacarp/death(gibbed)
	for(var/i = 0; i < carp_spawn_on_violent_death; i ++)
		mycarp = new(loc)
	do_sparks(3)
	playsound(get_turf(src),'sound/effects/magic/repulse.ogg', 100, TRUE)
	. = ..()
