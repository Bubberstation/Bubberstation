/// takes no parts, so it performs like a space heater at this tier
#define HEAT_PUMP_EQUIVALENT_TIER 2
/// real time between graph samples, atmos ticks run too uneven to count
#define HEAT_PUMP_HISTORY_INTERVAL (10 SECONDS)
/// graph samples kept, 10 minutes at the interval above
#define HEAT_PUMP_HISTORY_MAX_SAMPLES 60
/// how far the readout moves toward the real reading each tick
#define HEAT_PUMP_READOUT_SMOOTHING 0.3
/// how close (kelvin) the zone must get before it calls the job done
#define HEAT_PUMP_SETPOINT_MARGIN 0.1
/// energy per second the apc puts into the cell
#define HEAT_PUMP_CHARGE_RATE (STANDARD_CELL_RATE * 0.15)
/// extra energy burned per joule charged
#define HEAT_PUMP_CHARGE_OVERHEAD 0.5
// copies of the heater mode defines, which spaceheater.dm undefines before we load
#define HEAT_PUMP_MODE_STANDBY "standby"
#define HEAT_PUMP_MODE_HEAT "heat"
#define HEAT_PUMP_MODE_COOL "cool"
#define HEAT_PUMP_CELSIUS_TO_FAHRENHEIT(celsius) ((celsius) * 9 / 5 + 32)

/obj/machinery/space_heater/heat_pump
	name = "wall mounted heat pump"
	desc = "A compact heating and cooling device for large scale applications, essentially an air conditioner that also runs in reverse, made to mount onto walls up and out of the way. \
		It charges with the nearest APC; the internal cell buffers the power to the heating/cooling mechanism."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/heat_pump.dmi'
	icon_state = "heat_pump-off"
	base_icon_state = "heat_pump"
	anchored = TRUE
	density = FALSE
	circuit = null
	// space heater RefreshParts maths, locked at HEAT_PUMP_EQUIVALENT_TIER
	heating_energy = /obj/machinery/space_heater::heating_energy * HEAT_PUMP_EQUIVALENT_TIER
	efficiency = (HEAT_PUMP_EQUIVALENT_TIER + 1) * /obj/machinery/space_heater::efficiency * 0.5
	settable_temperature_range = /obj/machinery/space_heater::settable_temperature_range * HEAT_PUMP_EQUIVALENT_TIER
	temperature_tolerance = 0.5
	/// What this repacks into when its wrenched off a wall
	var/repacked_type = /obj/item/wallframe/heat_pump
	/// whether the panel shows fahrenheit, kept per unit
	var/display_fahrenheit = FALSE
	/// smoothed zone temperature in kelvin for the panel
	var/readout_temperature
	/// graph samples in celsius, oldest first
	var/list/temperature_history = list()
	/// paces the graph samples
	COOLDOWN_DECLARE(history_cooldown)
	/// set when another unit in our zone pushes the other way
	var/conflict_detected = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/space_heater/heat_pump, 29)

/obj/machinery/space_heater/heat_pump/Initialize(mapload)
	. = ..()
	if(mapload)
		find_and_mount_on_atom()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	RemoveElement(/datum/element/elevation, pixel_shift = 8)
	RemoveElement(/datum/element/climbable)
	register_context()

// replaces the stock heater's tool tips
/obj/machinery/space_heater/heat_pump/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item?.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "Unmount"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/storage/part_replacer))
		context[SCREENTIP_CONTEXT_LMB] = "Swap cell"
		return CONTEXTUAL_SCREENTIP_SET

// no parts, so nothing scales off them
/obj/machinery/space_heater/heat_pump/RefreshParts()
	. = ..()
	heating_energy = initial(heating_energy)
	efficiency = initial(efficiency)
	settable_temperature_range = initial(settable_temperature_range)

