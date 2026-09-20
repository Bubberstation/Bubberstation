#define SLAM_JAM_DELAY (15 SECONDS)
/// How long a thumper rides out a power shortage before it stalls
#define THUMPER_POWER_GRACE (10 SECONDS)

#define THUMPER_STALL_LOCATION "invalid location"
#define THUMPER_STALL_NO_WIRE "no wire connection"
#define THUMPER_STALL_POWER "not enough power"
#define THUMPER_STALL_ORE "nearby ore too saturated"
#define THUMPER_STALL_NEIGHBOR "too close to another thumper"

/// How far either side of normal cadence counts as running level, rather than braking or overclocking
#define THUMPER_SYNC_DEADZONE 0.02

/// The most a thumper will speed up or slow down while it matches the others
#define THUMPER_SYNC_MAX_SHIFT 0.5
/// How hard a thumper pulls towards the shared rhythm
#define THUMPER_SYNC_GAIN 6
/// Percent chance, per box of materials, that a thumper's fracking sets off an earthquake
#define THUMPER_QUAKE_CHANCE 0.1
/// No thumper can set off another quake until this long after the last one
#define THUMPER_QUAKE_COOLDOWN (30 MINUTES)

/// How many segments the payload bar on the base is split into
#define THUMPER_LOAD_SEGMENTS 4

/// Thumpers spaced perfectly evenly around the cycle average out to nothing, so below this we leave them alone
#define THUMPER_SYNC_MIN_AGREEMENT 0.02

/// What each stall reads as on examine, since the balloon alerts have to stay short
GLOBAL_LIST_INIT(thumper_stall_descriptions, list(
	THUMPER_STALL_LOCATION = "unsuitable terrain",
	THUMPER_STALL_NO_WIRE = "a missing wire connection",
	THUMPER_STALL_POWER = "insufficient power",
	THUMPER_STALL_ORE = "ore saturation around it",
	THUMPER_STALL_NEIGHBOR = "another thumper within its clearance",
))

/// Every thumper that is running right now, so they can match each other's rhythm
GLOBAL_LIST_EMPTY(working_ore_thumpers)
/// When the next thumper-caused earthquake is allowed, shared by every thumper
GLOBAL_VAR_INIT(next_thumper_quake, 0)

/obj/machinery/power/colony_ore_thumper
	name = "ore thumper"
	desc = "A frame with a heavy block of metal suspended atop a pipe. Must be deployed outdoors and given a \
		wired power connection. Forces pressurized gas deep into the ground, driving buried ore to the surface. \
		Resonance with the surrounding bedrock is critical to the device's operation. Nearby ore thumpers couple \
		through their seismic pulses, aggressively advancing or retarding their cadence until their drive cycles \
		fall into phase."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/ore_thumper.dmi'
	icon_state = "thumper_idle"
	density = TRUE
	max_integrity = 250
	idle_power_usage = 0
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 50 // Should be 50 kw or an entire SOFIE generator's power production
	anchored = TRUE
	can_change_cable_layer = FALSE
	circuit = null
	layer = ABOVE_MOB_LAYER
	/// Has somebody switched us on? We can be on and still be stalled
	var/switched_on = FALSE
	/// Why we can't work right now, one of the THUMPER_STALL defines. Null when we are working normally
	var/stall_reason
	/// How much of a power shortage we can still ride out before we stall
	var/power_grace_remaining = THUMPER_POWER_GRACE
	/// How much working time we have built up towards the next slam
	var/slam_progress = 0
	/// Our looping fan sound that we play when turned on
	var/datum/looping_sound/ore_thumper_fan/soundloop
	/// How many times we've slammed, counts up until the number is high enough to make a box of materials
	var/slam_jams = 0
	/// How many times we need to slam in order to produce a box of materials
	var/slam_jams_needed = 30
	/// List of the thumping sounds we can choose from
	var/static/list/list_of_thumper_sounds = list(
		'modular_skyrat/modules/kahraman_equipment/sound/thumper_thump/punch_press_1.wav',
		'modular_skyrat/modules/kahraman_equipment/sound/thumper_thump/punch_press_2.wav',
	)
	/// Weighted list of the ores we can spawn
	var/static/list/ore_weight_list = list(
		/obj/item/stack/ore/iron = 5,
		/obj/item/stack/ore/glass/basalt = 5,
		/obj/item/stack/ore/plasma = 4,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/silver = 3,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/titanium = 3,
		/obj/item/stack/ore/diamond = 2,
		/obj/item/stack/ore/bluespace_crystal = 1,
	)
	/// How much of the listed types of ores should we spawn when spawning ore
	var/static/list/ore_spawn_values = list(
		/obj/item/stack/ore/iron = 25,
		/obj/item/stack/ore/glass/basalt = 25,
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/bluespace_crystal = 1,
	)
	/// What's the limit for ore near us? Counts by stacks, not individual amounts of ore
	var/nearby_ore_limit = 5
	/// How far away does ore spawn?
	var/ore_spawn_range = 2
	/// How many clear tiles we need between us and the next thumper
	var/minimum_thumper_clearance = 2
	/// What do we undeploy into
	var/undeploy_type = /obj/item/flatpacked_machine/ore_thumper
	/// Do we try to match our rhythm to the other thumpers around us?
	var/syncs_with_others = TRUE
	/// What our cadence was last multiplied by to match the other thumpers
	var/sync_multiplier = 1

