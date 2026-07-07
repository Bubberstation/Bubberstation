#define GUARD_CHARGER_MAX_GUNS 2
#define GUARD_MINI_EGUN_DRAIN_RATE (0.1 * STANDARD_CELL_CHARGE)
#define GUARD_CHARGER_OUTPOST_RANGE 10

/obj/machinery/recharger
	/// If TRUE, check during late init whether this mapped base recharger belongs in a department guard outpost.
	var/guard_charger_mapload_replacement = FALSE

/obj/machinery/recharger/Initialize(mapload)
	. = ..()
	guard_charger_mapload_replacement = mapload && (type == /obj/machinery/recharger)

/obj/machinery/recharger/post_machine_initialize()
	. = ..()
	if(!guard_charger_mapload_replacement || !is_department_guard_outpost_recharger())
		return

	var/obj/machinery/recharger/guard/replacement = new(loc)
	replacement.setDir(dir)
	replacement.pixel_x = pixel_x
	replacement.pixel_y = pixel_y
	replacement.pixel_z = pixel_z
	qdel(src)

/obj/machinery/recharger/proc/is_department_guard_outpost_recharger()
	var/area/charger_area = get_area(src)
	if(!charger_area)
		return FALSE

	var/static/list/department_guard_outpost_areas = typecacheof(list(
		/area/station/security/checkpoint/engineering,
		/area/station/security/checkpoint/medical,
		/area/station/security/checkpoint/science,
		/area/station/security/checkpoint/supply,
		/area/station/security/checkpoint/customs,
		/area/station/security/checkpoint/service,
	))
	if(is_type_in_typecache(charger_area, department_guard_outpost_areas))
		return TRUE

	var/static/list/department_guard_landmarks = typecacheof(list(
		/obj/effect/landmark/start/science_guard,
		/obj/effect/landmark/start/orderly,
		/obj/effect/landmark/start/engineering_guard,
		/obj/effect/landmark/start/customs_agent,
		/obj/effect/landmark/start/bouncer,
	))

	var/turf/charger_turf = get_turf(src)
	if(!charger_turf)
		return FALSE

	for(var/turf/area_turf as anything in charger_area)
		if(area_turf.z != charger_turf.z || get_dist(charger_turf, area_turf) > GUARD_CHARGER_OUTPOST_RANGE)
			continue
		for(var/obj/effect/landmark/start/landmark in area_turf)
			if(is_type_in_typecache(landmark, department_guard_landmarks))
				return TRUE

	return FALSE

/obj/item/firing_pin/alert_level/guard_red
	name = "red alert level firing pin"
	desired_minimium_alert = SEC_LEVEL_RED
	desc = "A small authentication device, to be inserted into a firearm receiver to allow operation. This one is configured to only fire on red alert or higher."
	fail_message = "red alert required!"
	pin_removable = FALSE

/obj/item/gun/energy/e_gun/mini/guard_emergency
	name = "emergency guard mini energy gun"
	desc = "A compact emergency energy gun issued from a guard charger. Its charge rapidly bleeds away below red alert unless it is returned to its holster."
	pin = /obj/item/firing_pin/alert_level/guard_red

/obj/item/gun/energy/e_gun/mini/guard_emergency/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/gun/energy/e_gun/mini/guard_emergency/process(seconds_per_tick)
	. = ..()
	if(!cell || SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_RED || is_holstered_in_guard_charger())
		return

	cell.use(GUARD_MINI_EGUN_DRAIN_RATE * seconds_per_tick, TRUE)
	if(chambered && !can_shoot())
		chambered = null
	update_appearance()

/obj/item/gun/energy/e_gun/mini/guard_emergency/proc/is_holstered_in_guard_charger()
	var/obj/machinery/recharger/guard/charger = loc
	return istype(charger) && charger.has_holstered_gun(src)

/obj/machinery/recharger/guard
	name = "emergency guard recharger"
	desc = "A standard weapon recharger with two locked side holsters for emergency guard mini energy guns."
	icon = 'modular_zubbers/icons/obj/machines/guard_charger.dmi'
	icon_state = "recharger_guard_2"
	base_icon_state = "recharger"
	circuit = /obj/item/circuitboard/machine/guard_charger
	/// The mini energy guns currently secured in the side holsters.
	var/list/obj/item/gun/energy/e_gun/mini/guard_emergency/holstered_guns = list()

/obj/machinery/recharger/guard/Initialize(mapload)
	. = ..()
	register_context()
	while(length(holstered_guns) < GUARD_CHARGER_MAX_GUNS)
		add_holstered_gun(new /obj/item/gun/energy/e_gun/mini/guard_emergency(src))
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(on_security_level_changed))
	update_appearance()

