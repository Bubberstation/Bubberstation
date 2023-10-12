/obj/machinery/power/rbmk2
	name = "\improper RB-MK2 reactor"
	desc = "Radioscopical Bluespace Mark 2 reactor, or RB MK2 for short, is a new state-of-the-art power generation technology that uses bluespace magic \
	to directly convert tritium particles into energy with minimal heat generation. \
	Improper cooling management of internal as well external gasses may lead to EXPLOSIONS.\n\
	To start up a reactor, <b>partially</b> fill a RB-MK2 rod up with a moderator gas and tritium, and insert it into the reactor. The tritium will slowly get consumed into energy, based on internal temperatue."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "platform"
	base_icon_state = "platform"
	density = FALSE
	anchored = TRUE
	use_power = NO_POWER_USE

	max_integrity = 300

	uses_integrity = TRUE

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_REQUIRES_ANCHORED

	resistance_flags = FIRE_PROOF

	circuit = /obj/item/circuitboard/machine/rbmk2

	var/active = FALSE //Is this machine active?
	var/power = TRUE //Is this machine giving power?
	var/overclocked = FALSE //Is this machine overclocked, consuming more tritium?
	var/venting = TRUE //Is this machine venting the gasses?
	var/vent_reverse_direction = FALSE //Is this machine venting in the reverse direction (sucking)?
	var/safety = TRUE //Is the safety active?
	var/cooling_limiter = 0 //Current cooling limiter amount.
	var/cooling_limiter_max = 90 //Maximum possible cooling limiter amount.
	var/jammed = FALSE //Is the reactor ejection system jammed?

	var/obj/item/tank/rbmk2_rod/stored_rod //Currently stored rbmk2 rod.
	var/datum/gas_mixture/buffer_gasses //Gas that has yet to be leaked out due to not venting fast enough.
	var/mutable_appearance/heat_overlay //Vent heat overlay.
	var/mutable_appearance/meter_overlay //Inactive tritium meter display.

	var/last_power_generation = 0 //Display purposes. Do not edit.
	var/last_tritium_consumption = 0 //Display purposes. Do not edit.

	var/gas_consumption_base = 0.001 //How much gas gets consumed, in moles, per cycle.
	var/gas_consumption_heat = 0.02 //How much gas gets consumed, in moles, per cycle, per 1000 kelvin.

	var/base_power_generation = 3900000 //How many joules of power to add per mole of tritium processed.

	//Upgradable stats.
	var/power_efficiency = 1 //A multiplier of base_power_generation. Also has an effect on heat generation. Improved via capacitors.
	var/vent_pressure = 200 //Pressure, in kPa, that the buffer releases the gas to. Improved via servos.
	var/vent_volume = 300 //How large is the buffer vent, in liters. Improved via matter bins.

	armor_type = /datum/armor/rbmk2

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
	buffer_gasses = new(vent_volume)
	heat_overlay = mutable_appearance(icon, "platform_heat", alpha=255)
	heat_overlay.appearance_flags |= RESET_COLOR
	meter_overlay = mutable_appearance(icon, "platform_rod_glow_5", alpha=255)
	heat_overlay.appearance_flags |= RESET_COLOR
	connect_to_network()
	process() //Process once to update everything.

/obj/machinery/power/rbmk2/return_analyzable_air()
	. = list()
	if(stored_rod) . += stored_rod.air_contents
	. += buffer_gasses

/obj/machinery/power/rbmk2/Destroy()

	if(SSticker.IsRoundInProgress())
		var/turf/T = get_turf(src)
		message_admins("[src] deleted at [ADMIN_VERBOSEJMP(T)]")
		log_game("[src] deleted at [AREACOORD(T)]")
		investigate_log("deleted at [AREACOORD(T)]", INVESTIGATE_ENGINE)

	remove_rod()

	qdel(wires)
	set_wires(null)

	. = ..()

/obj/machinery/power/rbmk2/deconstruct(disassembled = TRUE)

	if(flags_1 & NODECONSTRUCT_1)
		return

	if(!disassembled && stored_rod)
		//Uh oh.
		var/turf/T = get_turf(src)
		message_admins("[src] exploded due to damage at [ADMIN_VERBOSEJMP(T)]")
		log_game("[src] exploded due to damage [AREACOORD(T)]")
		investigate_log("exploded due to damage [AREACOORD(T)]", INVESTIGATE_ENGINE)
		stored_rod.take_damage(1000,armour_penetration=100)

	. = ..()

