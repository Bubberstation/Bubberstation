/obj/structure/bubber_hivebot_beacon
	name = "hivebot beacon"
	desc = "The central beacon for the things ripping apart your station."
	icon = 'modular_zubbers/icons/obj/structures/hivebot_beacon.dmi'
	icon_state = "hivebotbeacon_off"
	max_integrity = 3000
	anchored = TRUE
	// Our harvesters
	var/list/harvesters = list()
	// Our defenses
	var/list/hivebots = list()
	// Our material storage
	var/material_storage = 0
	COOLDOWN_DECLARE(hivebot_creation)
	COOLDOWN_DECLARE(shoot_laser)
	var/faction_types = list(FACTION_HIVESWARM)
	var/static/list/spawn_list = list(
							/mob/living/basic/hiveswarm/bomber = 1,
							/mob/living/basic/hiveswarm/basic = 3,
							/mob/living/basic/hiveswarm/guardian = 2,
							/mob/living/basic/hiveswarm/ranged = 1
						)

/obj/structure/bubber_hivebot_beacon/Initialize()
	. = ..()
	if(QDELETED(src))
		return
	addtimer(CALLBACK(src, PROC_REF(startUp)), 10 SECONDS)

/obj/structure/bubber_hivebot_beacon/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	priority_announce("The hivebot beacon has been succesfully deactivated after catastrophic failure")
	harvesters = null
	hivebots = null
	return ..()

/obj/structure/bubber_hivebot_beacon/atom_break()
	explosion(src, 1, 3, 4, 5, 7)
	return ..()

/obj/structure/bubber_hivebot_beacon/process()
	if(COOLDOWN_FINISHED(src, shoot_laser))
		var/list/targets = list()
		for(var/mob/living/target in view(5, src))
			if(faction_check(target.faction, faction_types))
				continue
			if(target.stat != CONSCIOUS)
				continue
			targets += target

		if(LAZYLEN(targets))
			var/mob/living/mob_to_shoot = pick(targets)
			fire_laser(mob_to_shoot)

		COOLDOWN_START(src, shoot_laser, 6 SECONDS)

	if(LAZYLEN(harvesters) < 1 && material_storage < 100) // Always have a harvester
		create_mob(/mob/living/basic/hiveswarm/harvester, 0, 30 SECONDS)
		return

	if(LAZYLEN(hivebots) <= 20)
		var/mob_to_choose = pick_weight(spawn_list)
		create_mob(mob_to_choose, 100, 10 SECONDS)
		return

/obj/structure/bubber_hivebot_beacon/proc/startUp()
	flick("hivebotbeacon_raising", src)
	icon_state = "hivebotbeacon_active"
	update_icon()
	COOLDOWN_START(src, hivebot_creation, 3 SECONDS) // Small pause before we start shitting out robots
	START_PROCESSING(SSfastprocess, src)
	addtimer(CALLBACK(src, PROC_REF(announcement)), 3 MINUTES)
	for(var/i = 1 to 3) // Spawn some inital chaff
		create_mob(/mob/living/basic/hiveswarm/basic, 0, null)


/obj/structure/bubber_hivebot_beacon/proc/announcement()
	if(QDELETED(src))
		return
	priority_announce("Rouge hiveswarm signal detected operating on your station.", "Hiveswarm Intrusion Detection")

/obj/structure/bubber_hivebot_beacon/proc/create_mob(mob/to_spawn, material_price, cooldown)
	var/price = material_price
	if(!COOLDOWN_FINISHED(src, hivebot_creation) && !isnull(cooldown))
		return FALSE
	if (material_storage >= price)
		var/mob/living/basic/hiveswarm/new_mob = new to_spawn(get_turf(src))
		new_mob.our_beacon = src

		if(istype(new_mob, /mob/living/basic/hiveswarm/harvester))
			harvesters += new_mob
		else
			hivebots += new_mob

		material_storage -= price
		RegisterSignal(new_mob, COMSIG_QDELETING, PROC_REF(mob_death))
		new_mob.RegisterSignal(src, COMSIG_QDELETING, TYPE_PROC_REF(/mob/living/basic/hiveswarm, beacon_death))
		if(!isnull(cooldown))
			COOLDOWN_START(src, hivebot_creation, cooldown)
		return TRUE
	return FALSE

/obj/structure/bubber_hivebot_beacon/proc/mob_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER

	var/mob/living/basic/dead = dead_guy
	if(istype(dead, /mob/living/basic/hiveswarm/harvester))
		harvesters -= dead
	else
		hivebots -= dead

/obj/structure/bubber_hivebot_beacon/proc/fire_laser(mob/target)
	if(!target)
		return
	var/obj/projectile/new_laser = new /obj/projectile/beam/emitter/hitscan
	var/turf/our_turf = get_turf(src)
	playsound(loc, 'sound/items/weapons/laser.ogg', 50, TRUE)
	new_laser.preparePixelProjectile(target, our_turf)
	new_laser.firer = src
	new_laser.fired_from = src
	new_laser.ignored_factions = faction_types
	new_laser.fire()

/obj/effect/abstract/hivebot_drop_target
	name = "suspicious landing zone"
	desc = "Something is coming..."
	icon = 'icons/mob/telegraphing/telegraph_holographic.dmi'
	icon_state = "target_circle"
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	light_range = 3
	light_color = "#f70000"

/obj/effect/abstract/hivebot_drop_target/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(summon_the_bots)), 20 SECONDS)
	deadchat_broadcast("A Hivebot beacon has latched onto the station!", turf_target = get_turf(src), message_type=DEADCHAT_ANNOUNCEMENT)

/obj/effect/abstract/hivebot_drop_target/proc/summon_the_bots()

	podspawn(list(
		"target" = get_turf(src),
		"style" = /datum/pod_style/seethrough,
		"delays" = list(POD_TRANSIT = 0, POD_FALLING = (5 SECONDS), POD_OPENING = 0, POD_LEAVING = 0),
		"spawn" = /obj/structure/bubber_hivebot_beacon,
		"damage" = 30,
		"explosionSize" = list(0, 0, 2, 2)
	))

	qdel(src)