/obj/machinery/space_heater/heat_pump/examine(mob/user)
	. = ..()
	if(has_apc_power())
		. += span_notice("It is connected to APC power.")
	else
		. += span_warning("It has no APC power and is running off its cell.")

// the apc's equipment channel, the same check other machines use
/obj/machinery/space_heater/heat_pump/proc/has_apc_power()
	return powered(power_channel, ignore_use_power = TRUE)

/obj/machinery/space_heater/heat_pump/proc/format_temperature(kelvin)
	if(display_fahrenheit)
		return "[round(HEAT_PUMP_CELSIUS_TO_FAHRENHEIT(kelvin - T0C))]°F"
	return "[round(kelvin - T0C)]°C"

/obj/machinery/space_heater/heat_pump/heating_examine()
	var/min_temp = format_temperature(max(settable_temperature_median - settable_temperature_range, TCMB))
	var/max_temp = format_temperature(settable_temperature_median + settable_temperature_range)
	return span_notice("The status display reads:<br>Heating power: <b>[display_power(heating_energy, convert = TRUE, scheduler = SSair)]</b><br>Target temperature: <b>[format_temperature(target_temperature)] ([min_temp] - [max_temp])</b>\n")

/obj/machinery/space_heater/heat_pump/process_atmos(seconds_per_tick)
	if(!is_operational)
		if(on)
			on = FALSE
			update_appearance()
		return PROCESS_KILL

	// tops up the cell from the apc even while idle
	if(!isnull(cell))
		var/charge_given = charge_cell(HEAT_PUMP_CHARGE_RATE * seconds_per_tick, cell)
		if(charge_given)
			use_energy(charge_given * HEAT_PUMP_CHARGE_OVERHEAD)

	var/turf/open/local_turf = loc
	if(!istype(local_turf))
		set_active_mode(HEAT_PUMP_MODE_STANDBY)
		return

	var/list/zone = get_zone_turfs(local_turf)
	var/sensed_temperature = get_zone_temperature(zone)
	if(isnull(sensed_temperature))
		set_active_mode(HEAT_PUMP_MODE_STANDBY)
		return
	record_temperature(sensed_temperature)

	// a flat cell idles until the apc refills it
	if(!on || QDELETED(cell) || cell.charge <= 1)
		conflict_detected = FALSE
		set_active_mode(HEAT_PUMP_MODE_STANDBY)
		return

	set_active_mode(pick_mode(sensed_temperature))
	conflict_detected = check_for_conflict(zone)
	if(mode == HEAT_PUMP_MODE_STANDBY)
		return
	condition_zone(zone)

// our tile and open neighbours in the same area, so doorways don't skew the reading
/obj/machinery/space_heater/heat_pump/proc/get_zone_turfs(turf/open/local_turf)
	var/area/home_area = get_area(src)
	var/list/zone = list(local_turf)
	for(var/turf/open/neighbour as anything in local_turf.atmos_adjacent_turfs)
		if(get_area(neighbour) == home_area)
			zone += neighbour
	return zone

/obj/machinery/space_heater/heat_pump/proc/get_zone_temperature(list/zone)
	var/total = 0
	var/counted = 0
	for(var/turf/open/zone_turf as anything in zone)
		var/datum/gas_mixture/air = zone_turf.return_air()
		if(isnull(air) || air.heat_capacity() <= 0)
			continue
		total += air.temperature
		counted++
	if(!counted)
		return null
	return total / counted

/obj/machinery/space_heater/heat_pump/proc/record_temperature(sensed_temperature)
	if(isnull(readout_temperature))
		readout_temperature = sensed_temperature
	else
		readout_temperature += (sensed_temperature - readout_temperature) * HEAT_PUMP_READOUT_SMOOTHING
	if(!COOLDOWN_FINISHED(src, history_cooldown))
		return
	COOLDOWN_START(src, history_cooldown, HEAT_PUMP_HISTORY_INTERVAL)
	temperature_history += round(readout_temperature - T0C, 0.1)
	if(length(temperature_history) > HEAT_PUMP_HISTORY_MAX_SAMPLES)
		temperature_history.Cut(1, 2)

