/obj/machinery/door/poddoor/story
	name = "hardened blast door"
	desc = "A heavy duty blast door that only opens for dire emergencies."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/story/crowbar_act(mob/living/user, obj/item/tool)
	return

/obj/machinery/door/manual_airlock
	name = "manual airlock"
	desc = "An old-fashioned airlock with a manual valve that needs to be turned multiple times to unlock. \
			Right-click to start turning the valve, left-click to open once fully turned. Right-click to close."
	icon = 'modular_zvents/icons/doors/manual_airlock.dmi'
	icon_state = "door_closed"
	base_icon_state = "door"
	armor_type = /datum/armor/door_manual_airlock
	power_channel = AREA_USAGE_ENVIRON
	density = TRUE
	opacity = TRUE
	req_access = null
	autoclose = FALSE
	locked = FALSE
	welded = FALSE
	use_power = NO_POWER_USE
	var/turns = 0
	var/max_turns = 3
	var/valve_blocked = FALSE
	var/turn_delay = 1 SECONDS
	var/auto_turning = FALSE

	var/locked_on_init = TRUE

/datum/armor/door_manual_airlock
	melee = 80
	bullet = 80
	laser = 80
	energy = 80
	bomb = 90
	fire = 100
	acid = 70

/obj/machinery/door/manual_airlock/Initialize(mapload)
	. = ..()
	if(locked_on_init)
		turns = max_turns
	AddElement( \
		/datum/element/contextual_screentip_bare_hands, \
		lmb_text = "Open/close door", \
		rmb_text = "Turn the valve", \
	)
	update_overlays()

/obj/machinery/door/manual_airlock/update_overlays()
	. = ..()
	if(density)
		var/mutable_appearance/valve_overlay = null
		if(auto_turning)
			valve_overlay = mutable_appearance(icon, "valve_turning")
		else if(valve_blocked)
			valve_overlay = mutable_appearance(icon, "valve_jamed")
		else
			valve_overlay = mutable_appearance(icon, "valve")
		if(!valve_overlay)
			return

		. += valve_overlay


