/// What's the maximum range of the field?
#define SUPERPARTICLE_MAX_RANGE (20)
/// What's the maximum internal power? If its above this value, the field will affect everyone on same Z level
#define SUPERPARTICLE_MAX_POWER (4500)
/// Past this internal power, the machine will stop working
#define SUPERPARTICLE_STOP_POWER (5500)
/// Percentage of CO2 required for effects to apply
#define SUPERPARTICLE_CARBON_GAS_TRESHHOLD (0.2)
/// Percentage of Healium required for effects to apply
#define SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD (0.2)
//Flags for gas treshholds
/// Is Carbon Dioxide treshhold reached?
#define SP_GAS_FLAG_CARBON (1<<0)
/// Is Healium treshhold reached?
#define SP_GAS_FLAG_HEALIUM (1<<1)

/obj/item/paper/guides/jobs/atmos/superparticlegen
	name = "paper- 'Guide to Superparticle Projector'"
	default_raw_text = "<B>How to operate the Superparticle Projector</B><BR>\
	-Build the machine using provided machine board.<BR>\
	-Activate the projector and select a Supermatter engine you'd like to link it to.<BR>\
	-Machine can be turned off and on again to change your selected engine.<BR><BR>\
	<B>Basic function:</B><BR>\
	-Projector offers protective field of particles simulating pressurised conditions. \
	Any humanoid in range will be immune to harm from a cold environment, low pressure, \
	or running out of air to breathe, making sure the crew stays alive in case of station hull breach.<BR>\
	-Field is invisible to the naked eye, it is centered at the location of the Projector itself, not the linked engine.\
	You can inspect the Projector at any time to check how far it can reach. \
	Radius will scale with the internal power of the Supermatter engine that you choose to link this machine to, \
	reaching 20 tile radius at 4.5GeV of internal power.\
	Once internal power is above 4.5GeV, the field reach across entire station \
	(off station projector will require their own engines), however, projector can't support more then 5.5GeV and will not work past that threshhold.<BR><BR>\
	<B>Additional effects:</B><BR>\
	Projector will offer additional benefits, depending on type of gas present around chosen Supermatter engine<BR>\
	-Above 20% Carbon Dioxide - it will recharge power cells carried by carbons and power cells powering cyborgs (10% of random cell every 10 seconds)<BR>\
	-Above 20% Healium - the field will slowly fix brute and burn damage to both crew and cyborgs \
	(0.2 per second if below 30 damage)<BR><BR>\
	Superparticle Projector is a new device in active development, this guide will be updated if any of the above information changes. \
	If something does not work the way it should, make sure to read it again and look for changes."

/datum/supply_pack/engineering/superparticlegen
	name = "Superparticle Projector"
	desc = "Generator that creates beneficial field to crew members, effects are based on state of Supermatter engine. Contains machine board and a guide."
	cost = CARGO_CRATE_VALUE * 50 // 10,000
	contains = list(/obj/item/circuitboard/machine/superparticlegen,
	/obj/item/paper/guides/jobs/atmos/superparticlegen)
	crate_name = "Superparticle Projector Circuitboard Crate"
	crate_type = /obj/structure/closet/crate/engineering

/obj/item/circuitboard/machine/superparticlegen
	name = "Superparticle Projector"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/superparticlegen
	req_components = list(
		/datum/stock_part/capacitor = 2,
		/datum/stock_part/micro_laser = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/machinery/power/superparticlegen
	anchored = TRUE
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON
	icon = 'modular_zubbers/icons/obj/machines/superparticle_projector.dmi'
	icon_state = "superparticle_projector"
	base_icon_state = "superparticle_projector"
	name = "Superparticle Projector"
	desc = "Generates a field around itself that grants space immunity to all humanoids in range. \
	Range scales with internal power of chosen Supermatter engine. \
	Using specific gasses on chosen Supermatter engine, grants additional benefits"
	max_integrity = 250
	circuit = /obj/item/circuitboard/machine/superparticlegen
	armor_type = /datum/armor/superparticlegen
	interaction_flags_click = ALLOW_SILICON_REACH
	use_power = IDLE_POWER_USE
	/// The cell we spawn with
	var/obj/item/stock_parts/power_store/cell/cell = /obj/item/stock_parts/power_store/cell/high
	/// Is the machine on?
	var/on = FALSE
	/// field range
	var/range = 0
	/// For list of avalible SMs
	var/list/obj/machinery/power/supermatter_crystal/supermatters = list()
	/// For chosen SM
	var/obj/machinery/power/supermatter_crystal/connected_supermatter

	/// Which gasses have met their treshholds in SM?
	var/superparticle_gas_flags = NONE

/datum/armor/superparticlegen
	fire = 100
	melee = 10
	bomb = 40
/obj/machinery/power/superparticlegen/update_overlays()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]-o" : base_icon_state
	if(on)
		. += "superparticle_projector_lights"
		if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
			. += "superparticle_carbon"
		if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
			. += "superparticle_healium"

