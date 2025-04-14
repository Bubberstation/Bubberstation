// Intended to be how mining vents work but instead of ore, at the end it spawns a chest with loot
// Implemented on Port Tarkon as standard.
/obj/structure/wave_defence
	name = "Emergency Backup Generator"
	desc = "A small, rusty looking engine used to run emergency systems. Call in a Hack-C pod to begin the reboot sequence."
	icon = 'modular_zubbers/icons/obj/machines/wavedef.dmi'
	icon_state = "emerg_engine"
	base_icon_state = "emerg_engine"
	var/excavation_warning = "This will be awfully loud. Are you ready to protect the hacking pod?"
	var/list/defending_mobs = list(/mob/living/basic/alien/drone/tarkon)
	var/static/list/scanning_equipment = list(/obj/item/hackc)
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF //This thing will take a beating.
	anchored = TRUE
	density = TRUE
	can_buckle = TRUE
	var/tapped = FALSE
	var/unique_vent = TRUE
	var/spawn_drone_on_tap = TRUE
	var/icon_state_tapped = "emerg_engine_running"
	var/mob/living/basic/node_drone/hackc/node = null //this path is a placeholder.
	var/wave_timer = WAVE_DURATION_LARGE
	COOLDOWN_DECLARE(wave_cooldown)
	COOLDOWN_DECLARE(manual_vent_cooldown)
	var/reward_key // for allowing the door key to drop
	var/reward_gun // the prize for finishing. its always a gun for now, so.
	var/difficulty_modifier = 0 // to increase the number of mobs that can spawn
	var/loot_rolls = 1 // number of times loot is rolled from your table
	var/spawn_mod = 0 // used to adjust distance that creatures can spawn

/obj/item/hackc
	name = "Hack-C repair pod signaller"
	icon = 'modular_zubbers/icons/obj/machines/wavedef_items.dmi'
	icon_state = "hackc"
	desc = "A small tool with a bunch of ones and zeros on it. The label say 'For emergency use only!'"

/mob/living/basic/node_drone/hackc
	name = "Hack-C drone"
	desc = "A lightweight version of the standard NT drones. This one has been modified for basic repairs and electrical engineering work."
	icon = 'modular_zubbers/icons/obj/machines/wavedef_items.dmi'
	icon_state = "mining_node_active"
	icon_living = "mining_node_active"
	icon_dead = "mining_node_active"

/obj/structure/wave_defence/examine(mob/user)
	. += span_notice("This can be repaired by calling in a drone with a [span_bold("Hack-C signaller")].")

/obj/structure/wave_defence/Destroy() // we dont want to affect the resource gen
	reset_drone(success = FALSE)
	return ..()

