/datum/species/mammal/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	say_mod = "mars"
	default_mutant_bodyparts = list(
		"tail" = "Shadekin",
		"snout" = "None",
		"horns" = "None",
		"ears" = "Shadekin",
		"taur" = "None",
		"fluff" = "None",
		"wings" = "None",
		"head_acc" = "None",
		"neck_acc" = "None"
	)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/shadekin
	)


/datum/species/mammal/shadekin/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#222222"
	var/secondary_color = "#b8b8b8"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	human.dna.species.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.species.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, secondary_color))
	human.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, "#4D4D4D", secondary_color))
	human.update_mutant_bodyparts(TRUE)
	human.update_body(TRUE)
