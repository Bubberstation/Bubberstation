/datum/species/werewolf
	id = SPECIES_WEREWOLF
	examine_limb_id = SPECIES_WEREWOLF

	name = "\improper Werewolf"
	sexes = TRUE

	digitigrade_customization = DIGITIGRADE_FORCED

	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/werewolf
	mutantheart = /obj/item/organ/heart/werewolf
	mutantstomach = /obj/item/organ/stomach/werewolf
	mutantlungs = /obj/item/organ/lungs/werewolf
	mutantliver = /obj/item/organ/liver/werewolf
	mutantappendix = null // Wolves don't have appendixes
	mutanteyes = /obj/item/organ/eyes/werewolf
	mutantears = /obj/item/organ/ears/werewolf
	mutanttongue = /obj/item/organ/tongue/werewolf
	mutant_organs = list(
		/obj/item/organ/tail/fluffy/werewolf,
	)

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/werewolf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/werewolf,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/werewolf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/werewolf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/werewolf,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/werewolf,
	)

	inherent_traits = list(
		// Default Species
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS_2,
		TRAIT_NO_UNDERWEAR, // They should still be able to toggle genitals if needed.
		// Werewolf Specific Things
		TRAIT_LUPINE,
		TRAIT_BEAST_FORM,
		TRAIT_NOGUNS,
		TRAIT_WEREWOLF,
		TRAIT_QUICKER_CARRY, // It'd be on par with nitrile gloves.
		TRAIT_PIERCEIMMUNE, // Thick skin
		TRAIT_ILLITERATE, // To avoid using consoles or such.
	)

	no_equip_flags = ITEM_SLOT_ICLOTHING | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_MASK | ITEM_SLOT_EYES | ITEM_SLOT_BACK | ITEM_SLOT_NECK

/datum/species/werewolf/prepare_human_for_preview(mob/living/carbon/human/werewolf)
	var/main_color = "#362d23"
	var/secondary_color = "#9c5852"
	var/tertiary_color = "#CCF6E2"
	werewolf.dna.features["mcolor"] = main_color
	werewolf.dna.features["mcolor2"] = secondary_color
	werewolf.dna.features["mcolor3"] = tertiary_color
	werewolf.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	werewolf.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	werewolf.dna.features["legs"] = "Digitigrade Legs"
	regenerate_organs(werewolf, src, visual_only = TRUE)
	werewolf.update_body(TRUE)

/mob/living/carbon/human/species/werewolf
	race = /datum/species/werewolf

/datum/species/werewolf/get_species_description()
	return list(placeholder_description)

/datum/species/werewolf/get_species_lore()
	return list(placeholder_lore)

/mob/living/carbon/human/species/werewolf/Life(seconds_per_tick, times_fired)
	. = ..()
	var/erp_area = is_type_in_list(get_area(src), SIZE_WHITELISTED_AREAS) // It's not for size, but because it lists ERP areas.
	if(!erp_area)
		ADD_TRAIT(src, TRAIT_FAST_METABOLISM, SPECIES_TRAIT)
	else if(erp_area)
		REMOVE_TRAIT(src, TRAIT_FAST_METABOLISM, SPECIES_TRAIT)
