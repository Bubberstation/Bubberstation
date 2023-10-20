/obj/machinery/power/rbmk2/process()

	var/turf/T = loc
	if(!isturf(T))
		update_appearance()
		return //wat

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

	var/rod_mix_pressure = rod_mix.return_pressure()
	var/rod_mix_heat_capacity = rod_mix.heat_capacity()

	if(venting)
		if(vent_reverse_direction)
			heat_overlay.color = heat2colour(buffer_gases.temperature)
			heat_overlay.alpha = min( (rod_mix.temperature - T0C) * (1/500) * 255,255)
		else
			heat_overlay.color = heat2colour(rod_mix.temperature)
			heat_overlay.alpha = min( (rod_mix.temperature - T0C) * (1/500) * 255,255)
	else
		heat_overlay.alpha = 0

	if(!active && !jammed && rod_mix.gases[/datum/gas/tritium])
		var/meter_icon_num = CEILING( min(rod_mix.gases[/datum/gas/tritium][MOLES] / 100, 1) * 5, 1)
		if(meter_icon_num > 0)
			meter_overlay.alpha = 255
			meter_overlay.icon_state = "platform_rod_glow_[meter_icon_num]"
			var/return_pressure_mod = clamp( (rod_mix_pressure - stored_rod.pressure_limit*0.5) / stored_rod.pressure_limit*0.5,0,1)
			meter_overlay.color = rgb(return_pressure_mod*255,255 - return_pressure_mod*255,0)
		else
			meter_overlay.alpha = 0
	else
		meter_overlay.alpha = 0

	if(!active) //We're turned off.
		update_appearance()
		return

	var/amount_to_consume = (gas_consumption_base + (rod_mix.temperature/1000)*gas_consumption_heat) * clamp(1 - (rod_mix_pressure - stored_rod.pressure_limit*0.5)/stored_rod.pressure_limit*0.5,0.25,1)
	if(!amount_to_consume)
		update_appearance()
		return
	amount_to_consume *= (overclocked ? 1.25 : 1)*(0.75 + power_efficiency*0.25)*(obj_flags & EMAGGED ? 10 : 1)

	//Remove gas from the rod to be processed.
	var/datum/gas_mixture/consumed_mix = rod_mix.remove(amount_to_consume)

	//Do power generation here.
	consumed_mix.assert_gas(/datum/gas/tritium)
	if(consumed_mix.gases && consumed_mix.gases[/datum/gas/tritium])
		last_tritium_consumption = consumed_mix.gases[/datum/gas/tritium][MOLES]
		last_power_generation = last_tritium_consumption * power_efficiency * base_power_generation * (overclocked ? 0.9 : 1) //Overclocked consumes more, but generates less.
		//This is where the fun begins.
		// https://www.desmos.com/calculator/ffcsaaftzz
		last_power_generation *= (1 + max(0,(rod_mix.temperature - T0C)/1500)**1.4)*(0.75 + (amount_to_consume/gas_consumption_base)*0.25)*(use_radio ? 1 : 1.05)
		if(meltdown)
			last_radiation_pulse = min( last_power_generation*0.002 ,GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE*2)
			radiation_pulse(src,last_radiation_pulse,threshold = RAD_FULL_INSULATION)
		else
			last_radiation_pulse = min( last_power_generation*0.001 ,GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE)
			radiation_pulse(src,last_radiation_pulse,threshold = RAD_HEAVY_INSULATION)
		if(power && powernet && last_power_generation)
			src.add_avail(last_power_generation)
		consumed_mix.remove_specific(/datum/gas/tritium, last_tritium_consumption*0.50) //50% of used tritium gets deleted. The rest gets thrown into the air.
		var/our_heat_capacity = consumed_mix.heat_capacity()
		if(our_heat_capacity > 0)
			var/temperature_mod = last_power_generation >= max_power_generation ? 4 : 1
			consumed_mix.temperature += (temperature_mod-rand())*8 + (16000/our_heat_capacity)*(overclocked ? 2 : 1)*power_efficiency*temperature_mod

		if(rod_mix_pressure >= stored_rod.pressure_limit*(1 + rand()*0.25)) //Pressure friction penalty.
			rod_mix.temperature += ((rod_mix_pressure/stored_rod.pressure_limit) - 1) * (3/rod_mix_heat_capacity)

	else
		toggle_active(null,FALSE)

	//The gases that we consumed go into the buffer, to be released in the air.
	buffer_gases.merge(consumed_mix)

	//Share the remaining temperature with the rod mix itself.
	transfer_rod_temperature(buffer_gases)

	if(prob(5))
		playsound(src, 'sound/misc/metal_creak.ogg', 50, TRUE, extrarange = -3)

	if(!jammed && safety && (last_power_generation >= safeties_max_power_generation || rod_mix_pressure > stored_rod.pressure_limit*0.9)) //The safety system is very strict. NanoTrasen wants employees to feel safe!
		var/health_percent = atom_integrity/max_integrity
		var/jam_chance = 80 - (health_percent * 100) - (venting ? 0 : 40)
		if(jam_chance > 0 && prob(jam_chance))
			jam(null,TRUE)
		else
			toggle_active(null,FALSE)
			take_damage(3,armour_penetration=100)

	if(rod_mix.temperature > stored_rod.temperature_limit || last_power_generation > max_power_generation*(1.1 + rand()) )
		if(!meltdown)
			log_game("[src] triggered a meltdown at [AREACOORD(T)]")
			investigate_log("triggered a meltdown at [AREACOORD(T)]", INVESTIGATE_ENGINE)
			meltdown = TRUE
			alert_radio("Warning! Excess ionization detected! Reduce power output!")
		var/chosen_sound = pick('modular_zubbers/sound/machines/rbmk2/failure01.ogg','modular_zubbers/sound/machines/rbmk2/failure02.ogg','modular_zubbers/sound/machines/rbmk2/failure03.ogg','modular_zubbers/sound/machines/rbmk2/failure04.ogg')
		playsound(src, chosen_sound, 50, TRUE, extrarange = -3)
		take_damage(2,armour_penetration=100) //Lasts 5 minutes. Probably less due to other factors.
	else if(meltdown && rod_mix.temperature <= stored_rod.temperature_limit*0.75 && last_power_generation <= max_power_generation*0.5) //Hard to get out of a meltdown.
		meltdown = FALSE
		alert_radio("Reactor ionization returning to safe levels.")

	update_appearance()

	return TRUE


