/datum/species/mammal
	name = "Anthromorph" //Called so because the species is so much more universal than just mammals
	id = SPECIES_MAMMAL
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = "None",
		"ears" = ACC_RANDOM,
		"legs" = ACC_RANDOM,
		"taur" = "None",
		"fluff" = "None",
		"wings" = "None",
		"head_acc" = "None",
		"neck_acc" = "None"
	)
	liked_food = GRAIN | MEAT
	disliked_food = CLOTH | GROSS | GORE
	toxic_food = TOXIC
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant,
	)

/datum/species/mammal/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "#FFFFFF"
			second_color = "#333333"
			third_color = "#333333"
		if(2)
			main_color = "#FFFFDD"
			second_color = "#DD6611"
			third_color = "#AA5522"
		if(3)
			main_color = "#DD6611"
			second_color = "#FFFFFF"
			third_color = "#DD6611"
		if(4)
			main_color = "#CCCCCC"
			second_color = "#FFFFFF"
			third_color = "#FFFFFF"
		if(5)
			main_color = "#AA5522"
			second_color = "#CC8833"
			third_color = "#FFFFFF"
		if(6)
			main_color = "#FFFFDD"
			second_color = "#FFEECC"
			third_color = "#FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = "#[random_color()]"
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = second_color
	human_mob.dna.features["mcolor3"] = third_color

/datum/species/mammal/get_random_body_markings(list/passed_features)
	var/name = "None"
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/mammal/get_species_description()
	return "This is a template species for your own creations!"


/datum/species/mammal/get_species_lore()
	return list("Make sure you fill out your own custom species lore!")

/datum/species/mammal/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#333333"
	var/secondary_color = "#b8b8b8"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	human.dna.species.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Husky", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.species.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Husky", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, secondary_color))
	human.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Husky", MUTANT_INDEX_COLOR_LIST = list(main_color, "#4D4D4D", secondary_color))
	human.update_mutant_bodyparts(TRUE)
	human.update_body(TRUE)
