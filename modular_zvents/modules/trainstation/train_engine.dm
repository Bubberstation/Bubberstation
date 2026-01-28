/// Минимальное давление газов, проходящих через турбину
#define MINIMUM_TURBINE_PRESSURE 0.01
/// Возвращает максимальное давление, если оно ниже значения
#define PRESSURE_MAX(value) (max((value), MINIMUM_TURBINE_PRESSURE))
/// Минимальная температура для горячего пара (в Кельвинах, >373K для кипения воды)
#define MIN_STEAM_TEMPERATURE 400

// Базовый класс для частей турбины поезда
/obj/machinery/power/train_turbine
	name = "train turbine part"
	desc = "Part of a steam-fed train turbine. Consists of inlet, core, and outlet. Uses hot water vapor, outputs CO2 to atmosphere and cooled water through liquid pipe."
	icon = 'icons/obj/machines/engine/turbine.dmi'
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY

	/// Эффективность этой части (от апгрейдов)
	var/efficiency = 0.5
	/// Установленная часть (если есть апгрейды)
	var/obj/item/turbine_parts/installed_part
	/// Путь к части для установки
	var/obj/item/turbine_parts/part_path
	/// Внутренняя газовая смесь
	var/datum/gas_mixture/machine_gasmix
	/// Объем газа
	var/gas_theoretical_volume = 1000  // Базовый, переопределяется

	/// Ссылка на ядро (для всех частей)
	var/obj/machinery/power/train_turbine/core_rotor/rotor

/obj/machinery/power/train_turbine/Initialize(mapload)
	. = ..()
	machine_gasmix = new()
	machine_gasmix.volume = gas_theoretical_volume

	if(mapload && part_path)
		installed_part = new part_path(src)
		efficiency = installed_part?.get_tier_value(TURBINE_MAX_EFFICIENCY) || efficiency

	air_update_turf(TRUE)
	update_appearance(UPDATE_OVERLAYS)
	register_context()

/obj/machinery/power/train_turbine/Destroy()
	air_update_turf(TRUE)
	QDEL_NULL(installed_part)
	QDEL_NULL(machine_gasmix)
	if(rotor)
		rotor.deactivate_parts()
	return ..()

/obj/machinery/power/train_turbine/proc/is_active()
	return rotor?.active || FALSE

/obj/machinery/power/train_turbine/proc/transfer_gases(datum/gas_mixture/input_mix, datum/gas_mixture/output_mix, work_amount_to_remove = 0, intake_size = 1)
	var/output_pressure = PRESSURE_MAX(output_mix.return_pressure())
	var/datum/gas_mixture/transferred_gases = input_mix.pump_gas_to(output_mix, input_mix.return_pressure() * intake_size)
	if(!transferred_gases)
		return 0

	var/work_done = QUANTIZE(transferred_gases.total_moles()) * R_IDEAL_GAS_EQUATION * transferred_gases.temperature * log((transferred_gases.volume * PRESSURE_MAX(transferred_gases.return_pressure())) / (output_mix.volume * output_pressure)) * TURBINE_WORK_CONVERSION_MULTIPLIER
	if(work_amount_to_remove)
		work_done -= work_amount_to_remove

	var/output_mix_heat_capacity = output_mix.heat_capacity()
	if(!output_mix_heat_capacity)
		return 0
	work_done = min(work_done, (output_mix_heat_capacity * output_mix.temperature - output_mix_heat_capacity * TCMB) / TURBINE_HEAT_CONVERSION_MULTIPLIER)
	output_mix.temperature = max((output_mix.temperature * output_mix_heat_capacity + work_done * TURBINE_HEAT_CONVERSION_MULTIPLIER) / output_mix_heat_capacity, TCMB)
	return work_done

