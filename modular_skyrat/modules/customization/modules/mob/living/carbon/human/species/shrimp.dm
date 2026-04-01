/datum/species/shrimp
	name = "Shrimp"
	id = SPECIES_SHRIMP
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_FIXED_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	eyes_icon = 'modular_skyrat/modules/organs/icons/shrimp_eyes.dmi'
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/tongue/shrimp
	mutanteyes = /obj/item/organ/eyes/shrimp
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_SHRIMP
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/shrimp,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/shrimp,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/shrimp,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/shrimp,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/shrimp,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/shrimp,
	)

	meat = /obj/item/food/fishmeat/moonfish/akula
	sort_bottom = TRUE

/datum/species/shrimp/get_default_mutant_bodyparts()
	return list(
		"legs" = list("Normal Legs", FALSE),
	)

/obj/item/organ/tongue/shrimp
	liked_foodtypes = SEAFOOD | MEAT | FRUIT | GORE
	disliked_foodtypes = CLOTH | GROSS
	toxic_foodtypes = TOXIC


/datum/species/shrimp/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of sharkish colors, with a whiter secondary and tertiary
	switch(random)
		if(1)
			main_color = "#FFFFFF"
			second_color = "#FFFFFF"
		if(2)
			main_color = "#FFFFFF"
			second_color = "#FFFFFF"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = second_color
	return features

/datum/species/shrimp/prepare_human_for_preview(mob/living/carbon/human/shrimp)
	var/main_color = "#FFFFFF"
	var/secondary_color = "#FFFFFF"
	var/tertiary_color = "#FFFFFF"
	shrimp.dna.features["mcolor"] = main_color
	shrimp.dna.features["mcolor2"] = secondary_color
	shrimp.dna.features["mcolor3"] = tertiary_color
	shrimp.dna.features["legs"] = "Normal Legs"
	regenerate_organs(shrimp, src, visual_only = TRUE)
	shrimp.update_body(TRUE)

/datum/species/shrimp/get_species_description()
	return placeholder_description

/datum/species/shrimp/get_species_lore()
	return list(placeholder_lore)

/obj/item/organ/eyes/shrimp
	name = "shrimp eyes"
	desc = "I see rice... I must fry."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "eyes"
	iris_overlay = null
	blink_animation = FALSE
	eye_icon = 'modular_skyrat/modules/organs/icons/shrimp_eyes.dmi'
	eye_icon_state = "shrimp_eyes"
