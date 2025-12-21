GLOBAL_VAR_INIT(active_rbmk_machines, list())

/obj/machinery/power/rbmk2
	name = "\improper RB-MK2 reactor"
	desc = "Radioscopical Bluespace Mark 2 reactor, or RB-MK2 for short, is a new state-of-the-art power generation technology that uses \"bluespace magic\" \
	to directly convert small amounts of tritium atoms into large amounts of electrical energy with minimal heat generation. \
	Note that having more than 4 RB-MK machines in close proximity increases tritium consumption."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "platform"
	base_icon_state = "platform"
	density = FALSE
	anchored = TRUE
	use_power = NO_POWER_USE

	max_integrity = 300

	uses_integrity = TRUE

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_REQUIRES_ANCHORED | INTERACT_ATOM_UI_INTERACT
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON | INTERACT_MACHINE_REQUIRES_SIGHT | INTERACT_MACHINE_REQUIRES_LITERACY | INTERACT_MACHINE_REQUIRES_STANDING

	resistance_flags = FIRE_PROOF

	circuit = /obj/item/circuitboard/machine/rbmk2

	armor_type = /datum/armor/rbmk2

	var/active = FALSE //Is this machine active?
	var/power = TRUE //Is this machine giving power?
	var/overclocked = FALSE //Is this machine overclocked, consuming more tritium?
	var/venting = TRUE //Is this machine venting the gases?
	var/vent_reverse_direction = FALSE //Is this machine venting in the reverse direction (sucking)?
	var/safety = TRUE //Is the safety active?
	var/cooling_limiter = 100 //Current cooling limiter amount.
	var/cooling_limiter_max = 100 //Maximum possible cooling limiter amount. 100 means auto.
	var/jammed = FALSE //Is the reactor ejection system jammed?
	var/tampered = FALSE //Was the anti-tamper light activated?


	//Upgrades
	var/auto_vent_upgrade = FALSE
	var/safeties_upgrade = FALSE
	var/overclocked_upgrade = FALSE

	var/auto_vent = FALSE

	var/meltdown = FALSE //Is the reactor currently suffering from a meltdown?
	var/criticality = 0 //Once this reaches 100, you're going to see some serious shit.
	var/was_warned = FALSE
	var/meltdown_start_time = 0 //When the meltdown started. If the reactor has been in meltdown for a while, then more tritium will be consumed.

	var/obj/item/tank/rbmk2_rod/stored_rod //Currently stored rbmk2 rod.
	var/datum/gas_mixture/buffer_gases //Gas that has yet to be leaked out due to not venting fast enough.

	var/last_power_generation = 0 //Display purposes. Do not edit.
	var/last_power_generation_bonus = 0 //Display purposes. Do not edit.
	var/last_tritium_consumption = 0 //Display purposes. Do not edit. This is measured in micromoles.
	var/last_radiation_pulse = 0 //Display purposes. Do not edit. This is measured in tiles (radius).

	var/gas_consumption_base = 2400 //How much gas gets consumed, in micromoles, per cycle.
	var/gas_consumption_heat = 4000 //How much gas gets consumed, in moles, per cycle, per 1000 kelvin (of the reactor rod temperature).

	var/base_power_generation = 40 //How many joules of power to add per micromole of tritium processed.
	//There are 1000000 micromoles in a mole.

	var/goblin_multiplier = 4 //How many mols of goblin gas produced per mol of tritium. Increases with matter bins.

	var/safeties_max_power_generation = 230000

	//Upgradable stats.
	var/power_efficiency = 1 //A multiplier of base_power_generation. Also has an effect on heat generation. Improved via capacitors.
	var/vent_pressure = 200 //Pressure, in kPa, that the buffer releases the gas to. Improved via servos.
	var/max_power_generation = 350000 //Maximum allowed power generation (joules) per cycle before the rods go apeshit. Improved via matter bins. Hard limit is over 10 times this.

	var/heat_waste_multiplier = 0.04

	var/heating_multiplier = 1 //Heat transfer multiplier, to the RBMK.

	var/list/obj/machinery/rbmk2_sniffer/linked_sniffers = list()

	var/obj/machinery/power/supermatter_crystal/linked_supermatter

	COOLDOWN_DECLARE(auto_vent_cooldown)
	COOLDOWN_DECLARE(radiation_cooldown)

