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
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/datum/armor/armor_forging_plate_armor
	melee = 40
	bullet = 40
	fire = 50
	wound = 30

/obj/item/clothing/suit/armor/forging_plate_armor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_OCLOTHING)

	allowed += /obj/item/forging/reagent_weapon

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
	armor_type = /datum/armor/gloves_forging_plate_gloves
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/datum/armor/gloves_forging_plate_gloves
	melee = 40
	bullet = 40
	fire = 50
	wound = 30

/obj/item/clothing/gloves/forging_plate_gloves/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_GLOVES)

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
	armor_type = /datum/armor/helmet_forging_plate_helmet
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/datum/armor/helmet_forging_plate_helmet
	melee = 40
	bullet = 40
	fire = 50
	wound = 30

/obj/item/clothing/head/helmet/forging_plate_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_HEAD)

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
	armor_type = /datum/armor/shoes_forging_plate_boots
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	fastening_type = SHOES_SLIPON

/datum/armor/shoes_forging_plate_boots
	melee = 20
	bullet = 20

/obj/item/clothing/shoes/forging_plate_boots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_FEET)

/obj/item/clothing/shoes/horseshoe/reagent_clothing
	name = "reagent horseshoes"
	desc = "A pair of horseshoes made out of chains."

	armor_type = /datum/armor/shoes_horseshoe
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/datum/armor/shoes_horseshoe
	melee = 20
	bullet = 20

/obj/item/clothing/shoes/horseshoe/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_FEET)

////////////////////////////////////////////////////////////////////////////
////////////////////////////// BELTS ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/obj/item/storage/belt/holster/blacksmithed
	name = "parent dev item"
	desc = "you shouldn't be seeing this."
	abstract_type = /obj/item/storage/belt/holster/blacksmithed
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "cowboy_holster"
	inhand_icon_state = "holster"
	worn_icon_state = "holster"
	alternate_worn_layer = null
	storage_type = /datum/storage/holster

/obj/item/storage/belt/holster/blacksmithed/update_overlays()
	. = ..()
	if(!content_overlays)
		return
	for(var/obj/item/I in contents)
		if(istype(I, /obj/item/gun/ballistic/revolver))
			. += mutable_appearance('modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi', "belt_gun_wood")
			return
		if(istype(I, /obj/item/gun))
			. += mutable_appearance('modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi', "belt_gun_black")
			return
		if(istype(I, /obj/item/melee/baton/security))
			. += mutable_appearance('modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi', "belt_gun_baton")
			return

/obj/item/storage/belt/holster/blacksmithed/cowboy
	name = "quickdraw holster"
	desc = "A rugged leather holster belt. Will handily carry a gun; <b>the leather holster pouch makes drawing your gun a cinch</b>. Also comes with some side pockets for speedloaders and magazines."
	icon_state = "cowboy_holster"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	alternate_worn_layer = null
	storage_type = /datum/storage/cowboy_holster

/datum/storage/cowboy_holster
	max_slots = 4
	max_total_storage = 6
	open_sound = 'sound/items/handling/holster_open.ogg'
	open_sound_vary = TRUE

/datum/storage/cowboy_holster/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	. = ..()
	if(length(holdables))
		set_holdable(holdables)
		return

	set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
	))

/datum/storage/cowboy_holster/attempt_insert(obj/item/to_insert, mob/user, override = FALSE, force = STORAGE_NOT_LOCKED, messages = TRUE)
	. = ..()
	sort_contents()
	parent.update_appearance()

//resorts the contents so that guns are always the first thing pulled.
/datum/storage/cowboy_holster/proc/sort_contents()
	var/list/gunz = list()
	var/list/everything_else = list()
	/*
	for(obj/item/i in parent.contents)
		if(istype(i, /obj/item/gun/))
			gunz += i
		else
			everything_else += i
	parent.contents = everything_else + gunz*/

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

/obj/item/clothing/gloves/ring/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_GLOVES)

/obj/item/clothing/neck/collar/reagent_clothing
	name = "reagent collar"
	desc = "A collar that is ready to be worn for certain individuals."
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
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_NECK)

/obj/item/restraints/handcuffs/reagent_clothing
	name = "reagent handcuffs"
	desc = "A pair of handcuffs that are ready to keep someone captive."
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/restraints/handcuffs/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/clothing, ITEM_SLOT_HANDCUFFED)