/obj/machinery/power/rbmk2/process_atmos() //Only turf air related stuff is handled here.

	var/turf/T = loc
	if(!isturf(T))
		return //wat

	var/datum/gas_mixture/turf_air = T.return_air()

	if(stored_rod && meltdown)
		var/meltdown_multiplier = jammed ? 1 : 0.1 //Tried removing a rod during a meltdown.
		meltdown_multiplier *= last_power_generation/max_power_generation //It just gets worse.
		var/datum/gas_mixture/rod_mix = stored_rod.air_contents
		var/rod_mix_heat_capacity = rod_mix.heat_capacity()
		last_radiation_pulse = min( last_power_generation*0.003*meltdown_multiplier ,GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE*3) //It just keeps getting worse.
		radiation_pulse(src,last_radiation_pulse,threshold = RAD_FULL_INSULATION)
		if(rod_mix_heat_capacity > 0)
			rod_mix.temperature += (rod_mix.temperature*0.02*rand() + (8000/rod_mix_heat_capacity)*(overclocked ? 2 : 1))*meltdown_multiplier //It's... it's not shutting down!
		//take_damage(0.5,armour_penetration=100,sound_effect=FALSE)
		var/ionize_air_amount = min(0.5 + rod_mix.temperature/2000,4)*meltdown_multiplier //For every 3000 kelvin. Capped at 4 tiles.
		var/ionize_air_range = CEILING(ionize_air_amount,1)
		var/total_ion_amount = 0
		for(var/turf/ion_turf as anything in RANGE_TURFS(ionize_air_range,T))
			if(!prob(80)) //Atmos optimization.
				continue
			var/datum/gas_mixture/ion_turf_gases = ion_turf.return_air()
			if(!ion_turf_gases)
				continue
			ion_turf_gases.assert_gas(/datum/gas/oxygen)
			var/datum/gas_mixture/oxygen_removed = ion_turf_gases.remove_specific(/datum/gas/oxygen, ionize_air_amount)
			if(oxygen_removed && oxygen_removed.gases[/datum/gas/oxygen] && oxygen_removed.gases[/datum/gas/oxygen][MOLES] > 0)
				var/ion_amount = oxygen_removed.gases[/datum/gas/oxygen][MOLES] * 0.25
				ion_turf_gases.assert_gas(/datum/gas/tritium)
				ion_turf_gases.gases[/datum/gas/tritium][MOLES] += ion_amount
				total_ion_amount += ion_amount
		var/safe_ionization_amount = ionize_air_amount*ionize_air_range*0.5

		var/criticality_to_add = min(rand(5,8)*(1 - total_ion_amount/safe_ionization_amount),10)
		criticality_to_add = FLOOR(criticality_to_add,1)
		if(criticality >= 100) //It keeps going.
			if(prob(1 + criticality/100)) //The chance to explode. Yes, it's supposed to be this low.
				deconstruct(FALSE)
			else
				criticality += rand(10,60)
				alert_radio("DANGER. DANGER. DANGER. MELTDOWN IN PROGRESS! CRITICALITY: [criticality]%!",bypass_cooldown=TRUE)

		else if(criticality_to_add > 0)
			criticality += criticality_to_add
			if(criticality > 10)
				if(!was_warned)
					alert_radio("Warning! Reactor entering criticality! Reduce power output!")
					was_warned = TRUE
				else
					if(criticality >= 80)
						alert_radio("DANGER! Reactor criticality at [criticality]%!")
					else
						alert_radio("Warning! Reactor criticality at [criticality]%!")
		playsound(src, 'modular_zubbers/sound/machines/rbmk2/ionization.ogg', 50, TRUE, extrarange = ionize_air_range)
	else
		criticality = max(0,criticality-1)
		if(criticality > 5)
			alert_radio("Warning! Reactor criticality at [criticality]%!")
		else if(was_warned)
			alert_radio("Reactor criticality reduced to safe levels.")
			was_warned = FALSE

	if(venting)
		if(vent_reverse_direction)
			turf_air.pump_gas_to(buffer_gases,vent_pressure) //Pump turf gases to buffer.
		else
			if(active)
				buffer_gases.pump_gas_to(turf_air,vent_pressure) //Pump buffer gases to turf. Reduced rate because active.
				transfer_rod_temperature(turf_air,allow_cooling_limiter=TRUE,multiplier=0.5)
			else
				buffer_gases.pump_gas_to(turf_air,vent_pressure*2) //Pump buffer gases to turf. Increases rate because inactive.
				transfer_rod_temperature(turf_air,allow_cooling_limiter=FALSE)