/obj/machinery/door/manual_airlock/attack_hand(mob/user, list/modifiers)
	if(operating || welded || locked)
		return
	if(!density)
		close()
		return

	var/right_click = modifiers[RIGHT_CLICK]


	if(right_click)
		if(valve_blocked)
			to_chat(user, span_warning("The valve is blocked and won't turn!"))
			return
		if(auto_turning)
			stop_turning(user)
			return

		var/open = TRUE
		// let's chose what we gona do
		if (turns != max_turns && turns != 0)
			var/list/radial_options = list()
			radial_options["Lock"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_lock")
			radial_options["Unlock"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_unlock")

			var/choice = show_radial_menu(user, src, radial_options, radius = 38, require_near = TRUE)
			if(!choice || get_dist(src, user) > 1)
				return
			if(choice == "Lock")
				open = FALSE

		if(turns == 0)
			open = FALSE

		start_turning(user, open)
		return
	else
		if(turns != 0)
			balloon_alert(user, "Locked!")
			return
		open()
		return


/obj/machinery/door/manual_airlock/proc/start_turning(mob/user, opening = TRUE)
	if(auto_turning || valve_blocked)
		return
	if(!user.Adjacent(src) || user.stat != CONSCIOUS)
		return

	if((turns == max_turns && !opening) || (turns == 0 && opening))
		stop_turning(user)
		return

	if(!do_after(user, turn_delay, src))
		stop_turning(user)
		return

	if(opening)
		turns--
	else
		turns++


	playsound(src, 'modular_zvents/sounds/gatedoor_valve.ogg', 50, TRUE)  // Custom sound
	balloon_alert(user,"Turn the valve ([turns]/[max_turns]).")
	update_icon()
	update_overlays()

	if(turns >= max_turns)
		to_chat(user, span_notice("The valve is fully turned!"))
		return


	auto_turning = TRUE
	addtimer(CALLBACK(src, PROC_REF(continue_turning), user, opening), turn_delay)


/obj/machinery/door/manual_airlock/proc/stop_turning(mob/user)
	auto_turning = FALSE



	playsound(src, 'modular_zvents/sounds/gatedoor_valve.ogg', 50, TRUE)
	balloon_alert(user, "Stop turning!")
	update_icon()
	update_overlays()

/obj/machinery/door/manual_airlock/proc/continue_turning(mob/user, opening = FALSE)
	if(!auto_turning || valve_blocked || turns >= max_turns || !user.Adjacent(src) || user.stat != CONSCIOUS)
		stop_turning(user)
		return

	if(turns == max_turns || turns == 0)
		stop_turning(user)
		return


	if(!do_after(user, turn_delay, src, extra_checks = CALLBACK(src, PROC_REF(can_continue_turning), user)))
		stop_turning(user)
		return

	if(opening)
		turns--
	else
		turns++

	playsound(src, 'modular_zvents/sounds/gatedoor_valve.ogg', 50, TRUE)
	balloon_alert(user,"Turn the valve ([turns]/[max_turns]).")
	update_icon()

	// Continue auto-turning
	addtimer(CALLBACK(src, PROC_REF(continue_turning), user, opening), turn_delay)

/obj/machinery/door/manual_airlock/proc/can_continue_turning(mob/user)
	return user.Adjacent(src) && user.stat == CONSCIOUS && !valve_blocked && auto_turning


/obj/machinery/door/manual_airlock/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(density && turns >= max_turns && !valve_blocked)  // Closed and fully turned
		if(istype(I, /obj/item/pipe) || istype(I, /obj/item/stack/rods))
			if(!do_after(user, 2 SECONDS, src))
				to_chat(user, span_warning("You stop jamming the valve."))
				return
			valve_blocked = TRUE
			// playsound(src, 'sound/effects/metal_jam.ogg', 50, TRUE)
			to_chat(user, span_notice("You jam the valve with [I], blocking it!"))
			update_icon()
			update_overlays()
			return
	if(valve_blocked && istype(I, /obj/item/crowbar))
		if(!do_after(user, 3 SECONDS, src))
			to_chat(user, span_warning("You stop prying the jam."))
			return
		valve_blocked = FALSE
		// playsound(src, 'sound/effects/metal_unjam.ogg', 50, TRUE)
		to_chat(user, span_notice("You pry out the jam, unblocking the valve."))
		update_icon()
		update_overlays()
		return


/obj/machinery/door/manual_airlock/open(forced = FALSE)
	if(operating || welded || locked)  // Inherit parent checks
		return FALSE

	if(valve_blocked)
		to_chat(usr, span_warning("The valve is blocked; the door won't budge!"))
		return FALSE

	if(turns != 0 && !forced)
		return FALSE

	playsound(src, 'modular_zvents/sounds/gatedoor_open.ogg', 50, TRUE)
	return ..()


/obj/machinery/door/manual_airlock/close(forced = DEFAULT_DOOR_CHECKS, force_crush = FALSE)
	auto_turning = FALSE
	playsound(src, 'modular_zvents/sounds/gatedoor_close.ogg', 50, TRUE)
	return ..()



#define BASE_HEATING_ENERGY (20 KILO JOULES)


/obj/machinery/hypothermia


/obj/item/circuitboard/machine/heater
	name = "Heater"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/hypothermia/heater
	req_components = list(
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/capacitor = 2,
		/obj/item/stack/cable_coil = 5)
	needs_anchored = FALSE


/obj/machinery/hypothermia/heater
	name = "Heater"
	desc = "A soviet-made simple heater. Runs on a standard power cell."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/thermomachine.dmi'
	icon_state = "thermo_base"
	base_icon_state = "thermo_base"
	density = TRUE
	anchored = FALSE
	max_integrity = 250
	armor_type = /datum/armor/machinery_space_heater
	circuit = /obj/item/circuitboard/machine/heater

	interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_OPEN

	power_channel = AREA_USAGE_EQUIP
	use_power = IDLE_POWER_USE
	idle_power_usage = 0

	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/super
	var/on = FALSE
	var/target_temperature = T20C
	var/heating_energy = BASE_HEATING_ENERGY
	var/efficiency = BASE_HEATING_ENERGY / (STANDARD_CELL_CHARGE * 3)

	var/datum/component/heat_source/heat_comp
	var/datum/looping_sound/conditioner_running/soundloop

	light_color = COLOR_FIRE_LIGHT_RED

/obj/machinery/hypothermia/heater/Initialize(mapload)
	. = ..()
	if(ispath(cell))
		cell = new cell(src)

	soundloop = new(src, FALSE)

	AddElement(/datum/element/contextual_screentip_bare_hands, rmb_text = "Toggle power")

	var/static/list/tool_behaviors = list(
		TOOL_SCREWDRIVER = list(SCREENTIP_CONTEXT_LMB = "Open hatch"),
		TOOL_WRENCH = list(
			SCREENTIP_CONTEXT_LMB = "Anchor",
			SCREENTIP_CONTEXT_CTRL_LMB = "Increase target temperature",
			SCREENTIP_CONTEXT_CTRL_RMB = "Decrease target temperature"
		)
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)
	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 8)

	create_reagents(50, TRANSPARENT)
	START_PROCESSING(SSmachines, src)

/obj/machinery/hypothermia/heater/Destroy()
	QDEL_NULL(cell)
	QDEL_NULL(soundloop)
	QDEL_NULL(heat_comp)
	STOP_PROCESSING(SSmachines, src)
	return ..()

/obj/machinery/hypothermia/heater/process(seconds_per_tick)
	var/energy_used = (heating_energy/100) * seconds_per_tick
	var/power_source_used = FALSE


	if(anchored && powered() && use_energy(energy_used / efficiency, channel = AREA_USAGE_EQUIP))
		power_source_used = TRUE
	else if(cell && cell.charge && cell.use(energy_used / efficiency))
		power_source_used = TRUE
	if(!power_source_used)
		if(on)
			balloon_alert_to_viewers("No power!")
			turn_off()
		return


/obj/machinery/hypothermia/heater/update_icon_state()
	if(on && !panel_open)
		icon_state = "[base_icon_state]_1"
	else if(panel_open)
		icon_state = "[base_icon_state]-o"
	else
		icon_state = base_icon_state
	return ..()

/obj/machinery/hypothermia/heater/update_overlays()
	. = ..()
	if(panel_open && cell)
		. += mutable_appearance(icon, "thermo_cell")

/obj/machinery/hypothermia/heater/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("Power cell charge: [cell.percent()]%.")
	else
		. += span_warning("No power cell installed.")
	. += span_notice("Target temperature: [target_temperature - T0C]°C.")

/obj/machinery/hypothermia/heater/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	anchored = !anchored
	balloon_alert(user, anchored ? "secured" : "unsecured")
	return TRUE


/obj/machinery/hypothermia/heater/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	if(on)
		balloon_alert(user, "Disable first!")
		return
	..()


/obj/machinery/hypothermia/heater/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stock_parts/power_store/cell))
		if(!panel_open)
			balloon_alert(user, "open hatch first")
			return TRUE
		if(cell)
			balloon_alert(user, "cell already installed")
			return TRUE
		if(!user.transferItemToLoc(I, src))
			return
		cell = I
		user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))
		update_appearance()
		return TRUE

	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_appearance()
		return TRUE

	if(default_deconstruction_crowbar(I))
		return TRUE
	return ..()