/obj/machinery/recharger/guard/Destroy()
	UnregisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED)
	holstered_guns = null
	return ..()

/obj/machinery/recharger/guard/examine(mob/user)
	. = ..()
	. += span_notice("Its side holsters contain [length(holstered_guns)] of [GUARD_CHARGER_MAX_GUNS] emergency mini energy guns.")
	if(SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_RED)
		. += span_notice("The side holsters are unlocked. Right-click it to remove an emergency mini energy gun.")
	else
		. += span_warning("The side holsters are locked until red alert.")

/obj/machinery/recharger/guard/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(length(holstered_guns))
		context[SCREENTIP_CONTEXT_RMB] = "Release emergency gun"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/recharger/guard/proc/on_security_level_changed(datum/source, new_level)
	SIGNAL_HANDLER
	update_appearance()

/obj/machinery/recharger/guard/proc/has_holstered_gun(obj/item/gun/energy/e_gun/mini/guard_emergency/gun)
	return gun in holstered_guns

/obj/machinery/recharger/guard/proc/add_holstered_gun(obj/item/gun/energy/e_gun/mini/guard_emergency/gun)
	if(!gun || length(holstered_guns) >= GUARD_CHARGER_MAX_GUNS || (gun in holstered_guns))
		return FALSE

	holstered_guns += gun
	charge_guard_gun(gun)
	START_PROCESSING(SSmachines, src)
	update_appearance()
	return TRUE

/obj/machinery/recharger/guard/proc/charge_guard_gun(obj/item/gun/energy/e_gun/mini/guard_emergency/gun)
	if(!gun?.cell)
		return

	gun.cell.give(gun.cell.maxcharge)
	if(!gun.chambered)
		gun.recharge_newshot(TRUE)
	gun.update_appearance()

/obj/machinery/recharger/guard/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(istype(arrived, /obj/item/gun/energy/e_gun/mini/guard_emergency))
		add_holstered_gun(arrived)
		return
	return ..()

/obj/machinery/recharger/guard/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone in holstered_guns)
		holstered_guns -= gone
		update_appearance()

/obj/machinery/recharger/guard/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/gun/energy/e_gun/mini/guard_emergency))
		return ..()

	if(machine_stat & BROKEN)
		balloon_alert(user, "charger broken")
		return ITEM_INTERACT_BLOCKING
	if(panel_open)
		return ITEM_INTERACT_BLOCKING
	if(length(holstered_guns) >= GUARD_CHARGER_MAX_GUNS)
		balloon_alert(user, "holsters full")
		return ITEM_INTERACT_BLOCKING

	var/obj/item/gun/energy/e_gun/mini/guard_emergency/gun = tool
	if(!user.transferItemToLoc(gun, src))
		return ITEM_INTERACT_BLOCKING

	add_holstered_gun(gun)
	balloon_alert(user, "gun secured")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/recharger/guard/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	release_holstered_gun(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/recharger/guard/proc/release_holstered_gun(mob/user)
	if(SSsecurity_level.get_current_level_as_number() < SEC_LEVEL_RED)
		balloon_alert(user, "red alert required")
		return FALSE
	if(!length(holstered_guns))
		balloon_alert(user, "holsters empty")
		return FALSE

	var/obj/item/gun/energy/e_gun/mini/guard_emergency/gun = holstered_guns[length(holstered_guns)]
	holstered_guns -= gun
	if(!user.put_in_hands(gun))
		gun.forceMove(drop_location())
	balloon_alert(user, "gun released")
	update_appearance()
	return TRUE

/obj/machinery/recharger/guard/process(seconds_per_tick)
	var/parent_result = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return PROCESS_KILL
	if(!length(holstered_guns))
		return parent_result

	for(var/obj/item/gun/energy/e_gun/mini/guard_emergency/gun as anything in holstered_guns)
		charge_guard_gun(gun)
	use_energy(active_power_usage * seconds_per_tick)
	return

/obj/machinery/recharger/guard/update_icon_state()
	. = ..()
	switch(length(holstered_guns))
		if(0)
			icon_state = "recharger_guard_empty"
		if(1)
			icon_state = "recharger_guard_1"
		else
			icon_state = "recharger_guard_2"

/obj/item/circuitboard/machine/guard_charger
	name = "Emergency Guard Recharger"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/recharger/guard
	req_components = list(/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/recharger/guard, 32)

#undef GUARD_CHARGER_MAX_GUNS
#undef GUARD_MINI_EGUN_DRAIN_RATE
#undef GUARD_CHARGER_OUTPOST_RANGE