/obj/machinery/power/colony_ore_thumper/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	register_context()
	AddElement(/datum/element/repackable, undeploy_type, 4 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/colony_ore_thumper/Destroy()
	GLOB.working_ore_thumpers -= src
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/power/colony_ore_thumper/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/user,
)
	if(!isnull(held_item))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = switched_on ? "Switch Off" : "Switch On"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/power/colony_ore_thumper/examine(mob/user)
	. = ..()
	var/area/thumper_area = get_area(src)
	if(!thumper_area.outdoors)
		. += span_notice("It must be constructed <b>outdoors</b> to function.")
	if(!ismiscturf(get_turf(src)))
		. += span_notice("It must be constructed on <b>suitable terrain</b>, like ash, snow, or sand.")
	. += span_notice("It must have a powered, <b>wired connection</b> running beneath it with <b>[active_power_usage / BASE_MACHINE_ACTIVE_CONSUMPTION] kW</b> of excess power to function.")
	. += span_notice("It will produce a box of materials after it has slammed [slam_jams_needed] times.")
	var/cadence_note = ""
	if(switched_on && !stall_reason && sync_multiplier > 1 + THUMPER_SYNC_DEADZONE)
		cadence_note = "; it is operating at an <i>accelerated</i> rate to synchronize with other thumpers"
	else if(switched_on && !stall_reason && sync_multiplier < 1 - THUMPER_SYNC_DEADZONE)
		cadence_note = "; it is operating at a <i>reduced</i> rate to synchronize with other thumpers"
	. += span_notice("Currently, it has slammed [slam_jams] / [slam_jams_needed] times needed[cadence_note].")
	. += span_notice("It will pause operation if there are <b>too many piles of ore</b> near it, and resume once they are cleared.")
	. += span_notice("The thumper cannot operate <b>too close to another thumper</b>; it requires at least <b>[minimum_thumper_clearance] spaces</b> of clearance.")
	. += span_notice("It will adjust its cadence to <b>synchronize</b> with nearby ore thumpers.")
	. += span_notice("Its status lamp glows <b>green</b> when operating normally, flashes <b>yellow</b> when ready to operate but prevented by external conditions, flashes <b>red</b> when it cannot work where it stands, and glows <b>red</b> when switched off.")
	if(switched_on && stall_reason == THUMPER_STALL_LOCATION)
		. += span_warning("It has stopped: <b>it cannot operate on this terrain and must be redeployed</b>.")
	else if(switched_on && stall_reason)
		. += span_warning("It has stopped due to <b>[GLOB.thumper_stall_descriptions[stall_reason] || stall_reason]</b>. It will resume operation if the issue is resolved.")

