/obj/structure/blob/can_atmos_pass(turf/T, vertical = FALSE)

	. = ..()

	if(!.)
		return .

	var/datum/gas_mixture/turf_air = T.return_air()
	return turf_air.temperature > T0C + 15.5556 // https://www.menshealth.com/trending-news/a19548271/why-penis-shrinks-in-cold/

