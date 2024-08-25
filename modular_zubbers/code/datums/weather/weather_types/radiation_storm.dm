/datum/weather/rad_storm/New(...)
	LAZYOR(protected_areas, list(
		/area/station/terminal,
		/area/lavaland/underground,
		/area/moonstation/underground,
		/area/station/cargo/miningelevators,
		/area/station/cargo/miningfoundry/event_protected,

		/area/ruin/unpowered/primitive_catgirl_den,
	))
	. = ..()


/datum/weather/rad_storm/New()
	. = ..()

	for (var/area/station/commons/dorms/dorm_subtype in subtypesof(/area/station/commons/dorms))
		protected_areas += dorm_subtype

	protected_areas += /area/ruin/space/has_grav/bubbers/dauntless
	protected_areas += /area/ruin/space/has_grav/bubbers/dauntless_space