// ====================================================================
// Входная часть: Inlet Compressor
// ====================================================================
/obj/machinery/power/train_turbine/inlet_compressor
	name = "train turbine inlet compressor"
	desc = "Inlet part of the train turbine. Connects to pipes for hot water vapor intake."
	icon_state = "inlet_compressor"
	base_icon_state = "inlet_compressor"
	// circuit = /obj/item/circuitboard/machine/train_turbine_inlet
	part_path = /obj/item/turbine_parts/compressor
	gas_theoretical_volume = 1000

	/// Регулятор впуска (0.01 - 1)
	var/intake_regulator = 0.5
	/// Работа компрессора на текущем тике
	var/compressor_work = 0
	/// Давление после компрессора
	var/compressor_pressure = MINIMUM_TURBINE_PRESSURE
	/// Atmos connector для труб
	var/datum/gas_machine_connector/connector

/obj/machinery/power/train_turbine/inlet_compressor/post_machine_initialize()
	. = ..()
	var/connector_dir = REVERSE_DIR(dir)
	connector = new(loc, src, connector_dir, CELL_VOLUME * 0.5)
	connector.gas_connector.dir = connector_dir
	connector.gas_connector.initialize_directions = connector_dir

/obj/machinery/power/train_turbine/inlet_compressor/Destroy()
	QDEL_NULL(connector)
	return ..()

/obj/machinery/power/train_turbine/inlet_compressor/proc/compress_gases()
	compressor_work = 0
	compressor_pressure = MINIMUM_TURBINE_PRESSURE

	if(!connector)
		return 0

	var/datum/gas_mixture/pipe_mix = connector.gas_connector.airs[1]
	if(!pipe_mix)
		return 0

	var/has_steam = pipe_mix.has_gas(/datum/gas/water_vapor, 1)
	var/temperature = pipe_mix.temperature
	if(!has_steam || temperature < MIN_STEAM_TEMPERATURE)
		return 0

	compressor_work = transfer_gases(pipe_mix, machine_gasmix, intake_size = intake_regulator)
	compressor_pressure = PRESSURE_MAX(machine_gasmix.return_pressure())

	return temperature

// ====================================================================
// Ядро: Core Rotor
// ====================================================================

/datum/looping_sound/turbine_loop
	mid_sounds = 'modular_zvents/sounds/turbine_loop.ogg'
	mid_length = 3 SECONDS
	volume = 60
	falloff_exponent = 3

/obj/machinery/power/train_turbine/core_rotor
	name = "train turbine core rotor"
	desc = "Core part of the train turbine. Controls RPM, temperature, and power."
	icon_state = "core_rotor"
	base_icon_state = "core_rotor"
	// circuit = /obj/item/circuitboard/machine/train_turbine_core
	part_path = /obj/item/turbine_parts/rotor
	gas_theoretical_volume = 3000

	var/active = FALSE
	var/rpm = 0
	var/max_rpm = 7000
	var/produced_energy = 0
	var/max_temperature = 1000
	var/efficiency_rate = 50
	var/damage = 0
	var/damage_archived = 0
	var/all_parts_connected = FALSE

	var/steam_consumption_rate = 0.1
	var/water_production_rate = 0.1

	/// Целевые обороты в % от максимума (0-1). Управляется из UI.
	var/target_rpm = 0

	var/datum/looping_sound/turbine_loop/soundloop
	/// Ссылки на части
	var/obj/machinery/power/train_turbine/inlet_compressor/compressor
	var/obj/machinery/power/train_turbine/turbine_outlet/turbine

	COOLDOWN_DECLARE(turbine_damage_alert)
	COOLDOWN_DECLARE(turbine_effects_update)

/obj/machinery/power/train_turbine/core_rotor/Initialize(mapload)
	. = ..()
	new /obj/item/paper/guides/jobs/atmos/train_turbine(loc)
	SStrain_controller.train_engine = src
	soundloop = new(src)
	connect_to_network()

/obj/machinery/power/train_turbine/core_rotor/Destroy()
	. = ..()
	SStrain_controller.train_engine = null
	QDEL_NULL(soundloop)

