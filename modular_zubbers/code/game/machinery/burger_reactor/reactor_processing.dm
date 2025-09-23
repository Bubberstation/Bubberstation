/obj/machinery/power/rbmk2/process()

	if(stored_rod && (venting || (!active && !jammed)))
		update_appearance(UPDATE_OVERLAYS)

	if(!stored_rod || !(active || meltdown))
		return

	var/datum/gas_mixture/rod_mix = stored_rod.air_contents

	//Amount of tritium to consume, in micromoles
	var/amount_to_consume = (gas_consumption_base) + (rod_mix.temperature/1000)*(gas_consumption_heat)
	if(active)
		if(overclocked)
			amount_to_consume *= 1.25
		if(obj_flags & EMAGGED)
			amount_to_consume *= 4
	else
		amount_to_consume *= 0.1

	if(meltdown && meltdown_start_time > 0)
		//Tritium consumption will increase by 100% every 45 seconds after 120 seconds of meltdown time.
		var/meltdown_penalty_math = ((world.time - meltdown_start_time) - (120 SECONDS)) / (45 SECONDS)
		if(meltdown_penalty_math > 1)
			amount_to_consume *= meltdown_penalty_math

	//Remove gas from the rod to be processed.
	rod_mix.assert_gas(/datum/gas/tritium)
	var/datum/gas_mixture/consumed_mix = rod_mix.remove_specific(/datum/gas/tritium,amount_to_consume/1000000)
	if(consumed_mix)
		consumed_mix.assert_gas(/datum/gas/tritium)
	if(!consumed_mix || !consumed_mix.gases || !consumed_mix.gases[/datum/gas/tritium])
		if(meltdown) //If we're melting down, and we run out of tritium, trigger a voidout.
			trigger_voidout()
		else
			toggle_active(null,FALSE)
		return
	last_tritium_consumption = consumed_mix.gases[/datum/gas/tritium][MOLES]
	var/last_tritium_consumption_as_moles = last_tritium_consumption
	last_tritium_consumption *= 1000000 //Converts this back to micromoles

	if(consumed_mix && last_tritium_consumption > 0)

		last_power_generation = (base_power_generation * last_tritium_consumption) * power_efficiency
		last_power_generation = clamp(last_power_generation,0,max_power_generation*10)

		var/range_cap = CEILING(GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE * 0.5, 1)
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

		consumed_mix.remove_specific(/datum/gas/tritium, last_tritium_consumption_as_moles) //50% of used tritium gets deleted. The rest gets thrown into the air.

		//Supermatter interaction here.
		//In order to directly power the supermatter, at least 30 moles of hyper-noblium is required (does not get consumed).
		if(linked_supermatter)
			rod_mix.assert_gas(/datum/gas/hypernoblium)
			if(rod_mix.gases[/datum/gas/hypernoblium][MOLES] >= 30)
				linked_supermatter.external_power_immediate += last_power_generation*0.0075
				last_power_generation = 0

		//Create the goblin gas and increase the temperature.
		consumed_mix.assert_gas(/datum/gas/goblin)
		consumed_mix.gases[/datum/gas/goblin][MOLES] += last_tritium_consumption_as_moles*goblin_multiplier
		var/our_heat_capacity = consumed_mix.heat_capacity()
		if(our_heat_capacity > 0)
			var/temperature_mod = clamp(1.25 - consumed_mix.temperature/1500,0.25,1)
			var/temperature_to_add = (last_power_generation/our_heat_capacity)*(1 + overclocked)*(0.75 + power_efficiency*0.25)*0.6*temperature_mod
			last_power_generation *= temperature_mod
			consumed_mix.temperature += temperature_to_add
			consumed_mix.temperature = clamp(consumed_mix.temperature,5,0xFFFFFF)

		//The gases that we consumed go into the buffer. This is released in the air later in the atmos proc.
		buffer_gases.merge(consumed_mix)

	if(prob(5))
		playsound(src, 'sound/misc/metal_creak.ogg', 50, TRUE, extrarange = -3)

	if(!jammed && safety && last_power_generation >= safeties_max_power_generation) //The safety system is very strict. Nanotrasen wants employees to feel safe!
		var/health_percent = atom_integrity/max_integrity
		var/jam_chance = 80 - (health_percent * 100) - (venting ? 0 : 40)
		if(jam_chance > 0 && prob(jam_chance))
			jam(null,TRUE)
		else
			toggle_active(null,FALSE)
			take_damage(3,armour_penetration=100)
			src.Shake(duration=0.5 SECONDS)

	if(active && rod_mix.temperature > stored_rod.temperature_limit || last_power_generation > max_power_generation )
		if(!meltdown)
			log_game("[src] triggered a meltdown at [AREACOORD(src)]")
			investigate_log("triggered a meltdown at [AREACOORD(src)]", INVESTIGATE_ENGINE)
			meltdown = TRUE
			meltdown_start_time = world.time
			update_appearance(UPDATE_ICON)
		var/chosen_sound = pick('modular_zubbers/sound/machines/rbmk2/failure01.ogg','modular_zubbers/sound/machines/rbmk2/failure02.ogg','modular_zubbers/sound/machines/rbmk2/failure03.ogg','modular_zubbers/sound/machines/rbmk2/failure04.ogg')
		playsound(src, chosen_sound, 50, TRUE)
		take_damage(clamp( last_power_generation / max_power_generation, 1, 10),armour_penetration=100)
		src.Shake(duration=0.5 SECONDS)
	else if(meltdown && rod_mix.temperature <= stored_rod.temperature_limit*0.75 && last_power_generation <= max_power_generation*0.75) //Hard to get out of a meltdown. Needs that 25% buffer.
		meltdown = FALSE
		meltdown_start_time = 0
		update_appearance(UPDATE_ICON)

	if(!linked_supermatter && power && powernet && last_power_generation > 0)
		if(last_power_generation >= max_power_generation*5)
			last_power_generation *= rand()*0.25 // (Mostly) stops crazy power generation from happening.
			last_power_generation_bonus = 0
		else if(last_power_generation >= safeties_max_power_generation)
			last_power_generation_bonus = (last_power_generation/safeties_max_power_generation - 1) * last_power_generation

		src.add_avail(last_power_generation + last_power_generation_bonus)

	return TRUE