/datum/armor/rbmk2
	melee = 50
	bullet = 20
	laser = 10
	energy = 100
	bomb = 30
	fire = 90
	acid = 50

/obj/machinery/power/rbmk2/Initialize(mapload)
	. = ..()

	set_wires(new /datum/wires/rbmk2(src))
	buffer_gases = new(100)

	connect_to_network()
	process() //Process once to update everything.

	SSair.start_processing_machine(src)

	supermatter_link()

/obj/machinery/power/rbmk2/preloaded/Initialize(mapload)
	. = ..()
	stored_rod = new /obj/item/tank/rbmk2_rod/preloaded(src)
	START_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_ICON)

/obj/machinery/power/rbmk2/supermatter/Initialize(mapload)
	. = ..()
	stored_rod = new /obj/item/tank/rbmk2_rod/supermatter(src)
	START_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_ICON)

/obj/machinery/power/rbmk2/proc/supermatter_link()

	if(linked_supermatter)
		supermatter_unlink()

	for(var/obj/machinery/power/supermatter_crystal/found_supermatter in orange(1,loc))
		if(found_supermatter.moveable || !found_supermatter.anchored)
			continue
		linked_supermatter = found_supermatter
		RegisterSignal(linked_supermatter, COMSIG_QDELETING, PROC_REF(on_supermatter_delete))
		return TRUE

	return FALSE

/obj/machinery/power/rbmk2/proc/on_supermatter_delete(atom/source)

	SIGNAL_HANDLER

	supermatter_unlink()


/obj/machinery/power/rbmk2/proc/supermatter_unlink()
	if(!linked_supermatter)
		return FALSE
	linked_supermatter = null
	UnregisterSignal(linked_supermatter, COMSIG_QDELETING)
	return TRUE

/obj/machinery/power/rbmk2/return_analyzable_air()
	. = list()
	if(stored_rod) . += stored_rod.air_contents
	. += buffer_gases

/obj/machinery/power/rbmk2/Destroy()

	for(var/obj/machinery/rbmk2_sniffer/sniffer as anything in linked_sniffers)
		sniffer.unlink_reactor(null,src)

	supermatter_unlink()

	if(SSticker.IsRoundInProgress())
		var/turf/T = get_turf(src)
		message_admins("[src] deleted at [ADMIN_VERBOSEJMP(T)]")
		log_game("[src] deleted at [AREACOORD(T)]")
		investigate_log("deleted at [AREACOORD(T)]", INVESTIGATE_ENGINE)

	QDEL_NULL(stored_rod)
	QDEL_NULL(buffer_gases)

	qdel(wires)
	set_wires(null)

	SSair.stop_processing_machine(src)

	GLOB.active_rbmk_machines -= src

	. = ..()

/obj/machinery/power/rbmk2/on_deconstruction(disassembled = TRUE)
	if(!disassembled && stored_rod)
		//Uh oh.
		var/turf/T = get_turf(src)
		if(criticality > 0)
			var/explosion_power = (criticality/100)*8
			message_admins("[src] exploded due to criticality at [ADMIN_VERBOSEJMP(T)]")
			log_game("[src] exploded due to criticality [AREACOORD(T)]")
			investigate_log("exploded due to criticality [AREACOORD(T)]", INVESTIGATE_ENGINE)
			stored_rod.take_damage(1000,armour_penetration=100)
			if(stored_rod)
				remove_rod()
			explosion(src, devastation_range  = explosion_power*0.25, heavy_impact_range = explosion_power*0.5, light_impact_range = explosion_power, flash_range = explosion_power*2, adminlog = FALSE)
			last_radiation_pulse = GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE*4 //It just keeps getting worse and worse.
			radiation_pulse(src,last_radiation_pulse,threshold = RAD_FULL_INSULATION)
		else
			message_admins("[src] exploded due to damage at [ADMIN_VERBOSEJMP(T)]")
			log_game("[src] exploded due to damage [AREACOORD(T)]")
			investigate_log("exploded due to damage [AREACOORD(T)]", INVESTIGATE_ENGINE)
			stored_rod.take_damage(1000,armour_penetration=100)
			if(stored_rod) //Just in case.
				remove_rod()
	. = ..()