/obj/structure/wave_defence/proc/reset_drone(success)
	if(!QDELETED(node))
		node.pre_escape(success = success)
		UnregisterSignal(node, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
	node = null

/obj/structure/wave_defence/Initialize(mapload)
	register_context()

	if(tapped)
		icon_state = icon_state_tapped
		update_appearance(UPDATE_ICON_STATE)
	RegisterSignal(src, COMSIG_SPAWNER_SPAWNED_DEFAULT, PROC_REF(anti_cheese))
	return ..()

/obj/structure/ore_vent/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(is_type_in_list(held_item, scanning_equipment))
		context[SCREENTIP_CONTEXT_LMB] = "Signal hacking drone"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/wave_defence/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(.)
		return TRUE
	if(!is_type_in_list(attacking_item, scanning_equipment))
		return TRUE
	if(tapped)
		balloon_alert_to_viewers("engine repaired!")
		return TRUE
	scan_and_confirm(user)
	return TRUE

/obj/structure/wave_defence/proc/pre_wave_defense(mob/user, spawn_drone = TRUE)
	if(tgui_alert(user, excavation_warning, "Begin defending emergency engine?", list("Yes", "No")) != "Yes")
		return FALSE
	if(!can_interact(user))
		return FALSE
	if(!COOLDOWN_FINISHED(src, wave_cooldown) || node)
		return FALSE
	//This is where we start spitting out mobs.
	Shake(duration = 3 SECONDS)
	if(spawn_drone)
		node = new /mob/living/basic/node_drone/hackc(loc)
		node.arrive(src)
		RegisterSignal(node, COMSIG_QDELETING, PROC_REF(handle_wave_conclusion))
		RegisterSignal(node, COMSIG_MOVABLE_MOVED, PROC_REF(handle_wave_conclusion))
		addtimer(CALLBACK(node, TYPE_PROC_REF(/atom, update_appearance)), wave_timer * 0.25)
		addtimer(CALLBACK(node, TYPE_PROC_REF(/atom, update_appearance)), wave_timer * 0.5)
		addtimer(CALLBACK(node, TYPE_PROC_REF(/atom, update_appearance)), wave_timer * 0.75)
	add_shared_particles(/particles/smoke/ash)

	return TRUE

/obj/structure/wave_defence/proc/start_wave_defense()
	AddComponent(\
		/datum/component/spawner, \
		spawn_types = defending_mobs, \
		spawn_time = 15 SECONDS - difficulty_modifier, \
		max_spawned = 10 + difficulty_modifier, \
		max_spawn_per_attempt = 3 + difficulty_modifier + spawn_mod, \
		spawn_text = "appears to assault", \
		spawn_distance = 4 + spawn_mod, \
		spawn_distance_exclude = 2, \
	)
	COOLDOWN_START(src, wave_cooldown, wave_timer)
	addtimer(CALLBACK(src, PROC_REF(handle_wave_conclusion)), wave_timer)
	icon_state = icon_state_tapped
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/wave_defence/proc/handle_wave_conclusion(datum/source, force = FALSE)
	SIGNAL_HANDLER

	SEND_SIGNAL(src, COMSIG_VENT_WAVE_CONCLUDED)
	COOLDOWN_RESET(src, wave_cooldown)
	remove_shared_particles(/particles/smoke/ash)

	if(force)
		initiate_wave_win()
		return

	if(QDELETED(node))
		initiate_wave_loss(loss_message = "\the [src] creaks and groans as the hacking attempt fails, and the engine grinds to a halt.")
		return

	if(get_turf(node) != get_turf(src))
		initiate_wave_loss(loss_message = "The [node] detaches from the [src], and the engine seizes up!")
		return //Start over!

	initiate_wave_win()

/obj/structure/wave_defence/proc/initiate_wave_win()
	tapped = TRUE
	balloon_alert_to_viewers("engine started!")
	icon_state = icon_state_tapped
	update_appearance(UPDATE_ICON_STATE)
	qdel(GetComponent(/datum/component/gps))
	reset_drone(success = TRUE)
	reward_gun = pick_weight_recursive(GLOB.tarkon_prize_pool)
	new reward_gun(loc)
	new reward_key(loc)
	qdel(src) // so they dont just take up room

/obj/structure/wave_defence/proc/scan_and_confirm(mob/living/user)
	if(tapped)
		balloon_alert_to_viewers("engine started!")
		return
	if(!COOLDOWN_FINISHED(src, wave_cooldown) || node) //We're already defending the vent, so don't scan it again.
		return

	if(DOING_INTERACTION_WITH_TARGET(user, src))
		balloon_alert(user, "already calling!")
		return
	balloon_alert(user, "calling pod...")
	playsound(src, 'sound/items/timer.ogg', 30, TRUE)
	if(!do_after(user, 4 SECONDS, src))
		return
	balloon_alert(user, "engine started!")

	if(!pre_wave_defense(user, spawn_drone_on_tap))
		return
	start_wave_defense()

/obj/structure/wave_defence/proc/anti_cheese()
	explosion(src, heavy_impact_range = 1, light_impact_range = 3, flame_range = 0, flash_range = 0, adminlog = FALSE)

/obj/structure/wave_defence/is_buckle_possible(mob/living/target, force, check_loc)
	. = ..()
	if(tapped)
		return FALSE
	if(istype(target, /mob/living/basic/node_drone/hackc))
		return TRUE

/obj/structure/wave_defence/proc/initiate_wave_loss(loss_message)
	visible_message(span_danger(loss_message))
	icon_state = base_icon_state
	update_appearance(UPDATE_ICON_STATE)
	reset_drone(success = FALSE)

/obj/structure/wave_defence/tarkon/rnd
	reward_key = /obj/item/keycard/tarkon_rnd

/obj/structure/wave_defence/tarkon/engi
	reward_key = /obj/item/keycard/tarkon_engi
	spawn_mod = 1

/obj/structure/wave_defence/tarkon/med
	reward_key = /obj/item/keycard/tarkon_med

/obj/structure/wave_defence/tarkon/boss
	reward_key = /obj/item/keycard/tarkon_vault
	difficulty_modifier = 2

/obj/structure/wave_defence/tarkon/boss/initiate_wave_win()
	reward_gun = pick_weight_recursive(GLOB.tarkon_prize_pool)
	new reward_gun(loc)
	reward_gun = pick_weight_recursive(GLOB.tarkon_prize_pool)
	new reward_gun(loc)
	return ..()
