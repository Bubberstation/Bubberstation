/datum/species/mammal/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	say_mod = "mars"
	default_mutant_bodyparts = list(
		"mcolor" = "FFFFFF",
		"mcolor2" = "FFFFFF",
		"mcolor3" = "FFFFFF",
		"mam_tail" = "Shadekin",
		"mam_ears" = "Shadekin",
		"deco_wings" = "None",
		"taur" = "None",
		"horns" = "None",
		"legs" = "Plantigrade",
		"meat_type" = "Mammalian"
	)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/shadekin
	)