/obj/machinery/power/colony_ore_thumper/update_overlays()
	. = ..()
	var/lamp_state = "thumper_light_green"
	if(!switched_on)
		lamp_state = "thumper_light_red"
	else if(stall_reason == THUMPER_STALL_LOCATION)
		// nothing it can do about the ground under it, so this one reads as dead rather than waiting
		lamp_state = "thumper_light_red_flash"
	else if(stall_reason)
		lamp_state = "thumper_light_yellow"
	. += mutable_appearance(icon, lamp_state)
	. += emissive_appearance(icon, lamp_state, src)

	if(!switched_on || stall_reason)
		return
	var/load_state = "thumper_load[get_load_level()]"
	if(slam_jams >= slam_jams_needed - 2)
		load_state = "thumper_load_flash"
	. += mutable_appearance(icon, load_state)
	. += emissive_appearance(icon, load_state, src)

/// Which bar segment we are working on, 1 to THUMPER_LOAD_SEGMENTS. The first segment lights as soon as we start
/obj/machinery/power/colony_ore_thumper/proc/get_load_level()
	return clamp(round((slam_jams / slam_jams_needed) * THUMPER_LOAD_SEGMENTS) + 1, 1, THUMPER_LOAD_SEGMENTS)

/obj/machinery/power/colony_ore_thumper/process(seconds_per_tick)
	update_network_connection()
	if(!switched_on)
		return

	var/power_problem = get_power_problem()
	if(power_problem)
		power_grace_remaining -= seconds_per_tick SECONDS
		if(power_grace_remaining <= 0)
			set_stall_reason(power_problem)
		return
	power_grace_remaining = THUMPER_POWER_GRACE

	var/work_blocker = get_work_blocker()
	set_stall_reason(work_blocker)
	if(work_blocker)
		return

	add_load(power_to_energy(active_power_usage))
	sync_multiplier = get_sync_multiplier()
	slam_progress += (seconds_per_tick SECONDS) * sync_multiplier
	if(slam_progress < SLAM_JAM_DELAY)
		return
	slam_progress -= SLAM_JAM_DELAY
	slam_it_down()

/// How far through a full box of materials we are, as an angle so the cycle wraps cleanly
/obj/machinery/power/colony_ore_thumper/proc/get_cycle_angle()
	var/cycles_done = slam_jams + (slam_progress / SLAM_JAM_DELAY)
	return SIMPLIFY_DEGREES((cycles_done / slam_jams_needed) * 360)

/// What our slam timing is multiplied by this tick so we drift towards the shared rhythm
/obj/machinery/power/colony_ore_thumper/proc/get_sync_multiplier()
	if(!syncs_with_others)
		return 1
	var/static/list/shared_rhythms
	var/static/rhythms_calculated_at
	if(rhythms_calculated_at != world.time)
		rhythms_calculated_at = world.time
		shared_rhythms = build_thumper_rhythms()
	var/shared_angle = shared_rhythms[get_sync_group()]
	if(isnull(shared_angle))
		return 1
	var/angle_to_cover = closer_angle_difference(get_cycle_angle(), shared_angle)
	return 1 + clamp((angle_to_cover / 360) * THUMPER_SYNC_GAIN, -THUMPER_SYNC_MAX_SHIFT, THUMPER_SYNC_MAX_SHIFT)

/// Thumpers only match thumpers on the same z level running the same length of cycle
/obj/machinery/power/colony_ore_thumper/proc/get_sync_group()
	var/turf/our_turf = get_turf(src)
	var/our_z = our_turf ? our_turf.z : 0
	return "[our_z]-[slam_jams_needed]"

/// Averages every running thumper's place in its cycle, once a tick for all of them
/obj/machinery/power/colony_ore_thumper/proc/build_thumper_rhythms()
	var/list/sines = list()
	var/list/cosines = list()
	var/list/counts = list()
	for(var/obj/machinery/power/colony_ore_thumper/thumper as anything in GLOB.working_ore_thumpers)
		if(!thumper.syncs_with_others)
			continue
		var/group = thumper.get_sync_group()
		var/angle = thumper.get_cycle_angle()
		sines[group] += sin(angle)
		cosines[group] += cos(angle)
		counts[group] += 1

	var/list/rhythms = list()
	for(var/group in counts)
		var/count = counts[group]
		if(count < 2)
			continue
		var/average_sine = sines[group] / count
		var/average_cosine = cosines[group] / count
		// a perfectly even spread averages out to no direction at all, so nobody moves
		if(sqrt((average_sine * average_sine) + (average_cosine * average_cosine)) < THUMPER_SYNC_MIN_AGREEMENT)
			continue
		rhythms[group] = delta_to_angle(average_sine, average_cosine)
	return rhythms

