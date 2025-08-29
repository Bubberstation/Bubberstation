/datum/weather/rain_storm
	turf_weather_chance = 0.0001
	turf_thunder_chance = THUNDER_CHANCE_VERY_RARE
	protected_areas = list(
		/area/taeloth/underground, \
		/area/taeloth/nearstation/bridge_roof/patio/under, \
		/area/taeloth/nearstation/bridge_crossway/deck, \
		) // outdoors = false also prevents you from using bluepirnts.. ough

/datum/weather/rain_storm/wizard
	turf_thunder_chance = THUNDER_CHANCE_AVERAGE // Wiz thunderstorms should keep their default /tg/ thunder chance.

// This sucks HARD but not as any fault of it's own.
/datum/weather/rain_storm/forever_storm
	telegraph_duration = 0
	weather_flags = parent_type::weather_flags | WEATHER_ENDLESS
	probability = 0
