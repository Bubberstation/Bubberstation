/datum/weather/acid_rain
	name = "acid rainstorm"
	desc = "The planet's thunderstorms are by nature acidic, and will incinerate anyone standing beneath them without protection."
	probability = 90
	weather_effects_icon = 'modular_zubbers/icons/effects/weather_effects.dmi'

	telegraph_message = span_boldannounce("Thunder rumbles far above. You hear droplets drumming against the canopy. Seek shelter.")
	telegraph_duration = 400
	telegraph_sound = 'modular_zubbers/sound/ambience/acidrain_start.ogg'

	weather_message = span_userdanger("<i>Acidic rain pours down around you! Get inside!</i>")
	weather_overlay = "acid_rain"
	weather_duration_lower = 1200
	weather_duration_upper = 2400
	use_glow = FALSE
	weather_sound = 'modular_zubbers/sound/ambience/acidrain_mid.ogg'

	end_duration = 100
	end_message = span_boldannounce("The downpour gradually slows to a light shower. It should be safe outside now.")
	end_sound = 'modular_zubbers/sound/ambience/acidrain_end.ogg'

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

	if(HAS_MIND_TRAIT(player, TRAIT_DETECT_STORM))
		return TRUE

	for(var/area/acid_area as anything in impacted_areas)
		if(locate(acid_area) in view(player))
			return TRUE

	return FALSE

///Forever acid rain, I wouldn't suggest trying this.
/datum/weather/acid_rain/forever_storm
	telegraph_duration = 0
	perpetual = TRUE

	probability = 0

/// Copied from sand_storm.dm to get the acid rain to work properly.
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
	if(mob_to_check.resistance_flags & ACID_PROOF)
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
			if(prob(max(0, (100 - acid_armor))))
				bodypart.receive_damage(burn = WEATHER_ACID_BASE_DAMAGE)
				dealt_damage = TRUE
	if(dealt_damage)
		playsound(victim, 'sound/items/tools/welder.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)

#undef WEATHER_ACID_BASE_DAMAGE