/obj/machinery/power/rbmk2/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!user.combat_mode)
		if(!active && istype(attacking_item,/obj/item/tank/rbmk2_rod/)) //Insert a rod.
			src.add_fingerprint(user)
			attacking_item.add_fingerprint(user)
			return add_rod(user,attacking_item)
	. = ..()

/obj/machinery/power/rbmk2/exchange_parts(mob/user, obj/item/storage/part_replacer/replacer_tool)

	if(active)
		balloon_alert(user, "turn off before upgrading!")
		return FALSE

	. = ..()


/obj/machinery/power/rbmk2/on_set_panel_open(old_value)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/machinery/power/rbmk2/proc/force_unjam(obj/item/attacking_item,mob/living/user,damage_to_deal=50)

	if(!jammed)
		return FALSE

	if(attacking_item.use_tool(src, user, 4 SECONDS, volume = 50) && jam(user,FALSE))
		if(prob(100-atom_integrity))
			take_damage(damage_to_deal*0.5,armour_penetration=100)
			balloon_alert(user, "unjam failed!")
			return TRUE
		take_damage(damage_to_deal,armour_penetration=100)
		if(atom_integrity > 0)
			src.Shake(duration=0.5 SECONDS)
			balloon_alert(user, "unjammed!")
			if(meltdown) //You turned it off, but at what cost?
				radiation_pulse(src,max_range=6,threshold = RAD_FULL_INSULATION, chance = 100)
			toggle_active(user,FALSE,disable_jam=TRUE)
			return TRUE

	return FALSE

//Remove the rod.
/obj/machinery/power/rbmk2/click_alt(mob/living/user)
	if(!active && stored_rod)
		src.add_fingerprint(user)
		stored_rod.add_fingerprint(user)
		if(remove_rod(user))
			balloon_alert(user, "rod removed!")
		return TRUE

