
/datum/species/pod/xiarn
	name = "Xiarn"
	id = SPECIES_XIARN
	changesource_flags = MIRROR_BADMIN
	examine_limb_id = SPECIES_PODPERSON
	always_customizable = FALSE

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/pod/xiarn,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/pod/xiarn,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/pod/xiarn,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/pod/xiarn,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/pod/xiarn,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/pod/xiarn,
	)

/datum/species/pod/xiarn/check_roundstart_eligible()
	return FALSE

/obj/item/bodypart/arm/left/pod/xiarn
	brute_modifier = 0.75

/obj/item/bodypart/arm/right/pod/xiarn
	brute_modifier = 0.75

/obj/item/bodypart/head/pod/xiarn
	brute_modifier = 0.75

/obj/item/bodypart/leg/left/pod/xiarn
	brute_modifier = 0.75

/obj/item/bodypart/leg/right/pod/xiarn
	brute_modifier = 0.75

/obj/item/bodypart/chest/pod/xiarn
	brute_modifier = 0.75


/obj/item/mod/control/pre_equipped/interdyne/xiarn
	theme = /datum/mod_theme/interdyne/xiarn

/datum/mod_theme/interdyne/xiarn
	slowdown_active = 0
