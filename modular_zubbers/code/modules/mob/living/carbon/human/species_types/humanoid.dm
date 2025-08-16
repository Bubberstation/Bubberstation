/datum/species/humanoid
	name = "Humanoid"
	id = SPECIES_HUMANOID
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	examine_limb_id = SPECIES_HUMAN

/datum/species/humanoid/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"snout" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
		"wings" = list("None", FALSE),
		"taur" = list("None", FALSE),
		"horns" = list("None", FALSE),
	)

/datum/species/humanoid/get_species_description()
	return "This is a template species for your own creations!"

/datum/species/humanoid/get_species_lore()
	return list("Make sure you fill out your own custom species lore!")

/datum/species/humanoid/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#722011"
	var/secondary_color = "#161616"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = main_color
	human.dna.features["mcolor3"] = main_color
	human.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Curled", MUTANT_INDEX_COLOR_LIST = list(secondary_color, secondary_color, secondary_color))
	human.hairstyle = "Cornrows"
	human.hair_color = "#2b2b2b"
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)

/datum/species/humanoid
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mhuman,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mhuman,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mhuman,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mhuman,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mhuman,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mhuman,
	)

/datum/species/humanoid/get_species_description()
	return list(
		"(OOC Note: This is a generic template species for your own creations. As a new player, it is strongly recommended that you start with a premade species unless what you are writing is demonstrably better in quality than the server's counterparts.)",
		"Humans are generally known to be the most frequent species to receive gene modification, both due to higher personal wealth and a growing sense of inadequacy. Many variants and subspecies of human exist, though not all are equally accepted, and they are most commonly seen on Mars, where transhumanism is significantly more popular. As a humanoid or human-like character, think first of this question-- what is your character's relationship to being human, if any?",
	)

/datum/species/humanoid/get_species_lore()
	return list(
		"This is a template species for your own creation. Humanoids exist in all shape and sizes across the known galaxy, most frequently being loose genetic modifications of \
		human DNA. They are most commonly seen on Mars, where transhumanism is rife, and personal wealth is quite high for Terran space. They may be from a distant Rimworld, or \
		just be some sort of novelty-seeking furry. Other species generally look down upon seeing humans modified to look like their species, as it leads to a serious uncanny \ valley effect. How does your character navigate this, if an issue at all?",
	)