/// Keeps us attached to the powernet only while there is a cable under us
/obj/machinery/power/colony_ore_thumper/proc/update_network_connection()
	if(!(locate(/obj/structure/cable) in get_turf(src)))
		disconnect_from_network()
		return
	if(!powernet)
		connect_to_network()

/// Returns why we have no usable power right now, or null if we have enough
/obj/machinery/power/colony_ore_thumper/proc/get_power_problem()
	if(!powernet)
		return THUMPER_STALL_NO_WIRE
	if(surplus() < power_to_energy(active_power_usage))
		return THUMPER_STALL_POWER
	return null

/// Returns why we can't work even though we have power, or null if we are clear to slam
/obj/machinery/power/colony_ore_thumper/proc/get_work_blocker()
	var/area/our_area = get_area(src)
	if(!our_area.outdoors || !ismiscturf(get_turf(src)))
		return THUMPER_STALL_LOCATION
	if(has_thumper_neighbor())
		return THUMPER_STALL_NEIGHBOR
	// we only need clear ground for the slam that finishes a box
	if(slam_jams + 1 < slam_jams_needed)
		return null
	return get_output_blocker()

/// Is another thumper standing inside our clearance? We skip ourselves by identity rather than trusting the range proc
/obj/machinery/power/colony_ore_thumper/proc/has_thumper_neighbor()
	for(var/obj/machinery/power/colony_ore_thumper/other_thumper in range(minimum_thumper_clearance, src))
		if(other_thumper == src)
			continue
		return TRUE
	return FALSE

/// Returns why we have no room to make a box of materials, or null if there is room
/obj/machinery/power/colony_ore_thumper/proc/get_output_blocker()
	var/nearby_ore = 0
	for(var/turf/nearby_turf in orange(ore_spawn_range, src))
		for(var/obj/item/stack/ore/ore_pile in nearby_turf)
			nearby_ore++
	if(nearby_ore > nearby_ore_limit)
		return THUMPER_STALL_ORE
	return null

/// Stops or restarts our work when the reason we can't work changes
/obj/machinery/power/colony_ore_thumper/proc/set_stall_reason(new_reason)
	if(stall_reason == new_reason)
		return
	stall_reason = new_reason
	if(stall_reason)
		GLOB.working_ore_thumpers -= src
		soundloop.stop()
		balloon_alert_to_viewers(stall_reason)
		Shake(2, 2, 2 SECONDS)
	else
		GLOB.working_ore_thumpers |= src
		soundloop.start()
		balloon_alert_to_viewers("resuming")
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/colony_ore_thumper/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(switched_on)
		cut_that_out(user)
		return
	start_her_up(user)


/obj/machinery/power/colony_ore_thumper/attack_ai(mob/user)
	return attack_hand(user)


/obj/machinery/power/colony_ore_thumper/attack_robot(mob/user)
	return attack_hand(user)


/// Switches the thumper on. If something is wrong it waits and starts by itself when that is fixed
/obj/machinery/power/colony_ore_thumper/proc/start_her_up(mob/user)
	switched_on = TRUE
	power_grace_remaining = THUMPER_POWER_GRACE
	var/start_problem = get_power_problem() || get_work_blocker()
	if(start_problem)
		set_stall_reason(start_problem)
	else
		GLOB.working_ore_thumpers |= src
		soundloop.start()
		balloon_alert(user, "thumper started")
	update_appearance(UPDATE_OVERLAYS)


