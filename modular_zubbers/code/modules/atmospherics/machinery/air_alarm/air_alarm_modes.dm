/obj/machinery/airalarm/Initialize(mapload, ndir, nbuild)
	. = ..()
	if(istype(my_area, /area/station/medical/treatment_center) || istype(my_area, /area/station/medical/pharmacy) || istype(my_area, /area/station/medical/surgery))
		addtimer(CALLBACK(src, PROC_REF(set_medical)), 3 MINUTES) // give time for map to load

/obj/machinery/airalarm/proc/set_medical()
	select_mode(src, /datum/air_alarm_mode/medical)

/datum/air_alarm_mode/medical
	name = "Medical"
	desc = "Filter medical gases"
	danger = FALSE

/datum/air_alarm_mode/medical/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_EXTERNAL_BOUND
		vent.external_pressure_bound = ONE_ATMOSPHERE
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	var/list/filtered = subtypesof(/datum/gas)
	filtered -= list(/datum/gas/oxygen, /datum/gas/nitrogen)
	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.filter_types = scrubber.filter_types = list(/datum/gas/carbon_dioxide, /datum/gas/plasma, /datum/gas/nitrous_oxide)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SCRUBBING)
		scrubber.set_widenet(TRUE)
