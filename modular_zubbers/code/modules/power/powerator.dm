#define POWERATOR_FACTION_STATION "station"
#define POWERATOR_FACTION_INTERDYNE "interdyne"
#define POWERATOR_FACTION_TARKON "tarkon"

/obj/item/circuitboard/machine/powerator
	name = "Powerator"
	desc = "The powerator is a machine that allows stations to sell their power to other stations that require additional sources."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/powerator
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)
	needs_anchored = TRUE

/datum/supply_pack/misc/powerator
	name = "Powerator"
	desc = "We know the feeling of losing power and Central sending power, it is our time to do the same."
	cost = CARGO_CRATE_VALUE * 50 // 10,000
	contains = list(/obj/item/circuitboard/machine/powerator)
	crate_name = "Powerator Circuitboard Crate"
	crate_type = /obj/structure/closet/crate

/datum/design/board/powerator
	name = "Machine Design (Powerator)"
	desc = "Allows for the construction of circuit boards used to build a powerator."
	id = "powerator"
	build_path = /obj/item/circuitboard/machine/powerator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/powerator
	id = TECHWEB_NODE_POWERATOR
	display_name = "Powerator"
	description = "We've been saved by it in the past, we should send some power ourselves!"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	hidden = TRUE
	experimental = TRUE
	prereq_ids = list(TECHWEB_NODE_PARTS_ADV)
	design_ids = list(
		"powerator",
	)

/obj/machinery/powerator
	name = "powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources!"
	icon = 'modular_zubbers/icons/obj/machines/powerator.dmi'
	icon_state = "powerator"

	density = TRUE
	circuit = /obj/item/circuitboard/machine/powerator
	idle_power_usage = 100

	/// Assoc list of factions -> powerators
	var/static/list/powerator_list = list()
	/// Assoc list of factions -> powerator penalties
	var/static/list/powerator_penalty_multiplier_list = list()

	/// the current amount of power that we are trying to process
	var/current_power = 10 KILO WATTS
	/// the max amount of power that can be sent per process, from 100 KW (t1) to 10000 KW (t4)
	var/max_power = 100 KILO WATTS
	/// how much the current_power is divided by to determine the profit
	var/divide_ratio = 0.00001
	/// the attached cable to the machine
	var/obj/structure/cable/attached_cable
	/// how many credits this machine has actually made so far
	var/credits_made = 0
	/// which faction the powerator belongs to
	var/powerator_faction = POWERATOR_FACTION_STATION
	/// the account credits will be sent towards
	var/credits_account = ACCOUNT_CAR

/obj/machinery/powerator/Initialize(mapload)
	. = ..()
	LAZYADD(powerator_list[powerator_faction], src)
	update_penalty()
	register_context()

/obj/machinery/powerator/Destroy()
	LAZYREMOVE(powerator_list[powerator_faction], src)
	update_penalty()
	attached_cable = null
	. = ..()

/obj/machinery/powerator/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!held_item)
		context[SCREENTIP_CONTEXT_LMB] = "Adjust power draw"
		return CONTEXTUAL_SCREENTIP_SET
	switch(held_item.tool_behaviour)
		if(TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = "[anchored ? "Unanchor" : "Anchor"]"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "Close" : "Open"] panel"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_CROWBAR)
			if(panel_open)
				context[SCREENTIP_CONTEXT_LMB] = "Dismantle machine"
				return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/powerator/examine(mob/user)
	. = ..()
	if(panel_open)
		. += span_warning("The maintainence panel is currently open, preventing [src] from working!")

	if(!anchored)
		. += span_warning("The anchors are not bolted to the floor, preventing [src] from working!")

	if(machine_stat & (NOPOWER | BROKEN))
		. += span_warning("There is either damage or no power being supplied, preventing [src] from working!")

	if(!attached_cable)
		. += span_warning("There is no power cable underneath, preventing [src] from working!")

	. += span_notice("Current Power: [display_power(current_power)]/[display_power(max_power)]")
	. += span_notice("This machine has made [credits_made] credits from selling power so far.")
	if(length(powerator_list[powerator_faction]) > 1)
		. += span_notice("Multiple powerators detected, total efficiency reduced by [(powerator_penalty_multiplier_list[powerator_faction])*100]%")

