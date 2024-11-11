/datum/weather/acid_rain
	name = "acid rainstorm"
	desc = "The planet's thunderstorms are by nature acidic, and will incinerate anyone standing beneath them without protection."
	probability = 90

	telegraph_message = span_userdanger("Thunder rumbles far above. You hear droplets drumming against the canopy. Seek shelter.")
	telegraph_duration = 400
	telegraph_overlay = "acid_rain_light"

	weather_message = span_boldannounce("<i>Acidic rain pours down around you! Get inside!</i>")
	weather_overlay = "acid_rain"
	weather_duration_lower = 1200
	weather_duration_upper = 2400
	use_glow = FALSE

	end_duration = 100
	end_message = span_boldannounce("The downpour gradually slows to a light shower. It should be safe outside now.")

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_ACIDRAIN

	immunity_type = TRAIT_ACIDRAIN_IMMUNE

	barometer_predictable = FALSE

/datum/weather/acid_rain/weather_act(mob/living/living)
	var/resist = living.getarmor(null, "acid")
	if(prob(max(0,100-resist)))
		living.acid_act(90, 10)
	living.adjustFireLoss(4)


// since acid rain is on a station z level, add extra checks to not annoy everyone
/datum/weather/acid_rain/can_get_alert(mob/player)
	if(!..())
		return FALSE

	if(!is_station_level(player.z))
		return TRUE  // bypass checks

	if(isobserver(player))
		return TRUE

	if(HAS_MIND_TRAIT(player, TRAIT_DETECT_STORM))
		return TRUE

	if(istype(get_area(player), /area/mine))
		return TRUE


	for(var/area/acid_area in impacted_areas)
		if(locate(acid_area) in view(player))
			return TRUE

	return FALSE

///Forever acid rain, I wouldn't suggest trying this.
/datum/weather/acid_rain/forever_storm
	telegraph_duration = 0
	perpetual = TRUE

	probability = 0
