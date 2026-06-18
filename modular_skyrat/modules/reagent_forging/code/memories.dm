/// Keeps track of smithing items & what was made by who
/datum/memory/smithing
	story_value = STORY_VALUE_MEH
	// Protagonist - The smith making the item
	/// What type of crafting it was
	var/smithed_item_type = null
	/// name of the item for strings
	var/item_name = null

/datum/memory/smithing/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
)
	return ..()

/datum/memory/smithing/get_names()
	return list("The time [protagonist_name] made a [initial(item_name)].")

/datum/memory/smithing/get_starts()
	return list(
		"[protagonist_name] carefully assembling a [initial(item_name)].",
	)

/datum/memory/smithing/get_moods()
	return list(
		"[protagonist_name] [mood_verb] after finishing [initial(item_name)].",
	)

/datum/memory/smithing/sword
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/sword
	item_name = "sword"

/datum/memory/smithing/katana
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/katana
	item_name = "katana"

/datum/memory/smithing/dagger
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/dagger
	item_name = "dagger"

/datum/memory/smithing/rapier
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/rapier
	item_name = "rapier"

/datum/memory/smithing/spear
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/spear
	item_name = "spear"

/datum/memory/smithing/axe
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/axe
	item_name = "axe"

/datum/memory/smithing/hammer
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/hammer
	item_name = "hammer"

/datum/memory/smithing/buckler
	smithed_item_type = /obj/item/shield/buckler/reagent_weapon
	item_name = "buckler"

/datum/memory/smithing/pavise
	smithed_item_type = /obj/item/shield/buckler/reagent_weapon/pavise
	item_name = "pavise"

/datum/memory/smithing/revolver
	smithed_item_type = /obj/item/gun/ballistic/revolver/handcrafted_single_action
	item_name = "revolver"

/datum/memory/smithing/helmet
	smithed_item_type = /obj/item/clothing/head/helmet/forging_plate_helmet
	item_name = "hammer"

/datum/memory/smithing/plate_vest
	smithed_item_type = /obj/item/clothing/suit/armor/forging_plate_armor
	item_name = "plate vest"

/datum/memory/smithing/gloves
	smithed_item_type = /obj/item/clothing/gloves/forging_plate_gloves
	item_name = "pair of plate gloves"

/datum/memory/smithing/boots
	smithed_item_type = /obj/item/clothing/shoes/forging_plate_boots
	item_name = "pair of plate boots"

/datum/memory/smithing/horseshoes
	smithed_item_type = /obj/item/clothing/shoes/horseshoe/reagent_clothing
	item_name = "set of horseshoes"

/datum/memory/smithing/ring
	smithed_item_type = /obj/item/clothing/gloves/ring/reagent_clothing
	item_name = "ring"

/datum/memory/smithing/collar
	smithed_item_type = /obj/item/clothing/neck/collar/reagent_clothing
	item_name = "collar"

/datum/memory/smithing/cowboy_holster
	smithed_item_type = /obj/item/storage/belt/hip_holster/cowboy
	item_name = "holster"

/datum/memory/smithing/charging_holster
	smithed_item_type = /obj/item/storage/belt/hip_holster/charging
	item_name = "charging holster"

/datum/memory/smithing/crusader_belt
	smithed_item_type = /obj/item/storage/belt/crusader
	item_name = "utility-scabbard belt"

/datum/memory/smithing/multi_scabbard
	smithed_item_type = /obj/item/storage/belt/sheath/multi
	item_name = "multi-scabbard belt"

/datum/memory/smithing/repairing_scabbard
	smithed_item_type = /obj/item/storage/belt/sheath/repairing
	item_name = "repairing scabbard"

/datum/memory/smithing/knifethrower
	smithed_item_type = /obj/item/storage/belt/knifethrowers_belt
	item_name = "knifethrower's belt"

/datum/memory/smithing/bluespace_plants
	smithed_item_type = /obj/item/storage/bag/plants/bluespace
	item_name = "bluespace plants bag"