/obj/machinery/hypothermia/heater/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(panel_open)
		if(RIGHT_CLICK in modifiers)
			target_temperature = max(target_temperature - 5, T0C + 10)
			balloon_alert(user, "target temp: [target_temperature - T0C]°C")
			return TRUE
		else if(!(CTRL_CLICK in modifiers))
			target_temperature = min(target_temperature + 5, T0C + 60)
			balloon_alert(user, "target temp: [target_temperature - T0C]°C")
			return TRUE
		else if(ishuman(user))
			var/mob/living/carbon/human/human = user
			human.put_in_active_hand(cell)
			cell = null

	if(on)
		turn_off()
	else
		turn_on()

/obj/machinery/hypothermia/heater/proc/turn_on()
	if(!anchored)
		if(!cell)
			balloon_alert(usr, "no cell")
			return
		if(!cell?.charge)
			balloon_alert(usr, "no charge")
			return
	else
		if(use_energy(heating_energy / efficiency, channel = AREA_USAGE_EQUIP))
			balloon_alert(usr, "Running on APC")
		else
			balloon_alert(usr, "No power in APC")
			return

	on = TRUE
	update_appearance()
	balloon_alert(usr, "heater on")

	if(on && !soundloop.loop_started)
		soundloop.start()
	light_power = 2
	light_color = COLOR_FIRE_LIGHT_RED
	heat_comp = AddComponent(/datum/component/heat_source, \
		_heat_output = 5, \
		_heat_power = heating_energy, \
		_range = 2, \
		_target_temperature = target_temperature)
	update_light()

/obj/machinery/hypothermia/heater/proc/turn_off()
	on = FALSE
	update_appearance()
	balloon_alert(usr, "heater off")

	if(heat_comp)
		qdel(heat_comp)
		heat_comp = null

	if(soundloop.loop_started)
		soundloop.stop()
	light_power = 0
	update_light()

#undef BASE_HEATING_ENERGY

