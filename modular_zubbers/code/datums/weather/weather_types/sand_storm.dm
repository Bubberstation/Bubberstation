/datum/weather/sand_storm

	telegraph_duration = 1 MINUTE

	weather_duration_lower = 2 MINUTES
	weather_duration_upper = 3 MINUTES

	end_duration = 30 SECONDS

	area_type = /area
	target_trait = ZTRAIT_SANDSTORM
	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 40

	weather_flags = (WEATHER_MOBS | WEATHER_BAROMETER)

	barometer_predictable = TRUE

/datum/weather/sand_storm/can_weather_act(mob/living/mob_to_check)
	. = ..()
	if(!. || !ishuman(mob_to_check))
		return
	var/mob/living/carbon/human/human_to_check = mob_to_check
	if(human_to_check.get_thermal_protection() >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		return FALSE

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


#define WEATHER_BASE_DAMAGE 2.5

/datum/weather/sand_storm/weather_act(mob/living/victim)

	if(victim.resistance_flags & FIRE_PROOF)
		return

	if(ishuman(victim))
		var/mob/living/carbon/human/victim_as_human = victim

		var/heat_protection_flags = victim_as_human.get_heat_protection_flags(400) //400 is the minimum that shows up in the examine menu.

		var/obj/item/organ/eyes/victim_eyes = victim_as_human.get_organ_slot(ORGAN_SLOT_EYES)
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
