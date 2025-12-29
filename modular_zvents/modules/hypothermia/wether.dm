/datum/weather/snow_storm/snow_blizzard
	name = "snow blizzard"
	desc = "Harsh snowstorms roam the topside of this arctic planet, burying any area unfortunate enough to be in its path."

	telegraph_message = span_warning("Drifting particles of snow begin to dust the surrounding area..")
	telegraph_duration = 30 SECONDS
	telegraph_overlay = "light_snow"
	telegraph_sound = 'sound/ambience/weather/snowstorm/snow_start.ogg'
	telegraph_sound_vol = /datum/looping_sound/snowstorm::volume + 10

	weather_message = span_userdanger("<i>Harsh winds pick up as dense snow begins to fall from the sky! Seek shelter!</i>")
	weather_overlay = "light_snow"
	weather_duration_lower = 15 MINUTES
	weather_duration_upper = 20 MINUTES
	use_glow = FALSE

	end_duration = 10 SECONDS
	end_message = span_bolddanger("The snowfall dies down, it should be safe to go outside again.")
	end_sound = 'sound/ambience/weather/snowstorm/snow_end.ogg'
	end_sound_vol = /datum/looping_sound/snowstorm::volume + 10

	area_type = /area/hypothermia
	target_trait = ZTRAIT_STATION

	weather_temperature = TM15C
	weather_flags = WEATHER_MOBS | WEATHER_BAROMETER | WEATHER_TEMPERATURE_BYPASS_CLOTHING | WEATHER_ENDLESS

	var/weather_temperature_indoor = T0C

	outdoor_sound_type = /datum/looping_sound/snowstorm

	indoor_sound_type = /datum/looping_sound/snowstorm/indoor


/datum/weather/snow_storm/snow_blizzard/start()
	area_sound_types = list()
	for(var/area/impacted_area in impacted_areas)
		var/sound_type = impacted_area.outdoors ? outdoor_sound_type : indoor_sound_type
		area_sound_types[impacted_area] = sound_type
	return ..()

/datum/weather/snow_storm/snow_blizzard/end()
	area_sound_types = null
	return ..()

/datum/weather/snow_storm/snow_blizzard/update_areas()
	var/list/new_overlay_cache = generate_overlay_cache()
	for(var/area/impacted as anything in impacted_areas)
		if(!impacted.daylight)
			continue
		if(length(overlay_cache))
			impacted.overlays -= overlay_cache
			if(impacted_areas_blend_modes[impacted])
				impacted.blend_mode = impacted_areas_blend_modes[impacted]
				impacted_areas_blend_modes[impacted] = null
		if(length(new_overlay_cache))
			impacted.overlays += new_overlay_cache
			if(impacted.blend_mode > BLEND_OVERLAY)
				impacted_areas_blend_modes[impacted] = impacted.blend_mode
				impacted.blend_mode = BLEND_OVERLAY
	overlay_cache = new_overlay_cache

/datum/weather/snow_storm/snow_blizzard/can_get_alert(mob/player)
	return TRUE

/datum/weather/snow_storm/snow_blizzard/process(seconds_per_tick)
	. = ..()
	for(var/area/hypothermia/HA in impacted_areas)
		if(HA.outdoors)
			HA.set_temperature(weather_temperature)
		else
			if(HA.area_min_temperature > weather_temperature_indoor)
				HA.area_min_temperature = weather_temperature_indoor
			HA.decrease_temperature_scaled(weather_temperature_indoor * 0.6 * seconds_per_tick, HA.area_min_temperature)

/datum/weather/snow_storm/snow_blizzard/heavy
	weather_temperature_indoor = TM15C
	weather_temperature = TM40C


/datum/weather/snow_storm/snow_blizzard/insane
	weather_temperature_indoor = TM40C
	weather_temperature = TM70C
	weather_overlay = "snow_storm"

/datum/weather/snow_storm/snow_blizzard/extreme
	weather_temperature_indoor = TM70C
	weather_temperature = TM90C
	weather_overlay = "snow_storm"

/datum/weather/snow_storm/snow_blizzard/endgame
	weather_temperature_indoor = TM150C
	weather_temperature = TM150C
	weather_overlay = "snow_storm"

// Define indoor sound loop if not exists
/datum/looping_sound/snowstorm/indoor
	mid_length = 30
	volume = 40