/obj/machinery/power/train_turbine/core_rotor/post_machine_initialize()
	. = ..()
	activate_parts()

/obj/machinery/power/train_turbine/core_rotor/begin_processing()
	. = ..()
	soundloop.start()

/obj/machinery/power/train_turbine/core_rotor/end_processing()
	. = ..()
	soundloop.stop()

/obj/machinery/power/train_turbine/core_rotor/is_active()
	return active

/obj/machinery/power/train_turbine/core_rotor/multitool_act(mob/living/user, obj/item/multitool/multitool)
	. = ITEM_INTERACT_FAILURE
	multitool.buffer = src
	activate_parts(user)
	balloon_alert(user, "You store the [src] in the [multitool]'s buffer.")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/train_turbine/core_rotor/proc/update_effects()
	var/work_procentage = clamp(rpm / (max_rpm * 0.9), 0, 1)
	if(work_procentage >= 0.85 && soundloop.volume != 70)
		soundloop.volume = 100
		soundloop.extra_range = 10
	else if(work_procentage >= 0.4 && soundloop.volume != 50)
		soundloop.volume = 60
		soundloop.extra_range = 5
	else if(work_procentage >= 0.2 && soundloop.volume != 30)
		soundloop.volume = 40
		soundloop.extra_range = 0
	else
		soundloop.extra_range = 0

	if(work_procentage >= 0.95)
		Shake(2, 1, 3 SECONDS)
		compressor.Shake(2, 1, 3 SECONDS)
		turbine.Shake(2, 1, 3 SECONDS)

/obj/machinery/power/train_turbine/core_rotor/process(seconds_per_tick)
	if((!active || !all_parts_connected || !powered(ignore_use_power = TRUE)) && rpm <= 0)
		deactivate_parts()
		return PROCESS_KILL
	var/target_flow_multiplier = target_rpm / max_rpm
	var/inlet_temperature = compressor.compress_gases()
	if(!inlet_temperature || inlet_temperature < MIN_STEAM_TEMPERATURE)
		rpm = max(rpm - 400 * seconds_per_tick, 0)
		produced_energy = 0
		return

	var/datum/gas_mixture/compressor_gas = compressor.machine_gasmix
	var/available_steam = compressor_gas.gases[/datum/gas/water_vapor]?[MOLES] || 0

	if(available_steam < 0.05)
		rpm = max(rpm - 500 * seconds_per_tick, 0)
		produced_energy = 0
		return

	var/max_flow = steam_consumption_rate * compressor.intake_regulator * 10
	var/steam_consumed = min(available_steam, (max_flow * seconds_per_tick * target_flow_multiplier) * steam_consumption_rate)

	compressor_gas.gases[/datum/gas/water_vapor][MOLES] -= steam_consumed
	compressor_gas.garbage_collect()

	var/base_power = 0

	var/temp_bonus = max(inlet_temperature - MIN_STEAM_TEMPERATURE, 0)
	var/flow_bonus = max_flow * 600
	var/steam_bonus = steam_consumed * 150
	base_power += temp_bonus
	base_power += flow_bonus
	base_power += steam_bonus

	var/total_efficiency = (compressor.efficiency + efficiency + turbine.efficiency) / 3
	base_power *= total_efficiency

	// rpm increases based on pressure and target modifies it up to a degree
	var/rpm_change = base_power - rpm
	rpm += rpm_change * 0.1
	// modify it towards target rpm
	rpm = lerp(rpm, target_rpm, 0.05)
	// output is only based on current rpm
	produced_energy = rpm * efficiency_rate * total_efficiency
	turbine.produce_water(steam_consumed * water_production_rate * 0.9)
	machine_gasmix.temperature = lerp(machine_gasmix.temperature, inlet_temperature * 0.8 + T20C * 0.2, 0.05)

	var/overheat = max(machine_gasmix.temperature - max_temperature, 0)
	if(overheat > 0)
		damage += overheat * 0.02 * seconds_per_tick
		if(damage > damage_archived + 1 && COOLDOWN_FINISHED(src, turbine_damage_alert))
			COOLDOWN_START(src, turbine_damage_alert, 10 SECONDS)
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE)
			balloon_alert_to_viewers("overheating! integrity [get_integrity()]%")
	var/safe_threshold = max_rpm * 0.9
	if(rpm > safe_threshold)
		damage += (rpm - safe_threshold) * 0.001 * seconds_per_tick
		if(damage > damage_archived + 1 && COOLDOWN_FINISHED(src, turbine_damage_alert))
			COOLDOWN_START(src, turbine_damage_alert, 10 SECONDS)
			playsound(src, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE)
			balloon_alert_to_viewers("high RPM! integrity [get_integrity()]%")

	if(COOLDOWN_FINISHED(src, turbine_effects_update))
		COOLDOWN_START(src, turbine_effects_update, 3 SECONDS)
		update_effects()

	if(get_integrity() <= 0)
		explosion(src, devastation_range = 0, heavy_impact_range = 2, light_impact_range = 4)
		deactivate_parts()
		qdel(src)
		return PROCESS_KILL


	add_avail(produced_energy)
	apply_thrust_to_train()

