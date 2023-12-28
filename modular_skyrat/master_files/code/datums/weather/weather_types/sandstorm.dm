/datum/weather/sandstorm
	name = "sandstorm"
	desc = "Wshshshshh."

	telegraph_message = "<span class='warning'>You see waves of sand traversing as the wind picks up the pace..</span>"
	telegraph_duration = 300
	telegraph_overlay = "dust"

	weather_message = "<span class='userdanger'><i>A sand storm is upon you! Seek shelter!</i></span>"
	weather_overlay = "sandstorm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='boldannounce'>The storm dissipiates.</span>"
	end_overlay = "dust"

	area_type = /area
	protect_indoors = TRUE

	immunity_type = TRAIT_ASHSTORM_IMMUNE

	barometer_predictable = TRUE
	affects_underground = FALSE

	sound_active_outside = /datum/looping_sound_skyrat/weather/wind/indoors
	sound_active_inside = /datum/looping_sound_skyrat/weather/wind
	sound_weak_outside = /datum/looping_sound_skyrat/weather/wind/indoors
	sound_weak_inside = /datum/looping_sound_skyrat/weather/wind

	opacity_in_main_stage = TRUE
	multiply_blend_on_main_stage = TRUE

/datum/weather/sandstorm/weather_act(mob/living/L)
	if(iscarbon(L))
		var/mob/living/carbon/carbon = L
		if(!carbon.is_mouth_covered())
			carbon.adjustOxyLoss(1.5)
			if(prob(10))
				carbon.emote("cough")
