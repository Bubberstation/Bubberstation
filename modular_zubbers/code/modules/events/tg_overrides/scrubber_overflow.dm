/datum/round_event/scrubber_overflow/setup()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/temp_vent as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/vent_scrubber))
		var/turf/scrubber_turf = get_turf(temp_vent)
		var/area/scrubber_area = get_area(temp_vent)
		if(!scrubber_turf)
			continue
		if(!is_station_level(scrubber_turf.z))
			continue
		if(temp_vent.welded)
			continue
		if(is_type_in_list(scrubber_area, list(/area/station/engineering/supermatter/room, /area/station/engineering/supermatter, /area/station/commons/dorms, /area/station/security/prison/safe, /area/station/security/prison/toilet)))
			continue
		if(!prob(overflow_probability))
			continue
		scrubbers += temp_vent

	if(!scrubbers.len)
		return kill()
