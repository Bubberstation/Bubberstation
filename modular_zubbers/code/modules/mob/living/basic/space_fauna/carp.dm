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
	health = 450
	maxHealth = 450

	//current living carp
	var/mob/living/basic/carp/mycarp
	var/time_between_carp_spawns = 10 SECONDS

	var/is_anomaly_containable = FALSE
	var/anomaly_destabilize_threshhold = 0.5
	var/obj/item/assembly/signaler/anomaly/anomaly_type = /obj/item/assembly/signaler/anomaly/dimension

/mob/living/basic/carp/metacarp/Initialize(mapload)
	.  ..()
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
	if(is_anomaly_containable && istype(attacking_item, /obj/item/anomaly_neutralizer/))
		anomaly_stabilize()
	if(!is_anomaly_containable && health <= maxHealth * anomaly_destabilize_threshhold)
		is_anomaly_containable = TRUE
		balloon_alert_to_viewers("destabilized!")
		Shake(3, 3, 5 SECONDS)

/mob/living/basic/carp/metacarp/proc/anomaly_stabilize()

	if (SSresearch.is_core_available(anomaly_type))
		SSresearch.increment_existing_anomaly_cores(anomaly_type)
		anomaly_core.forceMove(drop_location())
		anomaly_core = null
	else // You exceeded the cap sorry
		visible_message(span_warning("[anomaly_core] loses its lustre as it falls to the ground, there is too little ambient energy to support another core of this type."))
		new /obj/item/inert_anomaly(drop_location())
