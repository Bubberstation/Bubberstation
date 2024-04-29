/datum/round_event_control/defective
	name = "Engineering Mishap"
	wizardevent = FALSE
	max_occurrences = 5
	min_players = 5
	category = EVENT_CATEGORY_ENGINEERING
	description = "Makes a few machines on the station act erroneously."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 7
	typepath = /datum/round_event/defective

/datum/round_event/defective
	announce_when = 50
	end_when = 20

/datum/round_event/defective/start()
	var/list/world_valve_list = list()
	var/list/world_computer_list = list()
	var/list/world_pump_list = list()
	var/list/world_scrubber_list = list()
	var/list/world_apc_list = list()
	var/list/world_airlock_list = list()
	var/list/world_chemistry_disp_list = list()
	var/list/world_hydroponics_list = list()
	var/list/world_silicon_list = GLOB.silicon_mobs
	var/list/station_z = SSmapping.levels_by_trait(ZTRAIT_STATION)
	for(var/obj/machinery/current_machinery in world)
		if(current_machinery.z == locate(current_machinery.z) in station_z)
			if(istype(current_machinery, /obj/machinery/atmospherics/components/binary/valve))
				world_valve_list |= current_machinery
			if(istype(current_machinery, /obj/machinery/atmospherics/components/unary/vent_scrubber))
				world_scrubber_list |= current_machinery
			if(istype(current_machinery, /obj/machinery/computer))
				world_computer_list |= current_machinery
			if(istype(current_machinery, /obj/machinery/chem_dispenser))
				world_chemistry_disp_list |= current_machinery
			if(istype(current_machinery, /obj/machinery/atmospherics/components/binary/pump) || istype(current_machinery, /obj/machinery/atmospherics/components/binary/volume_pump))
				world_pump_list |= current_machinery
			if(istype(current_machinery, /obj/machinery/door/airlock))
				world_airlock_list |= current_machinery
			if(istype(current_machinery, /obj/machinery/power/apc))
				world_apc_list |= current_machinery
/* 	var/list/machines_to_alter = list(
		world_valve_list,
		world_computer_list,
		world_pump_list,
		world_apc_list,
		world_airlock_list,
		world_chemistry_disp_list,
		world_hydroponics_list,
	) */

	var/list/valves_to_trip = list()
	for(var/i in 0 to rand(0, 1))
		valves_to_trip |= pick_n_take(world_valve_list)
	for(var/obj/machinery/atmospherics/components/binary/valve/current_valve in valves_to_trip)
		current_valve.interact()
		current_valve.play_attack_sound(50, BRUTE)
		announce_to_ghosts(current_valve)

	var/list/scrubbers_to_trip = list()
	for(var/i in 0 to rand(0, 2))
		scrubbers_to_trip |= pick_n_take(world_scrubber_list)
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/current_scrubber in scrubbers_to_trip)
		current_scrubber.set_scrubbing(0) // todo: make it go REVERSE
		current_scrubber.play_attack_sound(50, BRUTE)
		announce_to_ghosts(current_scrubber)

	var/list/computers_to_trip = list()
	for(var/i in 0 to rand(0, 1))
		computers_to_trip |= pick_n_take(world_computer_list)
	for(var/obj/machinery/computer/current_computer in computers_to_trip)
		current_computer.play_attack_sound(50, BRUTE)
		current_computer.emp_act(1)
		announce_to_ghosts(current_computer)

	var/list/pumps_to_trip = list()
	for(var/i in 0 to rand(0, 1))
		pumps_to_trip |= pick_n_take(world_pump_list)
	for(var/obj/machinery/atmospherics/components/binary/pump/pump in pumps_to_trip)
		pump.play_attack_sound(50, BRUTE)
		pump.target_pressure = /obj/machinery/atmospherics/components/binary/pump::target_pressure
		announce_to_ghosts(pump)
	for(var/obj/machinery/atmospherics/components/binary/volume_pump/vol_pump in pumps_to_trip)
		vol_pump.play_attack_sound(50, BRUTE)
		vol_pump.transfer_rate = rand(0, 200)
		announce_to_ghosts(vol_pump)

	var/list/apcs_to_trip = list()
	for(var/i in 0 to rand(0, 1))
		apcs_to_trip |= pick_n_take(world_apc_list)
	for(var/obj/machinery/power/apc/apc in apcs_to_trip)
		apc.play_attack_sound(50, BRUTE)
		for(var/mob/living/carbon/human in oview(7, apc))
			apc.shock(human)
		announce_to_ghosts(apc)

	var/list/chem_dispenser_to_trip = list()
	for(var/i in 0 to rand(1, 2))
		chem_dispenser_to_trip |= pick_n_take(world_chemistry_disp_list)
	for(var/obj/machinery/chem_dispenser/dispensy in chem_dispenser_to_trip)
		dispensy.play_attack_sound(50, BRUTE)
		dispensy.emag_act()
		dispensy.beaker?.SplashReagents(dispensy, TRUE, TRUE)
		announce_to_ghosts(dispensy)


/datum/round_event/defective/announce(fake)
	priority_announce("A recall for faulty equipment has been issued. Please consult with your Engineering Supervisor.", "Engineering Alert")
