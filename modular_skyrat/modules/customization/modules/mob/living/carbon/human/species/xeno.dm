/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = SPECIES_XENO
	family_heirlooms = list(/obj/item/toy/plush/rouny, /obj/item/toy/toy_xeno,)
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
	mutanttongue = /obj/item/organ/internal/tongue/xeno
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "Xenomorph Tail",
		"xenodorsal" = ACC_RANDOM,
		"xenohead" = ACC_RANDOM,
		"legs" = DIGITIGRADE_LEGS,
		"taur" = "None"
	)
	external_organs = list()
	liked_food = MEAT
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/xenohybrid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/xenohybrid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/xenohybrid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/xenohybrid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/xenohybrid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/xenohybrid,
	)

	meat = /obj/item/food/meat/slab/xeno
	skinned_type = /obj/item/stack/sheet/animalhide/xeno

/datum/species/xeno/get_species_description()
	return placeholder_description

/datum/species/xeno/get_species_lore()
	return list(placeholder_lore)

/datum/species/xeno/prepare_human_for_preview(mob/living/carbon/human/xeno)
	var/xeno_color = "#525288"
	xeno.dna.features["mcolor"] = xeno_color
	xeno.eye_color_left = "#30304F"
	xeno.eye_color_right = "#30304F"
	xeno.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Xenomorph Tail", MUTANT_INDEX_COLOR_LIST = list(xeno_color, xeno_color, xeno_color))
	xeno.dna.species.mutant_bodyparts["xenodorsal"] = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list(xeno_color))
	xeno.dna.species.mutant_bodyparts["xenohead"] = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list(xeno_color, xeno_color, xeno_color))
	xeno.update_mutant_bodyparts(TRUE)
	xeno.update_body(TRUE)
