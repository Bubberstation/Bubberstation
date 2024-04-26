/datum/round_event_control/valve
	name = "Release Half-Life 3"
	wizardevent = FALSE
	max_occurrences = 5
	min_players = 5
	category = EVENT_CATEGORY_ENGINEERING
	description = "Opens or closes random valves on station."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 7
	typepath = /datum/round_event/valve

/datum/round_event/valve
	announce_when = 50
	end_when = 20

/datum/round_event/valve/start()
	var/list/world_valve_list = list()
	var/list/station_z = SSmapping.levels_by_trait(ZTRAIT_STATION)
	for(var/obj/machinery/atmospherics/components/binary/valve/valve in world)
		if(valve.z == locate(valve.z) in station_z)
			world_valve_list |= valve
	var/list/valves_to_trip = list()
	for(var/i in 1 to 5)
		valves_to_trip |= pick_n_take(world_valve_list)
	for(var/obj/machinery/atmospherics/components/binary/valve/current_valve in valves_to_trip)
		current_valve.interact()
		announce_to_ghosts(current_valve)
