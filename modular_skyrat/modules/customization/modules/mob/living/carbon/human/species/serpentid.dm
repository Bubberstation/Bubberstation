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
	mutanttongue = /obj/item/organ/tongue/synth
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
		LOADOUT_ITEM_HANDS = SERPENTID_HANDS_ICON,
		LOADOUT_ITEM_GLASSES = SERPENTID_EYES_ICON,
		LOADOUT_ITEM_BELT = SERPENTID_BELT_ICON,
		LOADOUT_ITEM_MISC = SERPENTID_BACK_ICON,
		LOADOUT_ITEM_EARS = SERPENTID_EARS_ICON
	)

/datum/species/gas/randomize_features()
	var/list/features = ..()
	var/main_color
	var/random = rand(1, 6)
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
	serpentid.dna.features[FEATURE_MUTANT_COLOR] = serpentid_color
	serpentid.dna.features[FEATURE_MUTANT_COLOR_TWO] = serpentid_color
	serpentid.dna.features[FEATURE_MUTANT_COLOR_THREE] = serpentid_color
	regenerate_organs(serpentid, src, visual_only = TRUE)
	serpentid.update_body(TRUE)

/datum/species/gas/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD,
		SPECIES_PERK_NAME = "Durable Chitin",
		SPECIES_PERK_DESC = "The Giant Armored Serpentid chitin is very robust and protects them from pressure and low temperature hazards, while also providing decent brute resistance."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_WEIGHT_HANGING,
		SPECIES_PERK_NAME = "Heavy Skeleton",
		SPECIES_PERK_DESC = "Giant Armored Serpentid are large and heavy, this makes them excellent at avoiding slipping and being grabbed."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_USER_NINJA,
		SPECIES_PERK_NAME = "Active Camouflage",
		SPECIES_PERK_DESC = "The cells in a Giant Armored Serpentid's body are able to camouflage themselves to an extent, making the GAS appear translucent to the naked eye."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_EYE,
		SPECIES_PERK_NAME = "Shielded Eyes",
		SPECIES_PERK_DESC = "Giant Armored Serpentid have sensitive eyes, luckily they have eyeshields that can be used to make up for this."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_FACE_ANGRY,
		SPECIES_PERK_NAME = "Threat Display",
		SPECIES_PERK_DESC = "Giant Armored Serpentid are not good at communication, however, they can perform a threat display to show when they want to attack someone."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Custom Body",
		SPECIES_PERK_DESC = "Giant Armored Serpentid have a non-humanoid body and can't wear most clothes."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_TEMPERATURE_HALF,
		SPECIES_PERK_NAME = "Cold-Blooded",
		SPECIES_PERK_DESC = "Giant Armored Serpentid are a cold blooded species and are vulnerable to temperature changes in their environment."
	))

	return perk_descriptions

/datum/species/gas/get_species_description()
	return list(
		"Giant Armoured Serpentids, or GAS as they are often called are large insectoids hailing from a planet in the Tiziran Empire. \
		They are excellent hunters, with phenomenal stealth capabilities, but are lacking in communication skills."
	)

/datum/species/gas/get_species_lore()
	return list(
		"The Giant Armoured Serpentids are an old race, of insectoid creatures from a high gravity world in the Tiziran Empire. \
		Covered in intersecting scales, with a pair of huge claws as their main limbs, they vaguely resemble Terran mantids, though they've more \
		in common with snakes and other reptiles from a Terran point of view.",
		"Living in a semi-hive/colony state, GAS, as they're referred to by Nanotrasen, have a lack of self identity compared to most species, \
		with few having a given name. This however is routinely ignored by most other races, and often they assign one to one they're working with, \
		for ease of communication. While they live in large colonies with other GAS, up to and rarely exceeding two hundred individuals, they do not \
		care for physical interaction with most, preferring to be left alone and given their personal space, such that they can seem aggressive even \
		when normal actions such as a handshake or hug are offered by ignorant members of other species."
	)
/datum/species/gas/body_temperature_core(mob/living/carbon/human/humi, seconds_per_tick, times_fired)
	return

/obj/item/organ/ears/serpentid
	name = "antennae"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "ears"

/obj/item/organ/heart/serpentid
	name = "serpentid heart"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "heart"
	actions_types = list(/datum/action/cooldown/spell/toggle_active_camo)
	var/camouflaged = FALSE

/obj/item/organ/heart/serpentid/proc/toggle_camo()
	if(!camouflaged)
		owner.alpha = 100
		camouflaged = TRUE
	else
		owner.alpha = 255
		camouflaged = FALSE

/obj/item/organ/brain/serpentid
	name = "distributed nervous system"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "brain"
	actions_types = list(/datum/action/cooldown/spell/toggle_threat_display)

/obj/item/organ/eyes/serpentid
	name = "compound eyes"
	desc = "Small orange orbs."
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
	iris_overlay = null
	blink_animation = FALSE
	eye_icon = 'modular_skyrat/modules/organs/icons/serpentid_eyes.dmi'
	eye_icon_state = "eyes"
	actions_types = list(/datum/action/cooldown/spell/toggle_eye_shields)
	var/eyes_shielded

/obj/item/organ/lungs/serpentid
	name = "tracheae"
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
	name = "toxin filter"
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
