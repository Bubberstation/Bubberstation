/obj/item/tank/rbmk2_rod
	name = "\improper RB-MK2 reactor rod"
	desc = "A rod for the RB-MK2 reactor. Usually filled with tritium."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "platform"
	inhand_icon_state = null
	worn_icon_state null
	tank_holder_icon_state = null
	flags_1 = CONDUCT_1
	slot_flags = null //they have no straps!
	force = 8

/obj/item/tank/rbmk2_rod/preloaded/populate_gas()
	air_contents.assert_gas(/datum/gas/tritum)
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.gases[/datum/gas/tritum][MOLES] = 50
	air_contents.gases[/datum/gas/nitrogen][MOLES] = 25


/obj/machinery/power/rbmk2
	name = "\improper RB-MK2 reactor"
	desc = "Radioscopical Bluespace Mark 2 reactor, or RB MK2 for short, is a new state-of-the-art power generation technology that uses bluespace magic \
	to directly transfer radioactive tritium particles into energy with minimal external heat generation (compared to open-air combustion). \
	While it is said this is safer than a Supermatter Crystal, improper cooling management of internal as well external gasses may lead to a mini-nuclear meltdown.\n\
	To start up a reactor, fill a RB-MK2 rod up with tritium, or a mix of gas containing tritium, and insert it into the reactor. The tritium will slowly get processed into energy."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "platform"
	base_icon_state = "platform"
	density = FALSE
	anchored = TRUE
	use_power = NO_POWER_USE

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_REQUIRES_ANCHORED

	var/active = FALSE
	var/obj/item/tank/rbmk2_rod/stored_rod
	var/datum/gas_mixture/buffer_gasses //Gas that has yet to be leaked out due to not venting fast enough.
	var/last_power_generation = 0

	//Unupgradable stats.
	var/gas_consumption_base = 0.01 //How much gas gets consumed.
	var/gas_consumption_heat = 0.01 //How much gas gets consumed, in moles, per 1000 kelvin.

	//Upgradable stats.
	var/tritium_consumption_amount = 1 //What percentage of tritium is actually "deleted" when processed. Remaining tritium is leaked out. Improved via microlasers.
	var/power_efficiency = 100000 //How many joules of power to add per mole of tritium processed. Improved via capacitors.
	var/vent_pressure = 300 //Pressure, in kPa, that the buffer releases the gas to. Improved via servos.
	var/buffer_gas_thermal_conductivity = 0.1 //Lower is better. Improved via matter bins.

	var/melt_damage = 0 //Value from 0 to 100 that indiciates how much this is melted. Affects a bunch of stats.

/obj/machinery/power/rbmk2/Initialize(mapload)
	. = ..()
	buffer_gasses = new()

/obj/machinery/power/rbmk2/preloaded/Initialize(mapload)
	. = ..()
	stored_rod = new /obj/item/tank/rbmk2_rod/preloaded(src)



/obj/machinery/power/rbmk2/attackby(obj/item/attacking_item, mob/living/user, params)

	if(default_deconstruction_crowbar(attacking_item))
		return TRUE

	if(panel_open && is_wire_tool(attacking_item))
		wires.interact(user)
		return TRUE

	if(user.combat_mode) //so we can hit the machine
		return ..()

	toggle()

/obj/machinery/power/rbmk2/proc/toggle(var/desired_state=!active)

	if(active == desired_state)
		return

	if(desired_state)
		if(!stored_rod)
			to_chat(usr, span_warning("There is no rod inserted in [src]!"))
			return
		if(!anchored)
			to_chat(usr, span_warning("[src] needs to be anchored first!"))
			return

	active = desired_state

	update_icon()

	return TRUE

/obj/machinery/autolathe/RefreshParts()
	. = ..()

	//Requires x4 capacitors
	var/power_efficiency_mul = 0
	for(var/datum/stock_part/capacitor/new_capacitor in component_parts)
		power_efficiency_mul += new_capacitor.tier * 0.25
	power_efficiency = initial(power_efficiency) * power_efficiency_mul

	//Requires x2 microlasers
	var/tritium_consumption_sub = 0
	for(var/datum/stock_part/micro_laser/new_micro_laser in component_parts)
		tritium_consumption_sub += new_micro_laser.tier * 2.5
	tritium_consumption_amount = initial(tritium_consumption_amount) - tritium_consumption_sub

	//Requires x2 matter bins
	var/thermal_conductivity_divisor = 0
	for(var/datum/stock_part/matter_bin/new_matter_bin in component_parts)
		thermal_conductivity_divisor += new_matter_bin.tier * 0.5
	buffer_gas_thermal_conductivity = initial(buffer_gas_thermal_conductivity) / thermal_conductivity_divisor

	//Requires x4 servos
	var/vent_pressure_multiplier = 0
	for(var/datum/stock_part/servo/new_servo in component_parts)
		vent_pressure_multiplier += new_servo.tier * 0.25
	vent_pressure = initial(vent_pressure) * vent_pressure_multiplier


/obj/machinery/power/rbmk2/examine(mob/user)
	. = ..()

	. += "It is[!active?"n't":""] running."

	if(!powernet)
		. += span_warning("It is not connected to a power cable.")

	if(!stored_rod)
		. += span_warning("It it is missing a RB-MK2 reactor rod.")

	if(active)
		. += "It is currently producing [display_power(last_power_generation)] per cycle."

/obj/machinery/power/rbmk2/examine_more(mob/user)
	. = ..()
	. += "It is running at <b>[power_efficiency*100]%</b> power generation."
	. += "It is consuming <b>[100*(1-tritium_consumption_amount)] less tritium."
	. += "It has a thermal conductivity rating of <b>[buffer_gas_thermal_conductivity*100]%."
	. += "It can output in environments up to <b>[vent_pressure]kPa</b>."

/obj/machinery/power/rbmk2/update_icon_state()

	if(stored_rod)
		if(active)
			icon_state = "[base_icon_state]_closed"
		else
			icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state

	return ..()

/obj/machinery/power/rbmk2/port_gen/process()

	if(!stored_rod)
		return

	var/datum/gas_mixture/base_mix = stored_rod.air_contents
	if(!base_mix)
		return

	//If there are any gasses that have yet to escape, transfer the heat of it to the rod.
	buffer_gasses.temperature_share(base_mix, buffer_gas_thermal_conductivity * (1 + melt_damage*0.01))

	if(is_turf(loc))
		var/turf/T = loc
		if(T.air)
			//Share the temperature of the rod with the turf's air.
			base_mix.temperature_share(T.air, T.thermal_conductivity*0.25)

	if(!active || !powernet)
		return

	var/amount_to_consume = gas_consumption_base + (base_mix.temperature/1000)*gas_consumption_heat
	if(!amount_to_consume)
		return

	//Remove gas from the main mix to be processed. This gas is effectively deleted.
	var/datum/gas_mixture/consumed_mix = base_mix.remove(amount_to_consume)

	//Do power generation here.
	var/tritium_amount = consumed_mix.gases[GAS_TRITIUM]
	if(powernet)
		last_power_generation = tritium_amount * power_efficiency
		if(last_power_generation)
			src.add_avail(last_power_generation)

	var/datum/gas_mixture/leaked_mix = consumed_mix.remove_specific(GAS_TRITIUM, tritium_amount*tritium_consumption_amount)

	//The gasses that we consumed go back into the air.
	buffer_gasses.merge(consumed_mix)

	//Vent excess gas, if we can.
	if(is_turf(loc))
		var/turf/T = loc
		if(T.air)
			buffer_gasses.release_gas_to(T.air,vent_pressure)