/obj/machinery/power/rbmk2/proc/remove_rod(mob/living/user,do_throw=FALSE)
	if(!stored_rod)
		return FALSE
	if(active && !jammed)
		return FALSE
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	if(meltdown)
		return FALSE
	if(do_throw)
		if(jammed)
			if(prob(80))
				take_damage(0.5,armour_penetration=100,sound_effect=FALSE)
				stored_rod.take_damage(0.5,armour_penetration=100)
				src.Shake(duration=0.5 SECONDS)
				playsound(src, pick('sound/effects/structure_stress/pop1.ogg','sound/effects/structure_stress/pop2.ogg','sound/effects/structure_stress/pop3.ogg'), 50, TRUE, extrarange = -3)
				return FALSE
			else //Yes. Spamming the eject button can unjam it.
				jam(user,FALSE) //We did it!
				toggle_active(user,FALSE) //Turning it off.
				playsound(src, 'sound/machines/shutter.ogg', 50, TRUE, extrarange = -3)
				return FALSE
		stored_rod.forceMove(T)
		stored_rod.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(3,6),5)
		playsound(src, 'sound/items/weapons/gun/general/grenade_launch.ogg', 50, TRUE, extrarange = -3)
	else
		if(jammed)
			return FALSE
		stored_rod.forceMove(T)
		playsound(src, 'sound/items/weapons/gun/shotgun/insert_shell.ogg', 50, TRUE, frequency = -1, extrarange = -3)
	stored_rod = null
	update_appearance(UPDATE_ICON)
	if(user)
		user.log_message("removed a rod from [src]", LOG_GAME)
		investigate_log("had a rod removed by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	return TRUE

/obj/machinery/power/rbmk2/proc/add_rod(mob/living/user,obj/item/tank/rbmk2_rod/desired_rod)
	if(stored_rod && !remove_rod(user))
		return FALSE
	if(active)
		return FALSE
	desired_rod.forceMove(src)
	stored_rod = desired_rod
	update_appearance(UPDATE_ICON)
	START_PROCESSING(SSmachines, src)
	playsound(src, 'sound/items/weapons/gun/shotgun/insert_shell.ogg', 50, TRUE, frequency = 1, extrarange = -3)
	if(user)
		user.log_message("inserted a rod into [src]", LOG_GAME)
		investigate_log("had a rod inserted by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	return TRUE


/obj/machinery/power/rbmk2/proc/jam(mob/living/user,desired_state=!jammed)

	if(jammed == desired_state)
		return

	if(!active && desired_state) //Can't jam when already open
		return

	var/turf/T = get_turf(src)
	if(user)
		user.log_message("jammed [src]", LOG_GAME)
		investigate_log("jammed due to damage by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	else
		log_game("[src] jammed due to damage at [AREACOORD(T)]")
		investigate_log("jammed due to damage at [AREACOORD(T)]", INVESTIGATE_ENGINE)

	jammed = desired_state

	playsound(src, 'sound/effects/pressureplate.ogg', 50, TRUE, extrarange = -3)

	update_appearance(UPDATE_ICON)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_active(mob/living/user,desired_state=!active,disable_jam=FALSE)

	if(active == desired_state)
		return

	if(!force && desired_state)
		if(!stored_rod)
			return
		if(!anchored)
			return

	if(jammed)
		return FALSE

	if(!disable_jam && meltdown) //You thought.
		if(!jammed) //JAM IT.
			jam(user,TRUE)
		return FALSE

	active = desired_state

	if(active)
		GLOB.active_rbmk_machines |= src
		var/turf/T = get_turf(src)
		if(user)
			user.log_message("turned on [src]", LOG_GAME)
			investigate_log("was turned on by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		else
			log_game("[src] was turned on at [AREACOORD(T)]")
			investigate_log("was turned on at [AREACOORD(T)]", INVESTIGATE_ENGINE)
	else
		GLOB.active_rbmk_machines -= src

	update_appearance(UPDATE_ICON)

	playsound(src, 'sound/machines/eject.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_vents(mob/living/user,desired_state=!venting)

	if(desired_state == venting)
		return FALSE

	venting = desired_state

	if(user)
		user.log_message("had vents turned [venting ? "on" : "off"] by [src]", LOG_GAME)
		investigate_log("had vents turned [venting ? "on" : "off"] by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	else
		var/turf/our_turf = get_turf(src)
		log_game("[src] had vents turned [venting ? "on" : "off"] at [AREACOORD(our_turf)]")
		investigate_log("had vents turned [venting ? "on" : "off"] at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	update_appearance(UPDATE_ICON)

	playsound(src, 'sound/machines/creak.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_reverse_vents(mob/living/user,desired_state=!vent_reverse_direction)

	if(desired_state == vent_reverse_direction)
		return FALSE

	if(venting) //Can't change when they're already on.
		if(user)
			balloon_alert(user, "turn vents off first")
		return FALSE

	vent_reverse_direction = desired_state

	if(user)
		user.log_message("had vents set to [vent_reverse_direction ? "reverse" : "normal"] by [src]", LOG_GAME)
		investigate_log("had vents set to [vent_reverse_direction ? "reverse" : "normal"] by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		balloon_alert(user, "vents switched to [vent_reverse_direction ? "pulling" : "pushing"]")
	else
		var/turf/our_turf = get_turf(src)
		log_game("[src] had vents set to [vent_reverse_direction ? "reverse" : "normal"] at [AREACOORD(our_turf)]")
		investigate_log("had vents set to [vent_reverse_direction ? "reverse" : "normal"] at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	return TRUE

/obj/machinery/power/rbmk2/RefreshParts()

	. = ..()

	//Requires x4 capacitors
	//Capacitors increase power efficiency (more power generated per tritium consumed).
	var/power_efficiency_mul = 0.75
	for(var/datum/stock_part/capacitor/new_capacitor in component_parts)
		power_efficiency_mul += (new_capacitor.tier * 0.0625)
	power_efficiency = initial(power_efficiency) * power_efficiency_mul

	//Requires x2 matter bins
	//Matter pins increase the maximum power generation allowed and the amount of goblin gas generated.
	var/max_power_generation_mul = 0
	goblin_multiplier = initial(goblin_multiplier)
	for(var/datum/stock_part/matter_bin/new_matter_bin in component_parts)
		max_power_generation_mul += (new_matter_bin.tier * 0.5) + max(0,new_matter_bin.tier-1)*0.1
		goblin_multiplier += (new_matter_bin.tier-1)*0.5
	max_power_generation = initial(max_power_generation) * (max_power_generation_mul**(1 + (max_power_generation_mul-1)*0.1))
	max_power_generation = FLOOR(max_power_generation, 10000)
	safeties_max_power_generation = max(initial(safeties_max_power_generation),round(max_power_generation*(safeties_upgrade ? 0.9: 0.75),25000))

	//Requires x4 servos
	//Servos increase the strength of the fans, forcing out gas at a higher rate.
	var/vent_pressure_multiplier = 0
	for(var/datum/stock_part/servo/new_servo in component_parts)
		vent_pressure_multiplier += new_servo.tier * 0.25

	vent_pressure = initial(vent_pressure) * vent_pressure_multiplier

/obj/machinery/power/rbmk2/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RBMK2", name)
		ui.open()

/obj/machinery/power/rbmk2/ui_data(mob/user)
	var/list/data = list()
	// Progress Bars
	data["criticality"] = criticality
	data["health_percent"] = (atom_integrity/max_integrity)*100

	// Used to display the current rod pressure
	data["rod_mix_pressure"] = stored_rod?.air_contents.return_pressure() || 0
	// Used as a comparison point for the progress bar
	data["rod_pressure_limit"] = stored_rod?.pressure_limit || 0
	// Look for specifically tritium, don't need to show moderators.
	var/trit_left = stored_rod?.air_contents.gases[/datum/gas/tritium][MOLES] || 0
	data["rod_trit_moles"] = trit_left
	// rod temperature
	data["rod_mix_temperature"] = stored_rod?.air_contents.temperature || 0

	// This variable and the next allows our limits in the UI to change based on part tiers.
	data["safeties_max_power_generation"] = safeties_max_power_generation
	data["max_power_generation"] = max_power_generation
	// We use this to display our power using this
	data["last_power_output"] = display_power(last_power_generation)
	data["last_power_output_bonus"] = display_power(last_power_generation_bonus)
	// but we use this raw to calculate the progress bar
	data["raw_last_power_output"] = last_power_generation
	data["raw_last_power_output_bonus"] = last_power_generation_bonus

	data["last_tritium_consumption"] = last_tritium_consumption*0.5

	var/fuel_time = trit_left / (max(last_tritium_consumption*0.5,gas_consumption_base)/1000000)

	data["fuel_time_left"] = fuel_time //in seconds.
	data["fuel_time_left_text"] = DisplayTimeText(10*fuel_time,round_seconds_to=1)


	data["temperature_limit"] = stored_rod?.temperature_limit || 0

	// Button data
	data["venting"] = venting
	data["auto_vent"] = auto_vent
	data["auto_vent_upgrade"] = auto_vent_upgrade
	data["vent_dir"] = vent_reverse_direction
	data["active"] = active
	data["safety"] = safety
	data["overclocked"] = overclocked
	data["overclocked_upgrade"] = overclocked_upgrade
	data["rod"] = stored_rod

	// Status displays
	data["jammed"] = jammed
	data["meltdown"] = meltdown

	data["magic_number"] = (meltdown ? criticality*100 : 0) + 15 + (last_power_generation / max_power_generation) * (9000-15) //This is entirely arbitrary

	return data

/obj/machinery/power/rbmk2/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	switch(action)
		if("autovent")
			if(auto_vent_upgrade)
				auto_vent = !auto_vent
				balloon_alert(user, "auto venting is [auto_vent ? "on" : "off"]")
			. = TRUE
		if("activate")
			toggle_active(user)
			. = TRUE
		if("eject")
			remove_rod(user, do_throw = TRUE)
			. = TRUE
		if("venttoggle")
			toggle_vents(user)
			. = TRUE
		if("ventpush") // Vent push and vent pull are separate because I wanted pretty buttons and didn't know how else to implement them.
			toggle_reverse_vents(user, FALSE)
			. = TRUE
		if("ventpull")
			toggle_reverse_vents(user, TRUE)
			. = TRUE
		if("overclocktoggle")
			if(overclocked_upgrade)
				var/turf/machine_turf = get_turf(src)
				overclocked = !overclocked
				balloon_alert(user, "overclocking is [overclocked ? "on" : "off"]")
				investigate_log("had the overclock turned [overclocked ? "on" : "off"] by [key_name(user)] at [AREACOORD(machine_turf)].", INVESTIGATE_ENGINE)
				user.log_message("turned the overclock [overclocked ? "on" : "off"] of [src]", LOG_GAME)
			. = TRUE


/obj/machinery/power/rbmk2/examine(mob/user)

	. = ..()

	. += span_notice("A digital display on the side side says <b>MAX SAFE POWER: [display_power(safeties_max_power_generation)], WARRANTY VOID IF EXCEEDED</b>.")


	if(active)
		. += span_notice("It's running.")
		if(HAS_TRAIT(user, TRAIT_CLUMSY))
			. += span_clown("I better go catch it!")
	else
		. += span_warning("It isn't running.")

	if(linked_supermatter)
		. += span_notice("It is currently linked to an adjacent supermatter crystal, feeding power directly into it at high efficiency.")
	else if(!power || !powernet)
		. += span_warning("It is not connected to a power cable.")

	if(!venting)
		. += span_warning("The vents are closed.")

	if(!stored_rod)
		. += span_warning("It it is missing an RB-MK2 reactor rod.")
	else if(jammed)
		. += span_danger("The reactor rod is jammed! <b>Pry</b> the rod back in to unjam in!")
	else if(meltdown)
		. += span_danger("The reactor rod is leaping erractically! Lower the power output!")
	else
		. += span_notice("There is an RB-MK2 reactor rod installed. <b>Bolt</b> it down to activate, or remove it with ALT+CLICK.")


/obj/machinery/power/rbmk2/examine_more(mob/user)
	. = ..()
	. += span_notice("It is running at <b>[power_efficiency*100]%</b> power efficiency.")
	. += span_notice("It can output in environments up to <b>[vent_pressure]kPa</b>.")
	. += span_notice("It can handle an estimated power load of <b>[display_power(max_power_generation)]</b> before going critical.")
	if(!linked_supermatter)
		. += span_notice("Is is not currently linked to an adjacent supermatter crystal.")
		. += span_notice("Building an RB-MK2 reactor directly adjacent to a normal-sized supermatter crystal will link them together and supply energy to the supermatter crystal.")
		. += span_notice("Doing this requires at least 30 moles of Hyper-Noblium present in the reactor rod, along with the normal tritium as fuel.")



/obj/machinery/power/rbmk2/proc/transfer_rod_temperature(datum/gas_mixture/gas_source,multiplier=1,allow_cooling_limiter=TRUE)

	var/datum/gas_mixture/rod_mix = stored_rod.air_contents

	var/rod_mix_heat_capacity = rod_mix.heat_capacity()
	if(rod_mix_heat_capacity <= 0) //Nothing there.
		return FALSE

	var/gas_source_heat_capacity = gas_source.heat_capacity()
	if(gas_source_heat_capacity <= 0) //Nothing there.
		return FALSE

	var/rod_mix_temperature = rod_mix.temperature
	var/gas_source_temperature = gas_source.temperature

	var/delta_temperature = rod_mix_temperature - gas_source_temperature
	if(delta_temperature == 0) //No Change.
		return FALSE

	var/energy_transfer = ((delta_temperature*rod_mix_heat_capacity*gas_source_heat_capacity) / (rod_mix_heat_capacity+gas_source_heat_capacity))*multiplier

	var/temperature_change = (energy_transfer/rod_mix_heat_capacity)
	if(temperature_change > 0) //Cooling!
		if(allow_cooling_limiter)
			if(cooling_limiter == cooling_limiter_max) //Auto
				var/temperature_mod = clamp( ( (rod_mix.temperature-200) / stored_rod.temperature_limit) * 2 ,0,1)
				temperature_change *= temperature_mod
			else
				temperature_change *= clamp(1 - cooling_limiter*0.01,0,1) //Clamped in case of adminbus fuckery.
	else //Heating!
		temperature_change *= clamp(heating_multiplier,0.25,1) //Clamped in case of adminbus fuckery.

	rod_mix.temperature -= temperature_change
	gas_source.temperature += temperature_change

	return TRUE

/obj/machinery/power/rbmk2/proc/shock(mob/living/victim,shock_multiplier=1)
	if(!powernet)
		return FALSE
	if(!electrocute_mob(victim, powernet, src, shock_multiplier, TRUE))
		return FALSE
	do_sparks(5, TRUE, src)
	return TRUE