/obj/machinery/power/rbmk2/preloaded/Initialize(mapload)
	. = ..()
	stored_rod = new /obj/item/tank/rbmk2_rod/preloaded(src)
	START_PROCESSING(SSmachines, src)
	update_appearance()

/obj/machinery/power/rbmk2/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!user.combat_mode)
		if(!active && istype(attacking_item,/obj/item/tank/rbmk2_rod/)) //Insert a rod.
			src.add_fingerprint(user)
			attacking_item.add_fingerprint(user)
			return add_rod(user,attacking_item)
	. = ..()

/obj/machinery/power/rbmk2/on_set_panel_open(old_value)
	. = ..()
	update_appearance()

/obj/machinery/power/rbmk2/proc/force_unjam(obj/item/attacking_item,mob/living/user,damage_to_deal=50)
	if(!jammed)
		return FALSE
	if(atom_integrity <= damage_to_deal)
		balloon_alert(user, "too damaged!")
		return FALSE
	if(attacking_item.use_tool(src, user, 4 SECONDS, volume = 50) && jam(user,FALSE))
		take_damage(damage_to_deal,armour_penetration=100)
		balloon_alert(user, "unjammed!")
	return TRUE

//Remove the rod.
/obj/machinery/power/rbmk2/AltClick(mob/living/user)
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
	if(do_throw)
		if(jammed)
			if(prob(80))
				take_damage(0.5,armour_penetration=100,sound_effect=FALSE)
				stored_rod.take_damage(0.5,armour_penetration=100)
				playsound(src, pick('sound/effects/structure_stress/pop1.ogg','sound/effects/structure_stress/pop2.ogg','sound/effects/structure_stress/pop3.ogg'), 50, TRUE, extrarange = -3)
				return FALSE
			else //Yes. Spamming the eject button can unjam it.
				jam(user,FALSE) //We did it!
				toggle_active(user,FALSE) //Turning it off.
				playsound(src, 'sound/machines/shutter.ogg', 50, TRUE, extrarange = -3)
				return FALSE
		stored_rod.forceMove(T)
		stored_rod.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(3,6),5)
		playsound(src, 'sound/weapons/gun/general/grenade_launch.ogg', 50, TRUE, extrarange = -3)
	else
		if(jammed)
			return FALSE
		stored_rod.forceMove(T)
		playsound(src, 'sound/weapons/gun/shotgun/insert_shell.ogg', 50, TRUE, frequency = -1, extrarange = -3)
	stored_rod = null
	meter_overlay.alpha = 0
	update_appearance()
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
	meter_overlay.alpha = 255
	update_appearance()
	START_PROCESSING(SSmachines, src)
	playsound(src, 'sound/weapons/gun/shotgun/insert_shell.ogg', 50, TRUE, frequency = 1, extrarange = -3)
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

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_active(mob/living/user,desired_state=!active)

	if(active == desired_state)
		return

	if(!force && desired_state)
		if(!stored_rod)
			return
		if(!anchored)
			return

	if(jammed)
		return

	active = desired_state

	if(!active)
		meter_overlay.alpha = 0

	if(active)
		var/turf/T = get_turf(src)
		if(user)
			user.log_message("turned on [src]", LOG_GAME)
			investigate_log("was turned on by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		else
			log_game("[src] was turned on at [AREACOORD(T)]")
			investigate_log("was turned on at [AREACOORD(T)]", INVESTIGATE_ENGINE)

	update_appearance()

	playsound(src, 'sound/machines/eject.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_vents(mob/living/user,desired_state=!venting)

	if(desired_state == venting)
		return FALSE

	venting = desired_state

	if(!venting)
		var/turf/T = get_turf(src)
		if(user)
			user.log_message("had vents turned off by [src]", LOG_GAME)
			investigate_log("had vents turned off by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		else
			log_game("[src] had vents turned off at [AREACOORD(T)]")
			investigate_log("had vents turned off at [AREACOORD(T)]", INVESTIGATE_ENGINE)

	update_appearance()

	playsound(src, 'sound/machines/creak.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_reverse_vents(mob/living/user,desired_state=!vent_reverse_direction)

	if(desired_state == vent_reverse_direction)
		return FALSE

	if(venting) //Can't change when they're already on.
		return FALSE

	vent_reverse_direction = desired_state

	if(vent_reverse_direction)
		var/turf/T = get_turf(src)
		if(user)
			user.log_message("had vents set in reverse by [src]", LOG_GAME)
			investigate_log("had vents set in reverse by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		else
			log_game("[src] had vents set in reverse at [AREACOORD(T)]")
			investigate_log("had vents set in reverse at [AREACOORD(T)]", INVESTIGATE_ENGINE)

	return TRUE

/obj/machinery/power/rbmk2/RefreshParts()
	. = ..()

	//Requires x4 capacitors
	var/power_efficiency_mul = 0
	for(var/datum/stock_part/capacitor/new_capacitor in component_parts)
		power_efficiency_mul += new_capacitor.tier * 0.25
	power_efficiency = initial(power_efficiency) * power_efficiency_mul

	//Requires x2 matter bins
	var/vent_volume_mul = 0
	for(var/datum/stock_part/matter_bin/new_matter_bin in component_parts)
		vent_volume_mul += new_matter_bin.tier * 0.5
	vent_volume = initial(vent_volume) * vent_volume_mul
	if(buffer_gasses) buffer_gasses.volume = vent_volume

	//Requires x4 servos
	var/vent_pressure_multiplier = 0
	for(var/datum/stock_part/servo/new_servo in component_parts)
		vent_pressure_multiplier += new_servo.tier * 0.25
	vent_pressure = initial(vent_pressure) * vent_pressure_multiplier


/obj/machinery/power/rbmk2/examine(mob/user)
	. = ..()

	. += "It is[!active?"n't":""] running."

	if(!power || !powernet)
		. += span_warning("It is not connected to a power cable.")

	if(!stored_rod)
		. += span_warning("It it is missing a RB-MK2 reactor rod.")

	if(!venting)
		. += span_warning("The vents are closed.")

	if(jammed)
		. += span_danger("It's jammed!")

	if(active)
		. += "It is currently consuming [last_tritium_consumption] moles of tritium per cycle, producing [display_power(last_power_generation)]."

/obj/machinery/power/rbmk2/examine_more(mob/user)
	. = ..()
	. += "It is running at <b>[power_efficiency*100]%</b> power efficiency."
	. += "It an internal gas buffer volume of <b>[vent_volume]L</b>."
	. += "It can output in environments up to <b>[vent_pressure]kPa</b>."

/obj/machinery/power/rbmk2/update_icon_state()

	if(stored_rod)
		if(active)
			if(jammed)
				icon_state = "[base_icon_state]_jammed"
			else
				icon_state = "[base_icon_state]_closed"
		else
			icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state

	return ..()

/obj/machinery/power/rbmk2/update_overlays()
	. = ..()
	if(panel_open) . += "platform_panel"
	. += heat_overlay
	. += meter_overlay

/obj/machinery/power/rbmk2/proc/transfer_rod_temperature(datum/gas_mixture/gas_source,allow_cooling_limiter=TRUE)

	var/datum/gas_mixture/rod_mix = stored_rod.air_contents

	var/rod_mix_heat_capacity = rod_mix.heat_capacity()
	if(rod_mix_heat_capacity <= 0)
		return FALSE

	var/gas_source_heat_capacity = gas_source.heat_capacity()
	if(gas_source_heat_capacity <= 0)
		return FALSE

	var/rod_mix_temperature = rod_mix.temperature
	var/gas_source_temperature = gas_source.temperature

	var/delta_temperature = rod_mix_temperature - gas_source_temperature
	if(delta_temperature == 0)
		return FALSE

	var/energy_transfer = delta_temperature*rod_mix_heat_capacity*gas_source_heat_capacity/(rod_mix_heat_capacity+gas_source_heat_capacity)

	var/temperature_change = (energy_transfer/rod_mix_heat_capacity)
	if(allow_cooling_limiter && temperature_change > 0) //Cooling!
		temperature_change *= clamp(1 - cooling_limiter*0.01,0,1) //Clamped in case of adminbus fuckery.

	rod_mix.temperature -= temperature_change*0.65
	gas_source.temperature += temperature_change

	return TRUE

/obj/machinery/power/rbmk2/proc/shock(mob/living/victim,shock_multiplier=1)
	if(!powernet)
		return FALSE
	if(!electrocute_mob(victim, powernet, src, shock_multiplier, TRUE))
		return FALSE
	do_sparks(5, TRUE, src)
	return TRUE