/obj/machinery/powerator/RefreshParts()
	. = ..()

	var/efficiency = -2 //set to -2 so that tier 1 parts do nothing
	max_power = 100 KILO WATTS
	for(var/datum/stock_part/micro_laser/laser_part in component_parts)
		efficiency += laser_part.tier
	max_power += (efficiency * 1650 KILO WATTS)

	efficiency = -2
	divide_ratio = 0.00001
	for(var/datum/stock_part/servo/servo_part in component_parts)
		efficiency += servo_part.tier
	divide_ratio += (efficiency * 0.000005)

/obj/machinery/powerator/update_overlays()
	. = ..()
	cut_overlays()
	if(panel_open)
		add_overlay("panel_open")

	else
		add_overlay("panel_close")

	if(machine_stat & (NOPOWER | BROKEN) || !anchored || panel_open)
		add_overlay("error")
		return

	if(!attached_cable)
		add_overlay("cable")
		return

	if(!attached_cable.avail(current_power))
		add_overlay("power")
		return

	add_overlay("work")

/obj/machinery/powerator/process()
	update_appearance() //lets just update this
	var/turf/src_turf = get_turf(src)
	attached_cable = locate() in src_turf
	if(machine_stat & (NOPOWER | BROKEN) || !anchored || panel_open || !attached_cable) //no power, broken, unanchored, maint panel open, or no cable? lets reset
		return

	if(!attached_cable)
		return

	if(current_power <= 0)
		current_power = 0 //this is just for the fringe case, wouldn't want it to somehow produce power for money! unless...
		return

	if(!attached_cable.avail(current_power))
		if(!attached_cable.newavail())
			return
		current_power = attached_cable.newavail()
	attached_cable.add_delayedload(current_power)

	var/money_ratio = round(current_power * divide_ratio) * powerator_penalty_multiplier_list[powerator_faction]
	var/datum/bank_account/synced_bank_account = SSeconomy.get_dep_account(credits_account)
	synced_bank_account.adjust_money(money_ratio)
	credits_made += money_ratio

	update_appearance() //lets just update this

/obj/machinery/powerator/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/new_power = tgui_input_number(user, "How much power (in kilowatts) would you like to draw? Max: [display_power(max_power)]", "Power Draw", energy_to_power(current_power) / (1 KILO WATTS), energy_to_power(max_power) / (1 KILO WATTS), 1)
	if(!isnum(new_power))
		return TRUE
	current_power = power_to_energy(new_power) KILO WATTS
	return TRUE

/obj/machinery/powerator/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	panel_open = !panel_open
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/crowbar_act(mob/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/// Update the penalty multiplier for this powerator's faction
/obj/machinery/powerator/proc/update_penalty()
	if(length(powerator_list[powerator_faction]) > 0)
		powerator_penalty_multiplier_list[powerator_faction] = min(1, 2 ** log(4, length(powerator_list[powerator_faction])) / length(powerator_list[powerator_faction]))
	else
		powerator_penalty_multiplier_list[powerator_faction] = 1

// Ghost role versions

/obj/item/circuitboard/machine/powerator/interdyne
	name = "Interdyne Powerator"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/powerator/interdyne

/obj/machinery/powerator/interdyne
	name = "Interdyne powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources! It appears to be an earlier variant before environmental regulation reduced its efficiency."
	circuit = /obj/item/circuitboard/machine/powerator/interdyne

	powerator_faction = POWERATOR_FACTION_INTERDYNE
	credits_account = ACCOUNT_INT


/obj/item/circuitboard/machine/powerator/tarkon
	name = "Tarkon Powerator"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/powerator/tarkon

/obj/machinery/powerator/tarkon
	name = "Tarkon powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources! It appears to be an earlier variant before environmental regulation reduced its efficiency."
	circuit = /obj/item/circuitboard/machine/powerator/tarkon

	powerator_faction = POWERATOR_FACTION_TARKON
	credits_account = ACCOUNT_TAR

#undef POWERATOR_FACTION_STATION
#undef POWERATOR_FACTION_INTERDYNE
#undef POWERATOR_FACTION_TARKON
