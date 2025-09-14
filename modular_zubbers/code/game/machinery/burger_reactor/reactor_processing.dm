/obj/machinery/power/rbmk2/process()

	if(stored_rod && (venting || (!active && !jammed)))
		update_appearance(UPDATE_OVERLAYS)

	if(!stored_rod || !active)
		return

	var/turf/T = get_turf(src)

	if(!T)
		return

	var/datum/gas_mixture/rod_mix = stored_rod.air_contents
	var/rod_mix_pressure = rod_mix.return_pressure()
	var/rod_mix_heat_capacity = rod_mix.heat_capacity()

	//Amount of tritium to consume.
	var/amount_to_consume = (gas_consumption_base + (rod_mix.temperature/1000)*gas_consumption_heat) * clamp(1 - (rod_mix_pressure - stored_rod.pressure_limit*0.5)/stored_rod.pressure_limit*0.5,0.25,1)
	if(overclocked)
		amount_to_consume *= 1.25
	if(obj_flags & EMAGGED)
		amount_to_consume *= 10

	//Remove gas from the rod to be processed.
	rod_mix.assert_gas(/datum/gas/tritium)
	var/datum/gas_mixture/consumed_mix = rod_mix.remove_specific(/datum/gas/tritium,amount_to_consume)

	if(!consumed_mix || !consumed_mix.gases || !consumed_mix.gases[/datum/gas/tritium])
		if(meltdown) //If we're melting down, and we run out of tritium, trigger a voidout.
			trigger_voidout()
		else
			toggle_active(null,FALSE)
		return

	//Consume the tritium. Power (and heat) is generated based on how much is consumed.
	consumed_mix.assert_gas(/datum/gas/tritium)
	last_tritium_consumption = consumed_mix.gases[/datum/gas/tritium][MOLES]
	last_power_generation = last_tritium_consumption * power_efficiency * base_power_generation * (overclocked ? 0.9 : 1) //Overclocked consumes more, but generates less.

	//This is where the fun begins.
	// https://www.desmos.com/calculator/ffcsaaftzz
	last_power_generation *= (1 + max(0,(rod_mix.temperature - T0C)/1500)**1.4)*(0.75 + (amount_to_consume/gas_consumption_base)*0.25)

	var/range_cap = CEILING(GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE * 0.5, 1)
	if(meltdown)
		last_radiation_pulse = min( last_power_generation*0.002, range_cap) //Double the rads, double the fun.
	else
		last_radiation_pulse = min( last_power_generation*0.001, range_cap)

	//The LOWER the insulation_threshold, the stronger the radiation can penetrate.
	//Values closer to the maximum range penetrate the most.
	var/insulation_threshold_math = (range_cap - last_radiation_pulse) / range_cap
	if(insulation_threshold_math <= RAD_LIGHT_INSULATION) //Don't bother making radiation if it isn't significant enough.
		if(meltdown)
			insulation_threshold_math = max(insulation_threshold_math - 0.25, RAD_FULL_INSULATION) //Go as low as possible. Nothing is safe from the RBMK.
		else
			insulation_threshold_math = max(insulation_threshold_math, RAD_EXTREME_INSULATION) //Don't go under RAD_EXTREME_INSULATION
		radiation_pulse(src,last_radiation_pulse, threshold = insulation_threshold_math)

	consumed_mix.remove_specific(/datum/gas/tritium, last_tritium_consumption*0.50) //50% of used tritium gets deleted. The rest gets thrown into the air.
	var/our_heat_capacity = consumed_mix.heat_capacity()
	if(our_heat_capacity > 0)
		var/temperature_mod = last_power_generation >= max_power_generation ? 4 : 1

		//In order to directly power the supermatter, at least 30 moles of hyper-noblium is required (does not get consumed).
		if(linked_supermatter)
			rod_mix.assert_gas(/datum/gas/hypernoblium)
			if(rod_mix.gases[/datum/gas/hypernoblium][MOLES] >= 30)
				linked_supermatter.external_power_immediate += last_power_generation*0.0075
				temperature_mod *= 0.1
				last_power_generation = 0
				goblin_multiplier *= 10

		consumed_mix.assert_gas(/datum/gas/goblin)
		consumed_mix.gases[/datum/gas/goblin][MOLES] += last_tritium_consumption*goblin_multiplier
		consumed_mix.temperature += max(0,temperature_mod-rand())*8 + (16000/our_heat_capacity)*(overclocked ? 2 : 1)*power_efficiency*temperature_mod*0.5*(1/(vent_pressure/200))
		consumed_mix.temperature = clamp(consumed_mix.temperature,5,0xFFFFFF)

	if(rod_mix_pressure >= stored_rod.pressure_limit*(1 + rand()*0.25)) //Pressure friction penalty.
		rod_mix.temperature += (min(rod_mix_pressure/stored_rod.pressure_limit,4) - 1) * (3/rod_mix_heat_capacity)
		rod_mix.temperature = clamp(rod_mix.temperature,5,0xFFFFFF)


	//The gases that we consumed go into the buffer, to be released in the air.
	buffer_gases.merge(consumed_mix)

	//Share the remaining temperature with the rod mix itself.
	transfer_rod_temperature(buffer_gases)

	if(prob(5))
		playsound(src, 'sound/misc/metal_creak.ogg', 50, TRUE, extrarange = -3)

	if(!jammed && safety && (last_power_generation >= safeties_max_power_generation || rod_mix_pressure > stored_rod.pressure_limit*0.9)) //The safety system is very strict. Nanotrasen wants employees to feel safe!
		var/health_percent = atom_integrity/max_integrity
		var/jam_chance = 80 - (health_percent * 100) - (venting ? 0 : 40)
		if(jam_chance > 0 && prob(jam_chance))
			jam(null,TRUE)
		else
			toggle_active(null,FALSE)
			take_damage(3,armour_penetration=100)
			src.Shake(duration=0.5 SECONDS)

	if(active && rod_mix.temperature > stored_rod.temperature_limit || last_power_generation > max_power_generation*(1.1 + rand()) )
		if(!meltdown)
			log_game("[src] triggered a meltdown at [AREACOORD(T)]")
			investigate_log("triggered a meltdown at [AREACOORD(T)]", INVESTIGATE_ENGINE)
			meltdown = TRUE
		var/chosen_sound = pick('modular_zubbers/sound/machines/rbmk2/failure01.ogg','modular_zubbers/sound/machines/rbmk2/failure02.ogg','modular_zubbers/sound/machines/rbmk2/failure03.ogg','modular_zubbers/sound/machines/rbmk2/failure04.ogg')
		playsound(src, chosen_sound, 50, TRUE, extrarange = -3)
		var/damage_to_deal = clamp( last_power_generation / max_power_generation, 1, 10)
		take_damage(damage_to_deal,armour_penetration=100)
		src.Shake(duration=0.5 SECONDS)
	else if(meltdown && rod_mix.temperature <= stored_rod.temperature_limit*0.75 && last_power_generation <= max_power_generation*0.75) //Hard to get out of a meltdown. Needs that 25% buffer.
		meltdown = FALSE

	if(!linked_supermatter && power && powernet && last_power_generation > 0)
		if(last_power_generation >= max_power_generation*5)
			last_power_generation *= rand()*0.25 // (Mostly) stops crazy power generation from happening.
		src.add_avail(last_power_generation)

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
		if(rod_mix_heat_capacity > 0)
			rod_mix.temperature += (rod_mix.temperature*0.02*rand() + (8000/rod_mix_heat_capacity)*(overclocked ? 2 : 1))*meltdown_multiplier //It's... it's not shutting down!
			rod_mix.temperature = clamp(rod_mix.temperature,5,0xFFFFFF)
		var/ionize_air_amount = min( (0.5 + rod_mix.temperature/2000) * meltdown_multiplier, 5) //For every 2000 kelvin. Capped at 5 tiles.
		var/ionize_air_range = CEILING(ionize_air_amount,1)
		var/total_ion_amount = 0
		for(var/turf/ion_turf as anything in RANGE_TURFS(ionize_air_range,T))
			if(!prob(80)) //Atmos optimization.
				continue
			var/datum/gas_mixture/ion_turf_mix = ion_turf.return_air()
			if(!ion_turf_mix || !ion_turf_mix.gases || !ion_turf_mix.gases[/datum/gas/oxygen] || !ion_turf_mix.gases[/datum/gas/oxygen][MOLES])
				continue
			ion_turf_mix.assert_gas(/datum/gas/oxygen)
			var/gas_to_convert = max(0,min(ionize_air_amount,ion_turf_mix.gases[/datum/gas/oxygen][MOLES] - rand(20,30)))
			if(gas_to_convert <= 0)
				continue
			var/datum/gas_mixture/oxygen_removed_mix = ion_turf_mix.remove_specific(/datum/gas/oxygen, ionize_air_amount)
			if(oxygen_removed_mix && oxygen_removed_mix.gases[/datum/gas/oxygen] && oxygen_removed_mix.gases[/datum/gas/oxygen][MOLES] > 0)
				var/ion_amount = oxygen_removed_mix.gases[/datum/gas/oxygen][MOLES] * 0.25
				ion_turf_mix.assert_gas(/datum/gas/tritium)
				ion_turf_mix.gases[/datum/gas/tritium][MOLES] += ion_amount
				total_ion_amount += ion_amount

		var/ionization_amount_ratio = total_ion_amount/ionize_air_amount
		var/criticality_to_add = min(ionization_amount_ratio,3) * rand()
		if(criticality_to_add > 0)
			criticality_to_add = FLOOR(criticality_to_add,0.01)
			if(criticality >= 100) //It keeps going.
				if(prob(criticality/200)) //The chance to explode.
					deconstruct(FALSE)
				else
					criticality += rand(criticality_to_add*4,criticality_to_add*10)
			else
				criticality += criticality_to_add

		playsound(src, 'modular_zubbers/sound/machines/rbmk2/ionization.ogg', 50, TRUE, extrarange = ionize_air_range)
	else
		criticality = max(0,criticality-1)

	if(venting)
		if(vent_reverse_direction)
			turf_air.pump_gas_to(buffer_gases,vent_pressure) //Pump turf gases to buffer.
		else
			if(active)
				buffer_gases.pump_gas_to(turf_air,vent_pressure) //Pump buffer gases to turf. Reduced rate because active.
				if(stored_rod) transfer_rod_temperature(turf_air,allow_cooling_limiter=TRUE,multiplier=min(1,0.5*(vent_pressure/200)))
			else
				buffer_gases.pump_gas_to(turf_air,vent_pressure*2) //Pump buffer gases to turf. Increases rate because inactive.
				if(stored_rod) transfer_rod_temperature(turf_air,allow_cooling_limiter=FALSE)
