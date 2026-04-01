/obj/item/tank/rbmk2_rod
	name = "\improper RB-MK2 reactor rod"
	desc = "A rod for the RB-MK2 reactor. Usually filled with a mix of tritium and an inert gas, such as nitrogen."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "platform_rod"
	inhand_icon_state = null
	worn_icon_state = null
	tank_holder_icon_state = null
	flags_1 = CONDUCTS_ELECTRICITY
	slot_flags = null //they have no straps!
	force = 8
	armor_type = /datum/armor/reactor_rod
	volume = 50

	actions_types = null
	action_slots = null

	var/pressure_limit = 24000
	var/temperature_limit = T0C + 1800
	pressure_resistance = 24000

/datum/armor/reactor_rod
	melee = 25
	bullet = 20
	laser = 10
	energy = 100
	bomb = 30
	fire = 90
	acid = 50

/obj/item/tank/rbmk2_rod/preloaded/populate_gas()
	air_contents.assert_gas(/datum/gas/tritium)
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.gases[/datum/gas/tritium][MOLES] = 40
	air_contents.gases[/datum/gas/nitrogen][MOLES] = 10

/obj/item/tank/rbmk2_rod/supermatter/populate_gas()
	air_contents.assert_gas(/datum/gas/tritium)
	air_contents.assert_gas(/datum/gas/hypernoblium)
	air_contents.gases[/datum/gas/tritium][MOLES] = 20
	air_contents.gases[/datum/gas/hypernoblium][MOLES] = 30

/obj/item/tank/rbmk2_rod/atom_destruction(damage_flag)

	if(!loc || !istype(loc,/obj/machinery/power/rbmk2))
		return ..()

	var/obj/machinery/power/rbmk2/M = loc
	M.stored_rod = null
	M.active = FALSE
	M.jammed = FALSE
	src.forceMove(get_turf(M))
	. = ..()


//Special override proc that removes the tank exploding, reacting, or leaking gas.

/obj/item/tank/rbmk2_rod/process(seconds_per_tick)
	STOP_PROCESSING(SSobj, src)
	return

/obj/item/tank/rbmk2_rod/examine(user)
	. = ..()
	. += span_notice("A sticker on its side says <b>MAX SAFE PRESSURE: [siunit_pressure(pressure_limit, 0)]; MAX SAFE TEMPERATURE: [siunit(temperature_limit, "K", 0)]</b>.")
