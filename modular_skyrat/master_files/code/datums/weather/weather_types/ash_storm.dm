//Ash storms happen frequently on lavaland. They heavily obscure vision, and cause high fire damage to anyone caught outside.
/datum/weather/ash_storm
	name = "ash storm"
	desc = "An intense atmospheric storm lifts ash off of the planet's surface and billows it down across the area, dealing intense fire damage to the unprotected."

	telegraph_message = span_boldwarning("An eerie moan rises on the wind. Sheets of burning ash blacken the horizon. Seek shelter.")
	telegraph_duration = 300
	telegraph_overlay = "light_ash"
	telegraph_skyblock = 0.3

	weather_message = span_userdanger("<i>Smoldering clouds of scorching ash billow down around you! Get inside!</i>")
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "ash_storm"
	weather_skyblock = 0.3

	end_message = span_boldannounce("The shrieking wind whips away the last of the ash and falls to its usual murmur. It should be safe to go outside now.")
	end_duration = 300
	end_overlay = "light_ash"
	end_skyblock = 0.3

	area_type = /area
	protect_indoors = TRUE

	immunity_type = TRAIT_ASHSTORM_IMMUNE

	barometer_predictable = TRUE

	sound_active_outside = /datum/looping_sound_skyrat/active_outside_ashstorm
	sound_active_inside = /datum/looping_sound_skyrat/active_inside_ashstorm
	sound_weak_outside = /datum/looping_sound_skyrat/weak_outside_ashstorm
	sound_weak_inside = /datum/looping_sound_skyrat/weak_inside_ashstorm
	multiply_blend_on_main_stage = TRUE

/datum/weather/ash_storm/proc/is_ash_immune(atom/L)
	while (L && !isturf(L))
		if(ismecha(L)) //Mechs are immune
			return TRUE
		if(ishuman(L)) //Are you immune?
			var/mob/living/carbon/human/H = L
			var/thermal_protection = H.get_thermal_protection()
			if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
				return TRUE
		if(HAS_TRAIT(L, TRAIT_ASHSTORM_IMMUNE))
			return TRUE
		L = L.loc //Check parent items immunities (recurses up to the turf)
	return FALSE //RIP you

/datum/weather/ash_storm/weather_act(mob/living/L)
	if(is_ash_immune(L))
		return
	L.adjustFireLoss(4)


//Emberfalls are the result of an ash storm passing by close to the playable area of lavaland. They have a 10% chance to trigger in place of an ash storm.
/datum/weather/ash_storm/emberfall
	name = "emberfall"
	desc = "A passing ash storm blankets the area in harmless embers."

	weather_message = span_notice("Gentle embers waft down around you like grotesque snow. The storm seems to have passed you by...")
	weather_overlay = "light_ash"

	end_message = span_notice("The emberfall slows, stops. Another layer of hardened soot to the basalt beneath your feet.")
	end_sound = null

	aesthetic = TRUE