/obj/machinery/power/train_turbine/core_rotor/get_integrity()
	return max(round(100 - (damage / 500) * 100, 0.01), 0)

/obj/machinery/power/train_turbine/core_rotor/proc/activate_parts(mob/user, check_only = FALSE)
	if(!check_only)
		compressor = locate() in orange(1, src)
		turbine = locate() in orange(1, src)

	if(QDELETED(compressor) || QDELETED(turbine))
		balloon_alert(user, "missing parts!")
		return FALSE
	target_rpm = min(target_rpm, max_rpm)
	all_parts_connected = TRUE
	if(!check_only)
		compressor.rotor = src
		turbine.rotor = src
		max_temperature = 1000 + installed_part?.get_tier_value(TURBINE_MAX_TEMP) * 0.1 || 0
		max_rpm = 5950 + installed_part?.get_tier_value(TURBINE_MAX_RPM) * 0.001 || 0
		efficiency = (compressor.efficiency + turbine.efficiency) / 3

	return TRUE

/obj/machinery/power/train_turbine/core_rotor/proc/deactivate_parts()
	active = FALSE
	all_parts_connected = FALSE
	rpm = 0
	produced_energy = 0
	compressor?.rotor = null
	turbine?.rotor = null
	compressor = null
	turbine = null
	end_processing()

/obj/machinery/power/train_turbine/core_rotor/proc/toggle_power(force_off = FALSE)
	if(force_off || active)
		if(!active)
			return
		active = FALSE
		end_processing()
	else
		if(!activate_parts(check_only = TRUE))
			return
		active = TRUE
		begin_processing()
	update_appearance(UPDATE_OVERLAYS)
	compressor?.update_appearance(UPDATE_OVERLAYS)
	turbine?.update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/train_turbine/core_rotor/proc/emergency_vent()
	if(!active || !turbine)
		return
/*
	if(full_dump)
		rpm *= 0.5  // Резкое падение оборотов
		balloon_alert_to_viewers("emergency vent activated!")
*/

/obj/machinery/power/train_turbine/core_rotor/proc/apply_thrust_to_train()


// ====================================================================
// Выходная часть: Turbine Outlet
// ====================================================================
/obj/machinery/power/train_turbine/turbine_outlet
	name = "train turbine outlet"
	desc = "Outlet part of the train turbine. Expels CO2 to the turf and cooled water through plumbing pipe."
	icon_state = "inlet_compressor"
	base_icon_state = "inlet_compressor"
	// circuit = /obj/item/circuitboard/machine/train_turbine_outlet
	part_path = /obj/item/turbine_parts/stator
	gas_theoretical_volume = 6000

	var/turf/open/output_turf
	var/datum/component/plumbing/steam_turbine/plumbing
	var/datum/reagents/internal_reagents

