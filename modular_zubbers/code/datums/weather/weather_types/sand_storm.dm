//Basically a reskinned Ash Storm

GLOBAL_LIST_EMPTY(sand_storm_sounds)

/datum/weather/sand_storm
	name = "sand storm"
	desc = "An intense atmospheric storm lifts sand off of the planet's surface and billows it down across the area, dealing intense burn damage to the unprotected."

	telegraph_message = "<span class='boldwarning'>Stacks of dark clouds and cloudy sand cover the horizon. Seek shelter.</span>"
	telegraph_duration = 600
	telegraph_overlay = "sandstorm_light"

	weather_message = "<span class='userdanger'><i>Smoldering particles of sand billow down around you! Get inside!</i></span>"
	weather_duration_lower = 1200
	weather_duration_upper = 2400
	weather_overlay = "sandstorm"

	end_message = "<span class='boldannounce'>The shrieking wind whips away the last of the sand and falls to its usual murmur. It should be safe to go outside now.</span>"
	end_duration = 600
	end_overlay = "sandstorm_light"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_SANDSTORM

	immunity_type = TRAIT_ASHSTORM_IMMUNE

	probability = 60

	barometer_predictable = TRUE
	var/list/weak_sounds = list()
	var/list/strong_sounds = list()

/datum/weather/sand_storm/telegraph()
	var/list/eligible_areas = list()
	for (var/z in impacted_z_levels)
		eligible_areas += SSmapping.areas_in_z["[z]"]
	for(var/i in 1 to eligible_areas.len)
		var/area/place = eligible_areas[i]
		if(place.ignore_weather_sfx)
			continue
		if(place.outdoors)
			weak_sounds[place] = /datum/looping_sound/weak_outside_ashstorm
			strong_sounds[place] = /datum/looping_sound/active_outside_ashstorm
		/* Uncommented out because this annoying. Not fully deleted because I might add better sounds in the future. Possibly. Maybe. Probably not.
		else
			weak_sounds[place] = /datum/looping_sound/weak_inside_ashstorm
			strong_sounds[place] = /datum/looping_sound/active_inside_ashstorm
		*/
		CHECK_TICK

	//We modify this list instead of setting it to weak/stron sounds in order to preserve things that hold a reference to it
	//It's essentially a playlist for a bunch of components that chose what sound to loop based on the area a player is in
	GLOB.sand_storm_sounds += weak_sounds
	return ..()

/datum/weather/sand_storm/start()
	GLOB.sand_storm_sounds -= weak_sounds
	GLOB.sand_storm_sounds += strong_sounds
	return ..()

/datum/weather/sand_storm/wind_down()
	GLOB.sand_storm_sounds -= strong_sounds
	GLOB.sand_storm_sounds += weak_sounds
	return ..()

