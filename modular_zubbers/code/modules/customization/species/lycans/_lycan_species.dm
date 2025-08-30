/datum/species/lycan
	id = SPECIES_LYCAN
	examine_limb_id = SPECIES_LYCAN

	name = "\improper Lycan"
	sexes = TRUE

	coldmod = 0.67 // They have thick fur so I guess this makes sense.
	heatmod = 1.3

	digitigrade_customization = DIGITIGRADE_FORCED

	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/lycan
	mutantheart = /obj/item/organ/heart/lycan
	mutantstomach = /obj/item/organ/stomach/lycan
	mutantlungs = /obj/item/organ/lungs/lycan
	mutantliver = /obj/item/organ/liver/lycan
	mutantappendix = null // Wolves don't have appendixes
	mutanteyes = /obj/item/organ/eyes/lycan
	mutantears = /obj/item/organ/ears/lycan
	mutanttongue = /obj/item/organ/tongue/lycan

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/lycan,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/lycan,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/lycan,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/lycan,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/lycan,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/lycan,
	)

	inherent_traits = list(
		// Default Species
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS_2,
		TRAIT_NO_UNDERWEAR, // They should still be able to toggle genitals if needed.
		// Lycan Specific Things
		TRAIT_LUPINE,
		TRAIT_BEAST_FORM,
		TRAIT_NOGUNS,
		TRAIT_LYCAN,
		TRAIT_QUICKER_CARRY, // It'd be on par with nitrile gloves.
		TRAIT_PIERCEIMMUNE, // Thick skin
		TRAIT_ILLITERATE, // To avoid using consoles or such.
		TRAIT_FAST_METABOLISM,
	)

	no_equip_flags = ITEM_SLOT_ICLOTHING | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_MASK | ITEM_SLOT_EYES | ITEM_SLOT_BACK | ITEM_SLOT_NECK

/datum/species/lycan/prepare_human_for_preview(mob/living/carbon/human/lycan)
	var/main_color = "#362d23"
	var/secondary_color = "#9c5852"
	var/tertiary_color = "#CCF6E2"
	lycan.dna.features["mcolor"] = main_color
	lycan.dna.features["mcolor2"] = secondary_color
	lycan.dna.features["mcolor3"] = tertiary_color
	lycan.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	lycan.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	lycan.dna.features["legs"] = "Digitigrade Legs"
	regenerate_organs(lycan, src, visual_only = TRUE)
	lycan.update_body(TRUE)

/mob/living/carbon/human/species/lycan
	race = /datum/species/lycan

/datum/species/lycan/get_species_description()
	return list(placeholder_description)

/datum/species/lycan/get_species_lore()
	return list(placeholder_lore)

/datum/species/lycan/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	gainer.AddElement(/datum/element/inorganic_rejection)

/datum/species/lycan/on_species_loss(mob/living/carbon/human/loser, datum/species/new_species, pref_load)
	. = ..()
	loser.RemoveElement(/datum/element/inorganic_rejection)