/obj/machinery/power/train_turbine/turbine_outlet/Initialize(mapload)
	. = ..()
	internal_reagents = new(1000)
	internal_reagents.my_atom = src

	reagents = internal_reagents
	plumbing = AddComponent(/datum/component/plumbing/steam_turbine, custom_receiver = internal_reagents)
	plumbing.enable()

/obj/machinery/power/train_turbine/turbine_outlet/Destroy()
	QDEL_NULL(plumbing)
	QDEL_NULL(internal_reagents)
	return ..()

/obj/machinery/power/train_turbine/turbine_outlet/proc/produce_water(amount)
	internal_reagents.add_reagent(/datum/reagent/water, amount)
	if(plumbing && internal_reagents.has_reagent(/datum/reagent/water, 10))
		internal_reagents.remove_reagent(/datum/reagent/water, 10)
		plumbing.reagents.add_reagent(/datum/reagent/water, 10)


/datum/component/plumbing/steam_turbine
	demand_connects = NORTH | SOUTH

/datum/component/plumbing/steam_turbine/Initialize(start, ducting_layer, turn_connects, datum/reagents/custom_receiver, extend_pipe_to_edge)
	. = ..()
	if(!istype(parent, /obj/machinery/power/train_turbine/turbine_outlet))
		return COMPONENT_INCOMPATIBLE
	var/obj/machinery/power/train_turbine/turbine_outlet/turbine = parent
	reagents = turbine.internal_reagents

// ====================================================================
// Компьютер управления
// ====================================================================
/obj/machinery/computer/train_turbine_computer
	name = "train turbine control computer"
	desc = "Computer to control the train's steam turbine. Monitor RPM, temperature, and more like a Barotrauma nuclear reactor."
	icon_screen = "train_turbine_comp"
	icon_keyboard = "tech_key"
	// circuit = /obj/item/circuitboard/computer/train_turbine_computer
	var/datum/weakref/rotor_ref
	var/mapping_id

/obj/machinery/computer/train_turbine_computer/post_machine_initialize()
	. = ..()
	if(!mapping_id)
		return
	for(var/obj/machinery/power/train_turbine/core_rotor/main as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/train_turbine/core_rotor))
		if(main.id_tag != mapping_id)
			continue
		register_machine(main)
		break

/obj/machinery/computer/train_turbine_computer/multitool_act(mob/living/user, obj/item/multitool/multitool)
	. = ITEM_INTERACT_FAILURE
	if(!istype(multitool.buffer, /obj/machinery/power/train_turbine/core_rotor))
		to_chat(user, span_notice("Wrong machine type in [multitool] buffer..."))
		return
	if(rotor_ref)
		to_chat(user, span_notice("Changing [src] bluespace network..."))
	if(!do_after(user, 0.2 SECONDS, src))
		return

	playsound(get_turf(user), 'sound/machines/click.ogg', 10, TRUE)
	register_machine(multitool.buffer)
	to_chat(user, span_notice("You link [src] to the console in [multitool]'s buffer."))
	return ITEM_INTERACT_SUCCESS

/obj/machinery/computer/train_turbine_computer/proc/register_machine(obj/machinery/power/train_turbine/core_rotor/machine)
	rotor_ref = WEAKREF(machine)

/obj/machinery/computer/train_turbine_computer/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainTurbineComputer", name)
		ui.open()

