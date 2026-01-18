#define BASE_CLOTH_X_1 1
#define BASE_CLOTH_Y_1 1

#define SERPENTID_COLD_THRESHOLD_1 180
#define SERPENTID_COLD_THRESHOLD_2 140
#define SERPENTID_COLD_THRESHOLD_3 100

#define SERPENTID_HEAT_THRESHOLD_1 300
#define SERPENTID_HEAT_THRESHOLD_2 440
#define SERPENTID_HEAT_THRESHOLD_3 600

/datum/species/gas
	name = "Giant Armored Serpentid"
	id = SPECIES_GAS
	eyes_icon = 'modular_skyrat/modules/organs/icons/serpentid_eyes.dmi'
	can_augment = FALSE

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_PUSHIMMUNE,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_SLIP_ALL,

	)
	no_equip_flags = ITEM_SLOT_FEET | ITEM_SLOT_OCLOTHING | ITEM_SLOT_SUITSTORE
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	no_gender_shaping = TRUE
	mutanttongue = /obj/item/organ/tongue/insect

	always_customizable = FALSE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 25)

	mutantbrain = /obj/item/organ/brain/serpentid
	mutanteyes = /obj/item/organ/eyes/serpentid
	mutantlungs = /obj/item/organ/lungs/serpentid
	mutantheart = /obj/item/organ/heart/serpentid
	mutantliver = /obj/item/organ/liver/serpentid
	mutantears = /obj/item/organ/ears/serpentid
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/serpentid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/serpentid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/serpentid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/serpentid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/serpentid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/serpentid,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = SERPENTID_HEAD_ICON,
		LOADOUT_ITEM_MASK = SERPENTID_MASK_ICON,
		LOADOUT_ITEM_UNIFORM = SERPENTID_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  SERPENTID_HANDS_ICON,
		LOADOUT_ITEM_GLASSES = SERPENTID_EYES_ICON,
		LOADOUT_ITEM_BELT = SERPENTID_BELT_ICON,
		LOADOUT_ITEM_MISC = SERPENTID_BACK_ICON,
		LOADOUT_ITEM_EARS = SERPENTID_EARS_ICON
	)

/datum/species/gas/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	var/main_color
	var/random = rand(1,6)
	switch(random)
		if(1)
			main_color = "#44FF77"
		if(2)
			main_color = "#227900"
		if(3)
			main_color = "#c40000"
		if(4)
			main_color = "#660000"
		if(5)
			main_color = "#c0ad00"
		if(6)
			main_color = "#e6ff03"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = main_color
	features[FEATURE_MUTANT_COLOR_THREE] = main_color
	return features

/datum/species/gas/prepare_human_for_preview(mob/living/carbon/human/serpentid)
	var/serpentid_color = "#00ac1d"
	serpentid.dna.features["mcolor"] = serpentid_color
	serpentid.dna.features["mcolor2"] = serpentid_color
	serpentid.dna.features["mcolor3"] = serpentid_color
	regenerate_organs(serpentid, src, visual_only = TRUE)
	serpentid.update_body(TRUE)

/datum/species/gas/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Durable leather",
		SPECIES_PERK_DESC = "The Giant Armored Serpentid chitin is very robust and protects them from pressure and low temperature hazards, while also providing decent brute resistance."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Heavy Skeleton",
		SPECIES_PERK_DESC = "Giant Armored Serpentid are large and heavy. They can't be properly grabbed by other creatures."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Custom body",
		SPECIES_PERK_DESC = "Giant Armored Serpentid has a nonhumanoid body and can't wear most clothes."
	))

	return perk_descriptions

/obj/item/organ/ears/serpentid
	name = "serpentid ears"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "ears"

/obj/item/organ/heart/serpentid
	name = "serpentid heart"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "heart"

/obj/item/organ/brain/serpentid
	name = "serpentid brain"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "brain"

/obj/item/organ/eyes/serpentid
	name = "serpentid eyes"
	desc = "Small orange orbs."
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	iris_overlay = null
	blink_animation = FALSE
	eye_icon = 'modular_skyrat/modules/organs/icons/serpentid_eyes.dmi'
	eye_icon_state = "eyes"

/obj/item/organ/lungs/serpentid
	name = "serpentid lungs"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "lungs"

	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = SERPENTID_COLD_THRESHOLD_1
	cold_level_2_threshold = SERPENTID_COLD_THRESHOLD_2
	cold_level_3_threshold = SERPENTID_COLD_THRESHOLD_3
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BRUTE


	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = SERPENTID_HEAT_THRESHOLD_1
	heat_level_2_threshold = SERPENTID_HEAT_THRESHOLD_2
	heat_level_3_threshold = SERPENTID_HEAT_THRESHOLD_3
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/liver/serpentid
	name = "skrell liver"
	icon_state = "liver"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	liver_resistance = 0.8 * LIVER_DEFAULT_TOX_RESISTANCE // -40%

/obj/item
	var/datum/greyscale_config/greyscale_config_worn_serpentid_fallback

/datum/species/gas/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_gas

/datum/species/gas/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_gas = icon

/datum/species/gas/get_custom_worn_config_fallback(item_slot, obj/item/item)
	return item.greyscale_config_worn_serpentid_fallback

/datum/species/gas/generate_custom_worn_icon(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	. = ..()
	if(.)
		return

	. = generate_custom_worn_icon_fallback(item_slot, item, human_owner)
	if(.)
		return

/obj/item/clothing/under
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid

/obj/item/clothing/neck
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/scarf

/obj/item/clothing/neck/cloak
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/cloak

/obj/item/clothing/neck/tie
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/tie

/obj/item/clothing/gloves
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/gloves

/obj/item/clothing/glasses
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/eyes

/obj/item/clothing/belt
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/belt

#undef BASE_CLOTH_X_1
#undef BASE_CLOTH_Y_1
#undef SERPENTID_COLD_THRESHOLD_1
#undef SERPENTID_COLD_THRESHOLD_2
#undef SERPENTID_COLD_THRESHOLD_3
#undef SERPENTID_HEAT_THRESHOLD_1
#undef SERPENTID_HEAT_THRESHOLD_2
#undef SERPENTID_HEAT_THRESHOLD_3