// starts outside the tolerance band, keeps going until it actually hits target
/obj/machinery/space_heater/heat_pump/proc/pick_mode(sensed_temperature)
	if(set_mode != HEAT_PUMP_MODE_COOL)
		if(sensed_temperature < target_temperature - temperature_tolerance)
			return HEAT_PUMP_MODE_HEAT
		if(mode == HEAT_PUMP_MODE_HEAT && sensed_temperature < target_temperature - HEAT_PUMP_SETPOINT_MARGIN)
			return HEAT_PUMP_MODE_HEAT
	if(set_mode != HEAT_PUMP_MODE_HEAT)
		if(sensed_temperature > target_temperature + temperature_tolerance)
			return HEAT_PUMP_MODE_COOL
		if(mode == HEAT_PUMP_MODE_COOL && sensed_temperature > target_temperature + HEAT_PUMP_SETPOINT_MARGIN)
			return HEAT_PUMP_MODE_COOL
	return HEAT_PUMP_MODE_STANDBY

/obj/machinery/space_heater/heat_pump/proc/set_active_mode(new_mode)
	if(mode == new_mode)
		return
	mode = new_mode
	update_appearance()

/obj/machinery/space_heater/heat_pump/proc/check_for_conflict(list/zone)
	if(mode == HEAT_PUMP_MODE_STANDBY)
		return FALSE
	for(var/turf/open/zone_turf as anything in zone)
		for(var/obj/machinery/space_heater/other in zone_turf)
			if(other == src || !other.on || other.mode == HEAT_PUMP_MODE_STANDBY)
				continue
			if(other.mode != mode)
				return TRUE
	return FALSE

// each tile only gets what it needs, so stacked units can't overshoot into a fight
/obj/machinery/space_heater/heat_pump/proc/condition_zone(list/zone)
	var/energy_budget = cell.charge * efficiency
	var/energy_spent = 0
	for(var/turf/open/zone_turf as anything in zone)
		var/datum/gas_mixture/air = zone_turf.return_air()
		if(isnull(air))
			continue
		var/heat_capacity = air.heat_capacity()
		if(heat_capacity <= 0)
			continue
		var/gap = target_temperature - air.temperature
		if(mode == HEAT_PUMP_MODE_HEAT && gap <= 0)
			continue
		if(mode == HEAT_PUMP_MODE_COOL && gap >= 0)
			continue
		var/energy = min(abs(gap) * heat_capacity, heating_energy, energy_budget - energy_spent)
		if(energy <= 0)
			break
		air.temperature += (mode == HEAT_PUMP_MODE_HEAT ? energy : -energy) / heat_capacity
		zone_turf.air_update_turf(FALSE, FALSE)
		energy_spent += energy
	if(energy_spent)
		cell.use(energy_spent / efficiency, force = TRUE)

/obj/machinery/space_heater/heat_pump/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HeatPump", name)
		ui.open()

/obj/machinery/space_heater/heat_pump/ui_data()
	var/list/data = list()
	data["on"] = on
	data["open"] = panel_open
	data["mode"] = set_mode
	data["activeMode"] = mode
	data["apcPower"] = has_apc_power()
	data["hasCell"] = !isnull(cell)
	data["cellName"] = cell?.name
	data["cellCharge"] = cell ? round(cell.percent(), 1) : 0
	data["targetTemp"] = round(target_temperature - T0C, 0.01)
	data["minTemp"] = max(settable_temperature_median - settable_temperature_range, TCMB) - T0C
	data["maxTemp"] = settable_temperature_median + settable_temperature_range - T0C
	data["defaultTemp"] = initial(target_temperature) - T0C
	data["currentTemp"] = isnull(readout_temperature) ? null : round(readout_temperature - T0C, 0.1)
	// the temperatures where the air starts hurting people
	data["hazardMin"] = BODYTEMP_COLD_DAMAGE_LIMIT - T0C
	data["hazardMax"] = BODYTEMP_HEAT_DAMAGE_LIMIT - T0C
	data["history"] = temperature_history
	data["fahrenheit"] = display_fahrenheit
	data["conflict"] = conflict_detected
	return data