/obj/machinery/computer/train_turbine_computer/ui_data(mob/user)
	. = list()

	var/obj/machinery/power/train_turbine/core_rotor/main_control = rotor_ref?.resolve()
	if(QDELETED(main_control) || !main_control.all_parts_connected)
		.["connected"] = FALSE
		return
	var/datum/gas_mixture/pipe_mix = main_control.compressor?.connector?.gas_connector?.airs[1]
	.["compressor_too_cold"] = pipe_mix.temperature < MIN_STEAM_TEMPERATURE || FALSE
	.["connected"] = TRUE
	.["active"] = main_control.active
	.["rpm"] = main_control.rpm
	.["power"] = energy_to_power(main_control.produced_energy)
	.["integrity"] = main_control.get_integrity()
	.["max_rpm"] = main_control.max_rpm
	.["max_temperature"] = main_control.max_temperature

	// Температуры по стадиям
	.["inlet_temp"] = main_control.compressor?.machine_gasmix?.temperature || T20C
	.["rotor_temp"] = main_control.machine_gasmix?.temperature || T20C
	.["outlet_temp"] = main_control.turbine?.machine_gasmix?.temperature || T20C

	// Давления по стадиям
	.["compressor_pressure"] = main_control.compressor?.compressor_pressure || MINIMUM_TURBINE_PRESSURE
	.["rotor_pressure"] = main_control.machine_gasmix?.return_pressure() || MINIMUM_TURBINE_PRESSURE
	.["outlet_water_volume"] = main_control.turbine?.internal_reagents.total_volume || 0

	.["regulator"] = main_control.compressor?.intake_regulator || 0.5
	.["target_rpm"] = main_control.target_rpm
	.["steam_consumption"] = main_control.steam_consumption_rate
	.["water_production"] = main_control.water_production_rate

/obj/machinery/computer/train_turbine_computer/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/obj/machinery/power/train_turbine/core_rotor/main_control = rotor_ref?.resolve()
	if(!main_control)
		return FALSE

	switch(action)
		if("toggle_power")
			if(!main_control.active)
				if(!main_control.activate_parts(usr, check_only = TRUE))
					return FALSE
			else if(main_control.rpm > 0)
				return FALSE
			main_control.toggle_power()
			return TRUE

		if("regulate")
			var/val = params["regulate"]
			if(isnull(val))
				return FALSE
			main_control.compressor.intake_regulator = clamp(text2num(val), 0.01, 1)
			return TRUE

		if("set_target_rpm")
			var/val = text2num(params["target"])
			if(isnull(val))
				return FALSE
			main_control.target_rpm = clamp(val, 0, main_control.max_rpm)
			return TRUE

		if("adjust_steam_rate")
			var/adjust = text2num(params["adjust"])
			if(isnull(adjust))
				return FALSE
			main_control.steam_consumption_rate = clamp(main_control.steam_consumption_rate + adjust, 0.01, 2)
			return TRUE

		if("emergency_vent")
			main_control.emergency_vent()
			return TRUE

// ====================================================================
// Остальные части (взаимодействие, апгрейды и т.д.) остались без изменений
// ====================================================================

/obj/item/paper/guides/jobs/atmos/train_turbine
	name = "paper- 'Quick guide on the train turbine!'"
	default_raw_text = "<B>How to operate the train turbine</B><BR>\
	- Wrench and secure your buffer water vapor canister<BR>\
	- Turn on the temperature control units to heat, and enable the pump, set the pressure based on how much power you will need.<BR>\
	- For recycling the water vapor from steam, crowbar open the floor and ensure the fluid duct is connected<BR>\
	- Unsecure it with a wrench and replace it to the same spot in front of the turbine outlet.<BR>\
	- Fill the plasma heaters with sheets of plasma, and ensure they are connected to plumbed water from the north.<BR>\
	- The heaters will recycle the liquid reagent water back into gas water vapour.<BR>\
	- Use the control computer to set target RPM, regulate intake, and monitor temperatures/pressures.<BR>\
	- Balance power output with temperature — overheating causes damage!<BR>\
	- Emergency vent available for rapid cooling.<BR>\
	- Outputs CO2 to atmosphere and cooled water for recirculation.<BR>\
	- Hot water vapor must be hot enough or the compressor won't accept it."

#undef PRESSURE_MAX
#undef MINIMUM_TURBINE_PRESSURE
#undef MIN_STEAM_TEMPERATURE