/obj/machinery/power/superparticlegen/examine(mob/user)
	. = ..()
	. += "It is [on ? "on" : "off"]."
	if(in_range(user, src) || isobserver(user))
		. += span_notice("<b>Right-click</b> to toggle [on ? "off" : "on"].")
		. += span_notice("Current range of the field: [range] tiles.")
		. += span_notice("<b>Carbon Dioxide</b> effect is <b>[superparticle_gas_flags & SP_GAS_FLAG_CARBON ? "active" : "not active"]</b>.")
		. += span_notice("<b>Healium</b> effect is <b>[superparticle_gas_flags & SP_GAS_FLAG_HEALIUM ? "active" : "not active"]</b>.")

/obj/machinery/power/superparticlegen/attack_hand_secondary(mob/user, list/modifiers)
	if(!can_interact(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	toggle_on(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/superparticlegen/proc/display_options(mob/user)
	supermatters = list()
	for(var/obj/machinery/power/supermatter_crystal/sm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/supermatter_crystal))
		if((loc.z == sm.z) | (is_station_level(loc.z) & is_station_level(sm.z)))
			supermatters += sm
	connected_supermatter = tgui_input_list(user, "Which engine would you like to link to?", "Select an engine!", supermatters)
	turn_on(user)

/obj/machinery/power/superparticlegen/proc/toggle_on(mob/user)
	if(on)
		turn_off(user)
		return
	if(anchored)
		display_options(user)
	else
		balloon_alert(user, "anchor first")

/obj/machinery/power/superparticlegen/proc/turn_on(mob/user)
	if(!isnull(user))
		balloon_alert(user, "turned on")
	on = TRUE
	START_PROCESSING(SSmachines, src)
	update_appearance()

/obj/machinery/power/superparticlegen/proc/turn_off(mob/user)
	on = FALSE
	if(!isnull(user))
		balloon_alert(user, "turned off")
	STOP_PROCESSING(SSmachines, src)
	update_appearance()

/obj/machinery/power/superparticlegen/screwdriver_act(mob/living/user, obj/item/tool)
	if(on)
		balloon_alert(user, "turn off!")
		return ITEM_INTERACT_SUCCESS
	if(!anchored)
		balloon_alert(user, "anchor!")
		return ITEM_INTERACT_SUCCESS

	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/power/superparticlegen/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/power/superparticlegen/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(on)
		balloon_alert(user, "turn off first!")
		return
	default_unfasten_wrench(user, tool)
	if(anchored)
		connect_to_network()
	else
		disconnect_from_network()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/superparticlegen/process(seconds_per_tick)
	if(!on)
		return PROCESS_KILL
	range = round((connected_supermatter.internal_energy) / SUPERPARTICLE_MAX_POWER * SUPERPARTICLE_MAX_RANGE)

	if(connected_supermatter.gas_percentage[/datum/gas/carbon_dioxide] > SUPERPARTICLE_CARBON_GAS_TRESHHOLD)
		if(superparticle_gas_flags ^ SP_GAS_FLAG_CARBON)
			superparticle_gas_flags |= SP_GAS_FLAG_CARBON
			update_appearance()
	else
		if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
			superparticle_gas_flags ^= SP_GAS_FLAG_CARBON
			update_appearance()
	if(connected_supermatter.gas_percentage[/datum/gas/healium] > SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD)
		if(superparticle_gas_flags ^ SP_GAS_FLAG_HEALIUM)
			superparticle_gas_flags |= SP_GAS_FLAG_HEALIUM
			update_appearance()
	else
		if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
			superparticle_gas_flags ^= SP_GAS_FLAG_HEALIUM
			update_appearance()
	if(connected_supermatter.internal_energy < SUPERPARTICLE_STOP_POWER)
		if(connected_supermatter.internal_energy < SUPERPARTICLE_MAX_POWER)
			for(var/mob/living/carbon/target in range(src, range))
				target.apply_status_effect(/datum/status_effect/atmosgenbuff)
				if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
				if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)
			for(var/mob/living/silicon/robot/target in range(src, range))
				if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
				if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)
		else
			for(var/mob/living/carbon/target as anything in GLOB.carbon_list)
				if(target.z == loc.z | (is_station_level(loc.z) & is_station_level(target.z)))
					target.apply_status_effect(/datum/status_effect/atmosgenbuff)
					if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
					if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)
			for(var/mob/living/silicon/robot/target in GLOB.silicon_mobs)
				if(target.z == loc.z | (is_station_level(loc.z) & is_station_level(target.z)))
					if(superparticle_gas_flags & SP_GAS_FLAG_CARBON)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
					if(superparticle_gas_flags & SP_GAS_FLAG_HEALIUM)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)

#undef SUPERPARTICLE_MAX_RANGE
#undef SUPERPARTICLE_MAX_POWER
#undef SUPERPARTICLE_STOP_POWER
#undef SUPERPARTICLE_CARBON_GAS_TRESHHOLD
#undef SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD
#undef SP_GAS_FLAG_CARBON
#undef SP_GAS_FLAG_HEALIUM
