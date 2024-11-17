/datum/weather/acid_rain
	name = "acid rainstorm"
	desc = "The planet's thunderstorms are by nature acidic, and will incinerate anyone standing beneath them without protection."
	probability = 90

	telegraph_message = span_userdanger("Thunder rumbles far above. You hear droplets drumming against the canopy. Seek shelter.")
	telegraph_duration = 400
	telegraph_sound = "modular_zubbers/sound/ambience/acidrain_start.ogg"

	weather_message = span_boldannounce("<i>Acidic rain pours down around you! Get inside!</i>")
	weather_overlay = "acid_rain"
	weather_duration_lower = 1200
	weather_duration_upper = 2400
	use_glow = FALSE
	weather_sound = "modular_zubbers/sound/ambience/acidrain_mid.ogg"

	end_duration = 100
	end_message = span_boldannounce("The downpour gradually slows to a light shower. It should be safe outside now.")
	end_sound = "modular_zubbers/sound/ambience/acidrain_end.ogg"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_ACIDRAIN

	immunity_type = TRAIT_WEATHER_IMMUNE

	barometer_predictable = FALSE

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

/// Copied from sand_storm.dm to get the acid rain to work properly. Surely there's a better way to do this.
/datum/weather/acid_rain/generate_overlay_cache()
	// We're ending, so no overlays at all
	if(stage == END_STAGE)
		return list()

	var/weather_state = ""
	switch(stage)
		if(STARTUP_STAGE)
			weather_state = telegraph_overlay
		if(MAIN_STAGE)
			weather_state = weather_overlay
		if(WIND_DOWN_STAGE)
			weather_state = end_overlay

	// Use all possible offsets
	// Yes this is a bit annoying, but it's too slow to calculate and store these from turfs, and it shouldn't (I hope) look weird
	var/list/gen_overlay_cache = list()
	for(var/offset in 0 to SSmapping.max_plane_offset)
		// Note: what we do here is effectively apply two overlays to each area, for every unique multiz layer they inhabit
		// One is the base, which will be masked by lighting. the other is "glowing", and provides a nice contrast
		// This method of applying one overlay per z layer has some minor downsides, in that it could lead to improperly doubled effects if some have alpha
		// I prefer it to creating 2 extra plane masters however, so it's a cost I'm willing to pay
		// LU
		var/mutable_appearance/glow_overlay = mutable_appearance('modular_zubbers/icons/effects/glow_weather.dmi', weather_state, overlay_layer, null, ABOVE_LIGHTING_PLANE, 100, offset_const = offset)
		glow_overlay.color = weather_color
		gen_overlay_cache += glow_overlay

		var/mutable_appearance/weather_overlay = mutable_appearance('modular_zubbers/icons/effects/weather_effects.dmi', weather_state, overlay_layer, plane = overlay_plane, offset_const = offset)
		weather_overlay.color = weather_color
		gen_overlay_cache += weather_overlay

	return gen_overlay_cache

/datum/weather/acid_rain/can_get_alert(mob/player)

	if(!..())
		return FALSE

	if(isobserver(player))
		return TRUE

	if(HAS_MIND_TRAIT(player, TRAIT_DETECT_STORM))
		return TRUE

	if(istype(get_area(player), /area/jungleplanet/nearstation || /area/jungleplanet/surface))
		return TRUE

	return FALSE

/mob/Login()
	. = ..()
	if(.)
		AddElement(/datum/element/weather_listener, /datum/weather/acid_rain, ZTRAIT_ACIDRAIN)

/datum/component/object_possession/bind_to_new_object(obj/target)

	. = ..()
	if(.)
		target.AddElement(/datum/element/weather_listener, /datum/weather/acid_rain, ZTRAIT_ACIDRAIN)

/datum/component/object_possession/cleanup_object_binding()

	var/was_valid = possessed && !QDELETED(possessed)

	. = ..()

	if(was_valid)
		possessed.RemoveElement(/datum/element/weather_listener, /datum/weather/acid_rain, ZTRAIT_ACIDRAIN)


/datum/weather/acid_rain/can_weather_act(mob/living/mob_to_check)
	. = ..()
	if(!. || !ishuman(mob_to_check))
		return FALSE
	if(victim.resistance_flags & ACID_PROOF)
		return FALSE
	return TRUE

#define WEATHER_ACID_BASE_DAMAGE 0.5

/datum/weather/acid_rain/weather_act(mob/living/carbon/human/victim) // We know they are a human from can_weather_act
	if(prob(50))
		return FALSE
	var/dealt_damage = FALSE
	for(var/obj/item/bodypart/bodypart as anything in victim.bodyparts)
		var/acid_armor = victim.check_armor(bodypart, ACID)
		if(acid_armor < 60) // You need acid armor above a certain value to not get affected, adjust for stronger rains!
			if(prob(max(0, (100-acid_armor))))
				bodypart.receive_damage(burn = WEATHER_ACID_BASE_DAMAGE)
				dealt_damage = TRUE
	if(dealt_damage)
		playsound(victim, 'sound/items/tools/welder.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)

#undef WEATHER_ACID_BASE_DAMAGE
