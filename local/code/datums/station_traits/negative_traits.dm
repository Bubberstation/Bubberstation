// We don't just have an Icemoon to worry about.
/datum/station_trait/storm/foreverstorm/on_round_start()
	for (var/potential_weather_z as anything in SSmapping.levels_by_trait(ZTRAIT_STATION))
		if(SSmapping.level_trait(potential_weather_z, ZTRAIT_RAINSTORM))
			storm_type = /datum/weather/rain_storm/forever_storm
			continue
	. = ..() // Supercall after doing this goofy-ass setup in order to avoid a more complicated rewrite. Hacky, sucks, but is what it is
