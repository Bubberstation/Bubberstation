/datum/species/tajaran
	name = "Tajaran"
	id = SPECIES_TAJARAN
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
		TRAIT_HATED_BY_DOGS,
	)
	mutanttongue = /obj/item/organ/internal/tongue/cat
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	disliked_food = CLOTH
	liked_food = GRAIN | MEAT
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_MAMMAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant,
	)

/datum/species/tajaran/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of mostly coldish, animal, matching colors
	switch(random)
		if(1)
			main_color = "#BBAA88"
			second_color = "#AAAA99"
		if(2)
			main_color = "#777766"
			second_color = "#888877"
		if(3)
			main_color = "#AA9988"
			second_color = "#AAAA99"
		if(4)
			main_color = "#EEEEDD"
			second_color = "#FFEEEE"
		if(5)
			main_color = "#DDCC99"
			second_color = "#DDCCAA"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = second_color
	human_mob.dna.features["mcolor3"] = second_color

/datum/species/tajaran/get_random_body_markings(list/passed_features)
	var/name = pick("Tajaran", "Floof", "Floofer")
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/*	Runtime in tajaran.dm,76: pick() from empty list
/datum/species/tajaran/random_name(gender,unique,lastname)
	var/randname
	if(gender == MALE)
		randname = pick(GLOB.first_names_male_taj)
	else
		randname = pick(GLOB.first_names_female_taj)

	if(lastname)
		randname += " [lastname]"
	else
		randname += " [pick(GLOB.last_names_taj)]"

	return randname
*/

/datum/species/tajaran/get_species_description()
	return placeholder_description

/datum/species/tajaran/get_species_lore()
	return list(placeholder_lore)

/datum/species/tajaran/prepare_human_for_preview(mob/living/carbon/human/cat)
	var/main_color = "#AA9988"
	var/second_color = "#AAAA99"

	cat.dna.features["mcolor"] = main_color
	cat.dna.features["mcolor2"] = second_color
	cat.dna.features["mcolor3"] = second_color
	cat.dna.species.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Mammal, Short", MUTANT_INDEX_COLOR_LIST = list(main_color, main_color, main_color))
	cat.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list(second_color, main_color, main_color))
	cat.dna.species.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Cat, normal", MUTANT_INDEX_COLOR_LIST = list(main_color, second_color, second_color))
	cat.update_mutant_bodyparts(TRUE)
	cat.update_body(TRUE)
