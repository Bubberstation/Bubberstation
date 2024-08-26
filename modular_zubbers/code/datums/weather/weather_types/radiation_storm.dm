/datum/weather/rad_storm/New(...)
	LAZYOR(protected_areas, list(
		/area/station/terminal,
		/area/lavaland/underground,
		/area/moonstation/underground,
		/area/station/cargo/miningelevators,
		/area/station/cargo/miningfoundry/event_protected,

		/area/ruin/unpowered/primitive_catgirl_den,

		/area/ruin/space/has_grav/bubbers/dauntless_space,
		/area/ruin/space/has_grav/bubbers/dauntless,

		/area/station/commons/dorms,
	))
	. = ..()