/// Switches the thumper off
/obj/machinery/power/colony_ore_thumper/proc/cut_that_out(mob/user)
	switched_on = FALSE
	stall_reason = null
	GLOB.working_ore_thumpers -= src
	soundloop.stop()
	if(user)
		balloon_alert(user, "thumper stopped")
	update_appearance(UPDATE_OVERLAYS)


/// Makes the machine slam down, producing a box of ore if it has been slamming long enough
/obj/machinery/power/colony_ore_thumper/proc/slam_it_down()
	flick("thumper_slam", src)
	playsound(src, pick(list_of_thumper_sounds), 80, TRUE)
	var/previous_load_level = get_load_level()
	slam_jams++
	if(get_load_level() != previous_load_level)
		update_appearance(UPDATE_OVERLAYS)
	if(slam_jams < slam_jams_needed)
		return
	slam_jams -= slam_jams_needed
	update_appearance(UPDATE_OVERLAYS)
	try_to_cause_earthquake()
	addtimer(CALLBACK(src, PROC_REF(make_some_ore)), 3 SECONDS, TIMER_DELETE_ME)


/// Fracking has consequences. Every box of materials is a small roll for an earthquake centered on us
/obj/machinery/power/colony_ore_thumper/proc/try_to_cause_earthquake()
	if(!prob(THUMPER_QUAKE_CHANCE))
		return
	if(world.time < GLOB.next_thumper_quake)
		return
	if(!SSmapping.is_planetary())
		return
	var/datum/round_event_control/earthquake/quake = locate() in SSevents.control
	if(isnull(quake) || !quake.can_spawn_event(get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)))
		return

	GLOB.next_thumper_quake = world.time + THUMPER_QUAKE_COOLDOWN
	quake.run_event(event_cause = "ore thumper fracking")

/// Spawns some ore piles around the thumper
/obj/machinery/power/colony_ore_thumper/proc/make_some_ore()
	var/list/nearby_valid_turfs = list()
	for(var/turf/nearby_turf in orange(ore_spawn_range, src))
		if(nearby_turf.is_blocked_turf(TRUE))
			continue
		if(!ismiscturf(nearby_turf))
			continue
		nearby_valid_turfs.Add(nearby_turf)
	// Fallback in case somehow there are no valid nearby turfs
	if(!length(nearby_valid_turfs))
		nearby_valid_turfs.Add(get_turf(src))

	for(var/iteration in 1 to rand(2, 4))
		var/turf/target_turf = pick(nearby_valid_turfs)
		var/obj/item/stack/ore/ore_type = pick_weight(ore_weight_list)
		var/obj/new_ore_pile = new ore_type(target_turf, ore_spawn_values[ore_type])
		new /obj/effect/temp_visual/mook_dust/robot(target_turf)
		playsound(new_ore_pile, 'modular_skyrat/master_files/sound/effects/robot_sit.ogg', 25, TRUE)


// Item for deploying ore thumpers
/obj/item/flatpacked_machine/ore_thumper
	name = "flat-packed ore thumper"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/ore_thumper_item.dmi'
	icon_state = "thumper_packed"
	type_to_deploy = /obj/machinery/power/colony_ore_thumper
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/flatpacked_machine/ore_thumper/examine(mob/user)
	. = ..()
	. += span_notice("It must be constructed <b>outdoors</b> to function.")
	. += span_notice("It must be constructed on <b>suitable terrain</b>, like ash, snow, or sand.")
	. += span_notice("It must have a powered, <b>wired connection</b> running beneath it to function.")

/obj/item/flatpacked_machine/ore_thumper/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

#undef SLAM_JAM_DELAY
#undef THUMPER_QUAKE_CHANCE
#undef THUMPER_QUAKE_COOLDOWN
#undef THUMPER_LOAD_SEGMENTS
#undef THUMPER_SYNC_MAX_SHIFT
#undef THUMPER_SYNC_GAIN
#undef THUMPER_SYNC_MIN_AGREEMENT
#undef THUMPER_POWER_GRACE
#undef THUMPER_STALL_LOCATION
#undef THUMPER_STALL_NO_WIRE
#undef THUMPER_STALL_POWER
#undef THUMPER_STALL_ORE
#undef THUMPER_STALL_NEIGHBOR
