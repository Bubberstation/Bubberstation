/datum/species/werewolf
	id = SPECIES_WEREWOLF
	examine_limb_id = SPECIES_WEREWOLF

	name = "Werewolf"
	sexes = TRUE

	digitigrade_customization = DIGITIGRADE_FORCED

	mutant_bodyparts = list(
	mutantbrain = /obj/item/organ/brain/werewolf,
	mutantheart = /obj/item/organ/heart/werewolf,
	mutantstomach = /obj/item/organ/stomach/werewolf,
	mutantlungs = /obj/item/organ/lungs/werewolf,
	mutantliver = /obj/item/organ/liver/werewolf,
	mutantappendix = null, // Wolves don't have appendixes
	mutanteyes = /obj/item/organ/eyes/werewolf,
	mutantears = /obj/item/organ/ears/werewolf,
	mutanttongue = /obj/item/organ/tongue/werewolf,
	)

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

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
		TRAIT_MUTANT_COLORS,
		TRAIT_LUPINE,
		TRAIT_BEAST_FORM,
	)