/obj/machinery/space_heater/heat_pump/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		// own action so it skips the hatch check and integer rounding
		if("set_target")
			var/new_target = text2num(params["target"])
			if(isnull(new_target))
				return
			target_temperature = clamp(new_target + T0C,
				max(settable_temperature_median - settable_temperature_range, TCMB),
				settable_temperature_median + settable_temperature_range)
			return TRUE
		if("reset_target")
			target_temperature = initial(target_temperature)
			return TRUE
		if("toggle_unit")
			display_fahrenheit = !display_fahrenheit
			return TRUE

// no circuit board, so the rped's own parts check never lets it through
/obj/machinery/space_heater/heat_pump/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/storage/part_replacer) && !user.combat_mode)
		return swap_cell_from_rped(user, tool)
	return ..()

/obj/machinery/space_heater/heat_pump/ranged_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/storage/part_replacer/bluespace) && !user.combat_mode)
		return swap_cell_from_rped(user, tool)
	return ..()

// follows the stock exchange_parts flow and wording
/obj/machinery/space_heater/heat_pump/proc/swap_cell_from_rped(mob/living/user, obj/item/storage/part_replacer/replacer)
	var/remote = istype(replacer, /obj/item/storage/part_replacer/bluespace)
	if(!panel_open && !remote)
		to_chat(user, display_cell(user))
		return ITEM_INTERACT_BLOCKING
	if(remote)
		to_chat(user, display_cell(user))

	// compare capacity, part rating counts charge and would swap for an identical fuller cell
	var/obj/item/stock_parts/power_store/cell/best_cell
	var/best_capacity = cell ? cell.maxcharge : 0
	for(var/obj/item/stock_parts/power_store/cell/candidate in replacer.contents)
		if(candidate.maxcharge > best_capacity)
			best_capacity = candidate.maxcharge
			best_cell = candidate
	if(isnull(best_cell))
		return ITEM_INTERACT_SUCCESS

	if(remote && best_cell.try_explode(max_charge = TRUE))
		return ITEM_INTERACT_SUCCESS
	if(!replacer.atom_storage.attempt_remove(best_cell, src, silent = TRUE))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/stock_parts/power_store/old_cell = cell
	cell = best_cell
	if(isnull(old_cell))
		to_chat(user, span_notice("[capitalize(best_cell.name)] installed."))
	else
		if(!replacer.atom_storage.attempt_insert(old_cell, user, override = TRUE, force = STORAGE_SOFT_LOCKED, messages = FALSE))
			old_cell.forceMove(drop_location())
		to_chat(user, span_notice("[capitalize(old_cell.name)] replaced with [best_cell.name]."))
	replacer.play_rped_effect()
	replacer.atom_storage.refresh_views()
	replacer.update_appearance()
	SStgui.update_uis(src)
	return ITEM_INTERACT_SUCCESS

// same format as display_parts, which only reads component_parts and we have none
/obj/machinery/space_heater/heat_pump/proc/display_cell(mob/user)
	var/text = span_notice("It contains the following parts:")
	if(cell)
		text += span_notice("[icon2html(cell.icon, user, cell.icon_state)] 1 [cell.name].")
	return text

/obj/machinery/space_heater/heat_pump/default_deconstruction_crowbar()
	return