/// Минимальная температура для сгорания плазмы
#define MIN_PLASMA_COMBUSTION_TEMP 373 // K (100C)
/// Коэффициент энергии от сгорания плазмы (джоули на лист)
#define PLASMA_SHEET_BURN_ENERGY 100000 // Больше, так как лист - это "блок" ресурса
/// Объем внутренней камеры для воды (реагенты)
#define HEATER_WATER_VOLUME 1000
/// Минимальная температура для кипения воды в пар
#define WATER_BOIL_TEMP 373 // K
/// Скорость потребления плазмы (листы/тик, дробная)
#define PLASMA_SHEET_CONSUMPTION_RATE 0.01 // Медленно "сжигает" лист

// Нагреватель для поезда: сжигает плазмовые листы для кипячения воды в пар
/obj/machinery/power/train_heater
	name = "train plasma heater"
	desc = "A heater that burns plasma sheets to boil water into steam for the train turbine. Insert plasma sheets, connect plumbing for water input and gas pipes for steam output."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/thermomachine.dmi'
	icon_state = "thermo_base"
	base_icon_state = "thermo_base"
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY

	/// Активен ли нагреватель
	var/active = FALSE
	/// Текущая температура камеры
	var/temperature = T20C
	/// Целевая температура
	var/target_temperature = 500 // K
	/// Внутренняя газовая смесь для выхода пара
	var/datum/gas_mixture/internal_gasmix
	/// Atmos connector для выхода пара
	var/datum/gas_machine_connector/steam_output
	/// Plumbing для входа воды
	var/datum/component/plumbing/heater_plumbing
	/// Стек плазмовых листов внутри
	var/obj/item/stack/sheet/mineral/plasma/plasma_stack

/obj/machinery/power/train_heater/Initialize(mapload)
	. = ..()
	internal_gasmix = new
	internal_gasmix.volume = 500 // Для пара

	reagents = new(HEATER_WATER_VOLUME)
	reagents.my_atom = src

	// Plumbing для воды (вход)
	heater_plumbing = AddComponent(/datum/component/plumbing/heater_plumbing, custom_receiver = reagents)
	heater_plumbing.enable()

	// Atmos connector только для выхода пара
	steam_output = new(loc, src, dir, CELL_VOLUME * 0.5) // Выход пара вперед

	air_update_turf(TRUE)
	update_appearance(UPDATE_OVERLAYS)
	register_context()

/obj/machinery/power/train_heater/Destroy()
	QDEL_NULL(internal_gasmix)
	QDEL_NULL(reagents)
	QDEL_NULL(steam_output)
	QDEL_NULL(heater_plumbing)
	if(plasma_stack)
		plasma_stack.forceMove(loc)
		plasma_stack = null
	return ..()

/obj/machinery/power/train_heater/examine(mob/user)
	. = ..()
	if(plasma_stack)
		. += span_notice("It has [plasma_stack.amount] plasma sheets inserted.")
	else
		. += span_notice("It has no plasma sheets. Insert some to fuel it.")
	. += span_notice("It is [active ? "currently active" : "currently inactive"].")
	. += span_notice("Thermostat shows : [round(temperature, 1)] K.([round(temperature, 1) - T0C]°C)")

/obj/machinery/power/train_heater/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/stack/sheet/mineral/plasma))
		if(plasma_stack)
			balloon_alert(user, "already has plasma!")
			return TRUE
		if(!user.transferItemToLoc(item, src))
			return TRUE
		plasma_stack = item
		balloon_alert(user, "inserted plasma sheets")
		update_appearance(UPDATE_OVERLAYS)
		return TRUE
	return ..()


/obj/machinery/power/train_heater/attack_hand(mob/living/user, list/modifiers)
	toggle_active(user)
	return TRUE

