/datum/armor/perfect_forged_armor_bonus
	melee = 20
	bullet = 20
	fire = 25
	laser = 10
	wound = 20

/datum/armor/smithing_oil_armor_bonus
	melee = 10
	bullet = 10

/datum/armor/armor_forging_plate_armor
	melee = 20
	bullet = 10
	fire = 50
	wound = 10
	laser = 15
	bomb = 25
	acid = 50
	wound = 50

// Vests
/obj/item/clothing/suit/armor/forging_plate_armor
	name = "reagent plate vest"
	desc = "An armor vest made of hammered, interlocking plates."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_vest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/armor_forging_plate_armor
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/clothing/suit/armor/forging_plate_armor/Initialize(mapload)
	. = ..()
	allowed += /obj/item/melee/forged_reagent_weapon
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_ARMOR = /datum/armor/smithing_oil_armor_bonus), set_slot = ITEM_SLOT_OCLOTHING)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_ARMOR = /datum/armor/perfect_forged_armor_bonus), \
		incompletion_effects = list(FORGE_EFFECT_ARMOR, FORGE_EFFECT_DURABILITY))

/obj/item/clothing/suit/armor/forging_plate_armor/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/clothing/suit/armor/forging_plate_armor/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

// Gloves
/obj/item/clothing/gloves/forging_plate_gloves
	name = "reagent plate gloves"
	desc = "A set of leather gloves with protective armor plates connected to the wrists."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_gloves"
	resistance_flags = FIRE_PROOF

	body_parts_covered = parent_type::body_parts_covered | ARMS
	armor_type = /datum/armor/armor_forging_plate_armor
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/clothing/gloves/forging_plate_gloves/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_ARMOR = /datum/armor/smithing_oil_armor_bonus), set_slot = ITEM_SLOT_GLOVES)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_ARMOR = /datum/armor/perfect_forged_armor_bonus), \
		incompletion_effects = list(FORGE_EFFECT_ARMOR, FORGE_EFFECT_DURABILITY))

/obj/item/clothing/gloves/forging_plate_gloves/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/clothing/gloves/forging_plate_gloves/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

// Helmets
/obj/item/clothing/head/helmet/forging_plate_helmet
	name = "reagent plate helmet"
	desc = "A helmet out of hammered plates with a leather neck guard and chin strap."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_helmet"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	flags_inv = null
	armor_type = /datum/armor/armor_forging_plate_armor
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/clothing/head/helmet/forging_plate_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_ARMOR = /datum/armor/smithing_oil_armor_bonus), set_slot = ITEM_SLOT_HEAD)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_ARMOR = /datum/armor/perfect_forged_armor_bonus), \
		incompletion_effects = list(FORGE_EFFECT_ARMOR, FORGE_EFFECT_DURABILITY))

/obj/item/clothing/head/helmet/forging_plate_helmet/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/clothing/head/helmet/forging_plate_helmet/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

// Boots
/obj/item/clothing/shoes/forging_plate_boots
	name = "reagent plate boots"
	desc = "A pair of leather boots with protective armor plates over the shins and toes."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_digi = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_digi.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_boots"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

	body_parts_covered = parent_type::body_parts_covered | LEGS
	armor_type = /datum/armor/armor_forging_plate_armor
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	resistance_flags = FIRE_PROOF
	fastening_type = SHOES_SLIPON

/obj/item/clothing/shoes/forging_plate_boots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_ARMOR = /datum/armor/smithing_oil_armor_bonus), set_slot = ITEM_SLOT_FEET)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_ARMOR = /datum/armor/perfect_forged_armor_bonus), \
		incompletion_effects = list(FORGE_EFFECT_ARMOR, FORGE_EFFECT_DURABILITY))

/obj/item/clothing/shoes/forging_plate_boots/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/clothing/shoes/forging_plate_boots/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

/obj/item/clothing/shoes/horseshoe/reagent_clothing
	name = "reagent horseshoes"
	desc = "A pair of horseshoes made out of chains."
	armor_type = /datum/armor/armor_forging_plate_armor
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/clothing/shoes/horseshoe/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_ARMOR = /datum/armor/smithing_oil_armor_bonus), set_slot = ITEM_SLOT_FEET)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_ARMOR = /datum/armor/perfect_forged_armor_bonus), \
		incompletion_effects = list(FORGE_EFFECT_ARMOR, FORGE_EFFECT_DURABILITY))

/obj/item/clothing/shoes/horseshoe/reagent_clothing/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/clothing/shoes/horseshoe/reagent_clothing/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

////////////////////////////////////////////////////////////////////////////
////////////////////////////// MISC ////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/obj/item/clothing/gloves/ring/reagent_clothing
	name = "reagent ring"
	desc = "A tiny ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	worn_icon_state = "sring"
	inhand_icon_state = null
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	var/current_perfection_bonus = 0
	var/current_completion_penalty = 0

/obj/item/clothing/gloves/ring/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_DURABILITY = 50), set_slot = ITEM_SLOT_GLOVES)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_REAGENT_INJECT = 0.2), \
		incompletion_effects = list(FORGE_EFFECT_REAGENT_INJECT, FORGE_EFFECT_DURABILITY))

////////////////////////////////////////////////////////////////////////////

/obj/item/clothing/neck/collar/reagent_clothing
	name = "reagent collar"
	desc = "A collar that is ready to be worn for... certain individuals."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_cyan"
	inhand_icon_state = null
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/clothing/neck/collar/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, list(FORGE_EFFECT_DURABILITY = 50), set_slot = ITEM_SLOT_NECK)
	AddComponent(/datum/component/forge_smithable, \
		FORGING_CLOTHING_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS, \
		FORGING_CLOTHING_REFORGING_MAX_BAD_HITS, \
		FORGING_CLOTHING_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_REAGENT_INJECT = 0.2), \
		incompletion_effects = list(FORGE_EFFECT_REAGENT_INJECT, FORGE_EFFECT_DURABILITY))

/obj/item/restraints/handcuffs/reagent_clothing
	name = "reagent handcuffs"
	desc = "A pair of handcuffs that are ready to keep someone captive."
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/restraints/handcuffs/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_HANDCUFFED)