/datum/weather/sand_storm/can_weather_act(mob/living/mob_to_check)
	. = ..()
	if(!. || !ishuman(mob_to_check))
		return
	var/mob/living/carbon/human/human_to_check = mob_to_check
	if(human_to_check.get_thermal_protection() >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		return FALSE

/datum/weather/sand_storm/end()
	GLOB.sand_storm_sounds -= weak_sounds
	return ..()

/// Copied from the base weather.dm file to make this modular. I fucking hate modularity.
/datum/weather/sand_storm/generate_overlay_cache()
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

/datum/weather/sand_storm/can_get_alert(mob/player)

	if(!..())
		return FALSE

	if(isobserver(player))
		return TRUE

	if(HAS_MIND_TRAIT(player, TRAIT_DETECT_STORM))
		return TRUE

	if(istype(get_area(player), /area/moonstation/surface))
		return TRUE

	return FALSE

/mob/Login()
	. = ..()
	if(.)
		AddElement(/datum/element/weather_listener, /datum/weather/sand_storm, ZTRAIT_SANDSTORM, GLOB.sand_storm_sounds)

/datum/component/object_possession/bind_to_new_object(obj/target)

	. = ..()
	if(.)
		target.AddElement(/datum/element/weather_listener, /datum/weather/sand_storm, ZTRAIT_SANDSTORM, GLOB.sand_storm_sounds)

/datum/component/object_possession/cleanup_object_binding()

	var/was_valid = possessed && !QDELETED(possessed)

	. = ..()

	if(was_valid)
		possessed.RemoveElement(/datum/element/weather_listener, /datum/weather/sand_storm, ZTRAIT_SANDSTORM, GLOB.sand_storm_sounds)


#define WEATHER_BASE_DAMAGE 2.5

/datum/weather/sand_storm/weather_act(mob/living/victim)

	if(victim.resistance_flags & FIRE_PROOF)
		return

	if(ishuman(victim))
		var/mob/living/carbon/human/victim_as_human = victim

		var/heat_protection_flags = victim_as_human.get_heat_protection_flags(400) //400 is the minimum that shows up in the examine menu.

		var/obj/item/organ/internal/eyes/victim_eyes = victim_as_human.get_organ_slot(ORGAN_SLOT_EYES)
		if(victim_eyes && !victim_as_human.is_pepper_proof() && !victim_as_human.get_eye_protection())
			//If we're pepper spray immune or have eye protection, don't blind. This should get all masks and goggles.
			if(!victim.is_eyes_covered())
				//If you're at least wearing some eye protection, then you won't get the organ damage, just the blur.
				victim_eyes.apply_organ_damage(2)
			victim_as_human.set_eye_blur_if_lower(10 SECONDS)

		if(!(heat_protection_flags & (HEAD)))
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6), BRUTE, BODY_ZONE_HEAD)
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6), BURN, BODY_ZONE_HEAD)

		if(!(heat_protection_flags & (CHEST|GROIN)))
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6), BRUTE, BODY_ZONE_CHEST)
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6), BURN, BODY_ZONE_CHEST)

		if(!(heat_protection_flags & (ARMS)))
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BRUTE, BODY_ZONE_L_ARM)
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BRUTE, BODY_ZONE_R_ARM)

			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BURN, BODY_ZONE_L_ARM)
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BURN, BODY_ZONE_R_ARM)

		if(!(heat_protection_flags & (FEET|GROIN)))
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BRUTE, BODY_ZONE_L_LEG)
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BRUTE, BODY_ZONE_R_LEG)

			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BURN, BODY_ZONE_L_LEG)
			victim_as_human.apply_damage(WEATHER_BASE_DAMAGE*(1/6)*0.5, BURN, BODY_ZONE_R_LEG)

	else
		victim.adjustBruteLoss(WEATHER_BASE_DAMAGE*0.5)
		victim.adjustFireLoss(WEATHER_BASE_DAMAGE*0.5)

#undef WEATHER_BASE_DAMAGE


//Suits
/obj/item/clothing/suit/costume/poncho
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = 400

/obj/item/clothing/suit/cowboyvest
	heat_protection = CHEST
	max_heat_protection_temperature = 400

/obj/item/clothing/suit/jacket/det_suit/cowboyvest
	heat_protection = CHEST
	max_heat_protection_temperature = 400

//Uniforms
/obj/item/clothing/under/rank/security/detective/cowboy
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = 400

//Hats
/obj/item/clothing/head/costume/sombrero
	heat_protection = HEAD
	max_heat_protection_temperature = 400

/obj/item/clothing/head/cowboy
	heat_protection = HEAD
	max_heat_protection_temperature = 400

/obj/item/clothing/head/cowboy/skyrat
	heat_protection = HEAD
	max_heat_protection_temperature = 400

//Shoes
/obj/item/clothing/shoes/cowboy
	heat_protection = FEET
	max_heat_protection_temperature = 400

/obj/item/clothing/shoes/cowboyboots
	heat_protection = FEET
	max_heat_protection_temperature = 400