/obj/machinery/power/rbmk2/process_atmos() //Only turf air related stuff is handled here.

	if(!src.loc) //nullspace
		return

	var/datum/gas_mixture/turf_air = src.loc.return_air()
	if(stored_rod && meltdown)
		var/turf/T = get_turf(src)
		if(T && !prob(80)) //Atmos optimization
			var/meltdown_multiplier = last_power_generation/max_power_generation //It just gets worse.
			var/datum/gas_mixture/rod_mix = stored_rod.air_contents
			var/ionize_air_amount = min( (0.5 + rod_mix.temperature/2000) * meltdown_multiplier, 5) //For every 2000 kelvin. Capped at 5 tiles.
			var/ionize_air_range = CEILING(ionize_air_amount,1)
			var/total_ion_amount = 0
			for(var/turf/ion_turf as anything in RANGE_TURFS(ionize_air_range,T))
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
		if(jammed) //50% inside
			if(vent_reverse_direction)
				turf_air.pump_gas_to(buffer_gases,vent_pressure*0.5) //Pump turf gases to buffer. Reduced rate because jammed.
			else
				buffer_gases.pump_gas_to(turf_air,vent_pressure*0.5) //Pump buffer gases to turf. Reduced rate because jammed.
			if(stored_rod)
				transfer_rod_temperature(buffer_gases,multiplier=0.5)
				transfer_rod_temperature(turf_air,multiplier=0.5,allow_cooling_limiter=TRUE)
		else if(active) //100% inside.
			if(vent_reverse_direction)
				turf_air.pump_gas_to(buffer_gases,vent_pressure) //Pump turf gases to buffer.
			else
				buffer_gases.pump_gas_to(turf_air,vent_pressure) //Pump buffer gases to turf.
			if(stored_rod)
				transfer_rod_temperature(buffer_gases)
				transfer_rod_temperature(turf_air,multiplier=0.5,allow_cooling_limiter=TRUE)
		else //0% inside
			if(vent_reverse_direction)
				turf_air.pump_gas_to(buffer_gases,vent_pressure*2) //Pump turf gases to buffer. Increased rate because exposed.
			else
				buffer_gases.pump_gas_to(turf_air,vent_pressure*2) //Pump buffer gases to turf. Increased rate because exposed.
			if(stored_rod)
				//No buffer gas interaction here.
				transfer_rod_temperature(turf_air,allow_cooling_limiter=FALSE)

