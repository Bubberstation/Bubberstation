/obj/machinery/power/rbmk2/process()

	if(!stored_rod)
		meter_overlay.alpha = 0
		heat_overlay.alpha = 0
		update_appearance()
		return

	var/datum/gas_mixture/rod_mix = stored_rod.air_contents
	if(!rod_mix || !rod_mix.gases)
		meter_overlay.alpha = 0
		heat_overlay.alpha = 0
		update_appearance()
		return

	if(venting)
		if(vent_reverse_direction)
			heat_overlay.color = heat2colour(buffer_gasses.temperature)
			heat_overlay.alpha = min(5 + buffer_gasses.temperature * (1/1000) * 255,255)
		else
			heat_overlay.color = heat2colour(rod_mix.temperature)
			heat_overlay.alpha = min(5 + rod_mix.temperature * (1/1000) * 255,255)
	else
		heat_overlay.alpha = 0

	if(!active && !jammed && rod_mix.gases[/datum/gas/tritium])
		var/meter_icon_num = CEILING( min(rod_mix.gases[/datum/gas/tritium][MOLES] / 100, 1) * 5, 1)
		if(meter_icon_num > 0)
			meter_overlay.alpha = 255
			meter_overlay.icon_state = "platform_rod_glow_[meter_icon_num]"
			var/return_pressure_mod = rod_mix.return_pressure() / TANK_FRAGMENT_PRESSURE
			meter_overlay.color = rgb(return_pressure_mod*255,255 - return_pressure_mod*255,0)
		else
			meter_overlay.alpha = 0
	else
		meter_overlay.alpha = 0

	update_appearance()

	var/turf/T
	var/datum/gas_mixture/turf_air
	if(isturf(loc))
		T = loc
		turf_air = T.return_air()

	if(!active)
		if(turf_air && venting && !vent_reverse_direction)
			buffer_gasses.pump_gas_to(turf_air,vent_pressure*2) //Goodbye, buffer gasses.
			transfer_rod_temperature(turf_air,allow_cooling_limiter=FALSE)
		return

	var/amount_to_consume = (gas_consumption_base + (rod_mix.temperature/1000)*gas_consumption_heat)*(overclocked ? 1.25 : 1)*(0.75 + power_efficiency*0.25)*(obj_flags & EMAGGED ? 10 : 1)
	if(!amount_to_consume)
		return

	//Remove gas from the rod to be processed.
	var/datum/gas_mixture/consumed_mix = rod_mix.remove(amount_to_consume)

	//Do power generation here.
	consumed_mix.assert_gas(/datum/gas/tritium)
	if(consumed_mix.gases && consumed_mix.gases[/datum/gas/tritium])
		last_tritium_consumption = consumed_mix.gases[/datum/gas/tritium][MOLES]
		radiation_pulse(src,min( (last_tritium_consumption/0.02)*4 ,GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE),threshold = RAD_FULL_INSULATION)
		if(power && powernet)
			last_power_generation = last_tritium_consumption * power_efficiency * base_power_generation * (overclocked ? 0.9 : 1)
			if(last_power_generation)
				src.add_avail(last_power_generation)
		consumed_mix.remove_specific(/datum/gas/tritium, last_tritium_consumption*0.50) //50% of used tritium gets deleted. The rest gets thrown into the air.
		var/our_heat_capacity = consumed_mix.heat_capacity()
		if(our_heat_capacity > 0)
			consumed_mix.temperature += (800/our_heat_capacity)*(overclocked ? 2 : 1)*power_efficiency
		if(obj_flags & EMAGGED)
			take_damage(0.5,armour_penetration=100,sound_effect=FALSE)
	else
		toggle_active(null,FALSE)

	//The gasses that we consumed go into the buffer, to be released in the air.
	buffer_gasses.merge(consumed_mix)

	//Share the remaining temperature with the rod mix itself.
	transfer_rod_temperature(buffer_gasses)

	if(buffer_gasses.return_pressure() > TANK_FRAGMENT_PRESSURE) //uh oh, backflow!
		buffer_gasses.equalize(rod_mix)

	//Vent excess gas.
	if(turf_air && venting)
		if(vent_reverse_direction)
			turf_air.pump_gas_to(buffer_gasses,vent_pressure) //Hello, turf gasses.
		else
			buffer_gasses.pump_gas_to(turf_air,vent_pressure) //Goodbye, buffer gasses.
			transfer_rod_temperature(turf_air,allow_cooling_limiter=TRUE)

	if(prob(5))
		playsound(src, 'sound/misc/metal_creak.ogg', 50, TRUE, extrarange = -3)

	stored_rod.handle_tolerances(2)

	if(!jammed && safety && (rod_mix.return_pressure() > TANK_LEAK_PRESSURE*0.8 || rod_mix.temperature > TANK_MELT_TEMPERATURE*0.8))
		var/damage_mod = (1 - atom_integrity/max_integrity)
		var/jam_chance = (80 - (damage_mod * 90)) - (venting ? 0 : 40)  //Atmos optimization. Less chance to jam if the vents are off.
		if(jam_chance > 0 && prob(jam_chance))
			jam(null,TRUE)
		else
			toggle_active(null,FALSE)
			take_damage(3,armour_penetration=100)

	return TRUE