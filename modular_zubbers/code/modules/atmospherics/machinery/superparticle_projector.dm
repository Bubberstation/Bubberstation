//What's the maximum range of the field?
#define SUPERPARTICLE_MAX_RANGE (20)
//What's the maximum internal power? If its above this value, the field will affect everyone on same Z level
#define SUPERPARTICLE_MAX_POWER (4500)
//Past this internal power, the machine will stop working
#define SUPERPARTICLE_STOP_POWER (5500)
//Percentage of CO2 required for effects to apply
#define SUPERPARTICLE_CARBON_GAS_TRESHHOLD (0.2)
//Percentage of Healium required for effects to apply
#define SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD (0.2)
//Amount of burn and brute damage healed per second
#define SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND (0.2)
//Damage treshhold below which healing effect works
#define SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD (30)

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
	Once internal power is above 4.5GeV, the field reach across entire floor of the station \
	(multiple projectors might be required for stations with multiple floors), however, projector can't support more then 5.5GeV and will not work past that threshhold.<BR><BR>\
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
	crate_type = /obj/structure/closet/crate

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
	///The cell we spawn with
	var/obj/item/stock_parts/power_store/cell/cell = /obj/item/stock_parts/power_store/cell/high
	///Is the machine on?
	var/on = FALSE
	/// field range
	var/range = 0
	/// For list of avalible SMs
	var/list/obj/machinery/power/supermatter_crystal/supermatters = list()
	/// For chosen SM
	var/obj/machinery/power/supermatter_crystal/connected_supermatter
	/// Is Carbon Dioxide treshhold reached?
	var/carbon = FALSE
	/// Is Healium treshhold reached?
	var/healium = FALSE

/datum/armor/superparticlegen
	fire = 100
	melee = 10
	bomb = 40


/obj/machinery/power/superparticlegen/update_overlays()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]-o" : base_icon_state
	if(on)
		. += "superparticle_projector_lights"
		if(healium)
			. += "superparticle_healium"
		if(carbon)
			. += "superparticle_carbon"

/obj/machinery/power/superparticlegen/examine(mob/user)
	. = ..()
	. += "It is [on ? "on" : "off"]."
	if(in_range(user, src) || isobserver(user))
		. += span_notice("<b>Right-click</b> to toggle [on ? "off" : "on"].")
		. += span_notice("Current range of the field: [range] tiles.")
		. += span_notice("<b>Carbon Dioxide</b> effect is <b>[carbon ? "active" : "not active"]</b>.")
		. += span_notice("<b>Healium</b> effect is <b>[healium ? "active" : "not active"]</b>.")

/obj/machinery/power/superparticlegen/attack_hand_secondary(mob/user, list/modifiers)
	if(!can_interact(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	toggle_on(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/superparticlegen/proc/display_options(mob/user)

	supermatters = list()
	for(var/obj/machinery/power/supermatter_crystal/sm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/supermatter_crystal))
		supermatters += sm
	connected_supermatter = tgui_input_list(user, "Which engine would you like to link to?", "Select an engine!", supermatters)
	turn_on(user)

/obj/machinery/power/superparticlegen/proc/toggle_on(mob/user)
	if(on)
		turn_off(user)
	else
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

/obj/machinery/power/supermatter_crystal/proc/get_internal_enerergy()
	var/energy = internal_energy
	return energy

/obj/machinery/power/superparticlegen/process(seconds_per_tick)
	if(!on)
		return PROCESS_KILL
	var/range = round((connected_supermatter.get_internal_enerergy()) / SUPERPARTICLE_MAX_POWER * SUPERPARTICLE_MAX_RANGE)

	if(connected_supermatter.gas_percentage[/datum/gas/carbon_dioxide] > SUPERPARTICLE_CARBON_GAS_TRESHHOLD)
		if(!carbon)
			carbon = TRUE
			update_appearance()
	else
		if(carbon)
			carbon = FALSE
			update_appearance()
	if(connected_supermatter.gas_percentage[/datum/gas/healium] > SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD)
		if(!healium)
			healium = TRUE
			update_appearance()
	else
		if(healium)
			healium = FALSE
			update_appearance()


	if(connected_supermatter.get_internal_enerergy() < SUPERPARTICLE_STOP_POWER)
		if(connected_supermatter.get_internal_enerergy() < SUPERPARTICLE_MAX_POWER)
			for(var/mob/living/carbon/target in range(src, range))
				target.apply_status_effect(/datum/status_effect/atmosgenbuff)
				if(carbon)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
				if(healium)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)
			for(var/mob/living/silicon/robot/target in range(src, range))
				if(carbon)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
				if(healium)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)
		else
			for(var/mob/living/carbon/target as anything in GLOB.carbon_list)
				if(target.z == loc.z)
					target.apply_status_effect(/datum/status_effect/atmosgenbuff)
					if(carbon)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
					if(healium)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)
			for(var/mob/living/silicon/robot/target in GLOB.silicon_mobs)
				if(target.z == loc.z)
					if(carbon)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_carbon)
					if(healium)
						target.apply_status_effect(/datum/status_effect/atmosgenbuff_healium)