/obj/machinery/space_heater/heat_pump/default_unfasten_wrench(mob/living/user, obj/item/wrench, time)
	user.balloon_alert(user, "unmounting...")
	wrench.play_tool_sound(src)
	if(wrench.use_tool(src, user, 1 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
		return

/obj/machinery/space_heater/heat_pump/on_deconstruction(disassembled)
	if(disassembled)
		var/obj/item/wallframe/heat_pump/frame = new repacked_type(drop_location())
		frame.cell = cell
		cell?.forceMove(frame)
	else
		cell?.forceMove(drop_location())
	cell = null
	return ..()

// Wallmount for creating the heat pumps

/obj/item/wallframe/heat_pump
	name = "unmounted heat pump"
	desc = "A compact heating and cooling device for small scale applications, made to mount onto walls up and out of the way. \
		Like other, more free-standing space heaters however, these still require cell power to function."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/heat_pump.dmi'
	icon_state = "heat_pump-off"
	w_class = WEIGHT_CLASS_NORMAL
	result_path = /obj/machinery/space_heater/heat_pump
	pixel_shift = 29
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	/// lazy-initialized cell stored in the actual heater (so that it can start with one without making a new one every placement)
	var/obj/item/stock_parts/power_store/cell = /obj/machinery/space_heater/heat_pump::cell

// the stock proc spawns an empty stack for the sub-sheet gold, which runtimes when the frame burns
/obj/item/wallframe/heat_pump/atom_deconstruct(disassembled)
	var/atom/drop = drop_location()
	for(var/datum/material/mat as anything in custom_materials)
		var/sheets = round(custom_materials[mat] / SHEET_MATERIAL_AMOUNT)
		if(sheets >= 1)
			new mat.sheet_type(drop, sheets)
	if(istype(cell))
		cell.forceMove(drop)
		cell = null

/obj/item/wallframe/heat_pump/after_attach(obj/machinery/space_heater/heat_pump/attached_to)
	. = ..()
	if(!istype(attached_to))
		return
	if(ispath(cell))
		cell = new cell
	// swap the fresh unit's cell for the frame's so cells never duplicate
	QDEL_NULL(attached_to.cell)
	attached_to.cell = cell
	cell?.forceMove(attached_to)
	cell = null

/obj/item/wallframe/heat_pump/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return NONE
	if(ispath(cell))
		cell = new cell
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	user.transferItemToLoc(tool, src)
	if(!isnull(cell))
		user.put_in_hands(cell)
		user.balloon_alert(user, "swapped")
	cell = tool
	return ITEM_INTERACT_SUCCESS

/obj/item/wallframe/heat_pump/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(isnull(cell))
		return SECONDARY_ATTACK_CALL_NORMAL
	if(ispath(cell))
		cell = new cell
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	user.put_in_hands(cell)
	cell = null
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/wallframe/heat_pump/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("It contains a [ispath(cell) ? cell::name : cell.name], which could be replaced.")
	else
		. += span_notice("It is empty. You could insert a [span_bold("cell")].")

/obj/item/wallframe/heat_pump/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!isnull(cell) && isnull(held_item))
		context[SCREENTIP_CONTEXT_RMB] = "Remove cell"
		. = CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/stock_parts/power_store))
		context[SCREENTIP_CONTEXT_LMB] = "Insert cell"
		. = CONTEXTUAL_SCREENTIP_SET

#undef HEAT_PUMP_EQUIVALENT_TIER
#undef HEAT_PUMP_HISTORY_INTERVAL
#undef HEAT_PUMP_HISTORY_MAX_SAMPLES
#undef HEAT_PUMP_READOUT_SMOOTHING
#undef HEAT_PUMP_SETPOINT_MARGIN
#undef HEAT_PUMP_CHARGE_RATE
#undef HEAT_PUMP_CHARGE_OVERHEAD
#undef HEAT_PUMP_MODE_STANDBY
#undef HEAT_PUMP_MODE_HEAT
#undef HEAT_PUMP_MODE_COOL
#undef HEAT_PUMP_CELSIUS_TO_FAHRENHEIT