/obj/machinery/power/train_heater/proc/toggle_active(mob/user)
	if(!plasma_stack || plasma_stack.amount <= 0)
		balloon_alert(user, "no plasma fuel!")
		return
	if(!reagents.has_reagent(/datum/reagent/water, 10))
		balloon_alert(user, "no water to heat!")
		return
	active = !active
	if(active)
		begin_processing()
	else
		active = FALSE
	balloon_alert(user, active ? "activated" : "deactivated")
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/power/train_heater/process(seconds_per_tick)
	if(!active && temperature > T20C)
		temperature = max(temperature - 5 * seconds_per_tick, T20C)
		if(temperature <= T20C)
			temperature = T20C
			end_processing()
		return

	if(!active || !powered(ignore_use_power = TRUE) || !plasma_stack || plasma_stack.amount <= 0)
		active = FALSE
		end_processing()
		return PROCESS_KILL


	var/plasma_consumed = min(PLASMA_SHEET_CONSUMPTION_RATE * seconds_per_tick, plasma_stack.amount)
	plasma_stack.use(plasma_consumed)
	var/energy_generated = plasma_consumed * PLASMA_SHEET_BURN_ENERGY
	if(temperature < target_temperature)
		temperature += energy_generated / reagents.heat_capacity() * seconds_per_tick

	if(temperature < MIN_PLASMA_COMBUSTION_TEMP)
		return

	if(reagents.has_reagent(/datum/reagent/water, 10) && temperature >= WATER_BOIL_TEMP)
		var/water_boiled = min(reagents.get_reagent_amount(/datum/reagent/water), 10 * seconds_per_tick)
		reagents.remove_reagent(/datum/reagent/water, water_boiled)
		ADD_GAS(/datum/gas/water_vapor, internal_gasmix.gases)
		internal_gasmix.gases[/datum/gas/water_vapor][MOLES] += water_boiled * 10
		temperature += energy_generated / (reagents.heat_capacity() + internal_gasmix.heat_capacity()) * seconds_per_tick

		internal_gasmix.temperature = temperature
		var/datum/gas_mixture/steam_mix = steam_output.gas_connector.airs[1]
		if(steam_mix)
			internal_gasmix.pump_gas_to(steam_mix, internal_gasmix.return_pressure())
		Shake(pixelshiftx = 1, pixelshifty = 0, duration = 1 SECONDS)

/datum/component/plumbing/heater_plumbing
	demand_connects = NORTH

/datum/component/plumbing/heater_plumbing/Initialize(start = TRUE, ducting_layer, turn_connects = TRUE, datum/reagents/custom_receiver, extend_pipe_to_edge)
	. = ..()
	if(!istype(parent, /obj/machinery/power/train_heater))
		return COMPONENT_INCOMPATIBLE

/datum/component/plumbing/heater_plumbing/Destroy()
	return ..()

/datum/component/plumbing/heater_plumbing/send_request(dir)
	var/obj/machinery/power/train_heater/heater = parent
	if(!heater.reagents)
		return

	var/space = heater.reagents.maximum_volume - heater.reagents.total_volume
	if(space > 0)
		process_request(
			amount = min(space, MACHINE_REAGENT_TRANSFER),
			reagent = /datum/reagent/water,
			dir = dir
		)

/obj/machinery/computer/train_heater_computer
	name = "train heater control computer"
	desc = "Controls the plasma heater for steam production."
	icon_screen = "heater_comp"
	icon_keyboard = "tech_key"
	var/datum/weakref/heater_ref
	var/mapping_id

// Бумажка
/obj/item/paper/guides/jobs/atmos/train_heater
	name = "paper- 'Quick guide on the train heater!'"
	default_raw_text = "<B>How to operate the train heater</B><BR>\
	- Insert plasma sheets as fuel.<BR>\
	- Connect plumbing pipes for water input.<BR>\
	- Connect gas pipes for steam output.<BR>\
	- Activate to start burning plasma and boiling water.<BR>\
	- Monitor temperature via computer."

#undef MIN_PLASMA_COMBUSTION_TEMP
#undef PLASMA_SHEET_BURN_ENERGY
#undef HEATER_WATER_VOLUME
#undef WATER_BOIL_TEMP
#undef PLASMA_SHEET_CONSUMPTION_RATE