/atom/movable/screen/alert/status_effect/atmosgenbuff
	name = "Superparticle Field"
	desc = "Your are immune to cold conditions of space"
	icon = 'modular_zubbers/icons/obj/machines/superparticle_projector.dmi'
	icon_state = "superparticle_projector"

/datum/status_effect/atmosgenbuff
	id = "atmosgen_buff"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/atmosgenbuff
	var/static/list/traits_to_give = list(
		TRAIT_RESISTCOLD,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_NOBREATH,
	)

/datum/status_effect/atmosgenbuff/on_apply()
	. = ..()
	owner.add_traits(traits_to_give, REF(src))

/datum/status_effect/atmosgenbuff/on_remove()
	. = ..()
	owner.remove_traits(traits_to_give, REF(src))

/datum/status_effect/atmosgenbuff_carbon
	id = "atmosgen_buff_carbon"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 10 SECONDS
	alert_type = null

/datum/status_effect/atmosgenbuff_carbon/tick(seconds_between_ticks)
	if(iscarbon(owner))
		var/list/batteries = list()
		for(var/obj/item/stock_parts/power_store/C in assoc_to_values(owner.get_all_cells()))
			if(C.charge < C.maxcharge)
				batteries += C
		if(batteries.len)
			var/obj/item/stock_parts/power_store/ToCharge = pick(batteries)
			ToCharge.charge += min(ToCharge.maxcharge - ToCharge.charge, ToCharge.maxcharge/10)
	if(iscyborg(owner))
		var/mob/living/silicon/robot/borg = owner
		var/obj/item/stock_parts/power_store/ToCharge = borg.cell
		ToCharge.charge += min(ToCharge.maxcharge - ToCharge.charge, ToCharge.maxcharge/10)
	return ..()

/datum/status_effect/atmosgenbuff_healium
	id = "atmosgen_buff_healium"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null
	var/healed_last_tick = FALSE

/datum/status_effect/atmosgenbuff_healium/tick(seconds_between_ticks)
	healed_last_tick = FALSE
	var/need_mob_update = FALSE

	if(owner.get_brute_loss() > 0 & owner.get_brute_loss() < SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD)
		need_mob_update += owner.adjust_brute_loss(- SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND, updating_health = FALSE)
		healed_last_tick = TRUE

	if(owner.get_fire_loss() > 0 & owner.get_fire_loss() < SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD)
		need_mob_update += owner.adjust_fire_loss(- SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND, updating_health = FALSE)
		healed_last_tick = TRUE

	if(need_mob_update)
		owner.updatehealth()

	if(healed_last_tick)
		new /obj/effect/temp_visual/heal(get_turf(owner), COLOR_RED)

	return ..()

#undef SUPERPARTICLE_MAX_RANGE
#undef SUPERPARTICLE_MAX_POWER
#undef SUPERPARTICLE_STOP_POWER
#undef SUPERPARTICLE_CARBON_GAS_TRESHHOLD
#undef SUPERPARTICLE_HEALIUM_GAS_TRESHHOLD
#undef SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND
#undef SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD
