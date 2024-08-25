/datum/weather/rad_storm/New()
	. = ..()

	for (var/area/station/commons/dorms/dorm_subtype in subtypesof(/area/station/commons/dorms))
		protected_areas += dorm_subtype
