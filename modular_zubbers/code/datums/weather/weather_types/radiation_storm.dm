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

// Jungle Pubby stuff placed here temporarily.

/datum/weather/rain_storm/acid/junglepubby
	target_trait = ZTRAIT_ACIDSTORM
	probability = 40

	telegraph_sound = null

	weather_flags = (WEATHER_MOBS | WEATHER_BAROMETER)
