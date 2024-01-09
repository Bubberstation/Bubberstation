// I am so sorry for this hack, but I can't figure out a better way


/datum/species/android/digi
	name = "Digitigrade Android"
	id = SPECIES_ANDROID_DIGI
	
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/android,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/android,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/android,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/android,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/android/digi,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/android/digi,
	)
