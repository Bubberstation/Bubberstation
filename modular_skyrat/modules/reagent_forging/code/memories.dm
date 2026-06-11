/// Keeps track of smithing items & what was made by who
/datum/memory/smithing
	story_value = STORY_VALUE_MEH
	// Protagonist - The smith making the item
	/// What type of surgery it was
	var/smithed_item_type = null

/datum/memory/smithing/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
)
	return ..()

/datum/memory/smithing/get_names()
	return list("The time [protagonist_name] made a [smithed_item_type].")

/datum/memory/smithing/get_starts()
	return list(
		"[protagonist_name] carefully assembling a [smithed_item_type].",
	)

/datum/memory/smithing/get_moods()
	return list(
		"[protagonist_name] [mood_verb] after finishing [smithed_item_type].",
	)

/datum/memory/smithing/sword
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/sword

/datum/memory/smithing/katana
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/katana

/datum/memory/smithing/dagger
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/

/datum/memory/smithing/rapier
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/rapier

/datum/memory/smithing/spear
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/spear

/datum/memory/smithing/axe
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/axe

/datum/memory/smithing/hammer
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/hammer

/datum/memory/smithing/buckler
	smithed_item_type = /obj/item/shield/buckler/reagent_weapon

/datum/memory/smithing/pavise
	smithed_item_type = /obj/item/shield/buckler/reagent_weapon/pavise

/datum/memory/smithing/revolver
	smithed_item_type = /obj/item/gun/ballistic/revolver/handcrafted_single_action

/datum/memory/smithing/helmet
	smithed_item_type = /obj/item/clothing/head/helmet/forging_plate_helmet

/datum/memory/smithing/plate_vest
	smithed_item_type = /obj/item/clothing/suit/armor/forging_plate_armor

/datum/memory/smithing/gloves
	smithed_item_type = /obj/item/clothing/gloves/forging_plate_gloves

/datum/memory/smithing/boots
	smithed_item_type = /obj/item/clothing/shoes/forging_plate_boots

/datum/memory/smithing/horseshoes
	smithed_item_type = /obj/item/clothing/shoes/horseshoe/reagent_clothing

/datum/memory/smithing/ring
	smithed_item_type = /obj/item/clothing/gloves/ring/reagent_clothing

/datum/memory/smithing/collar
	smithed_item_type = /obj/item/clothing/neck/collar/reagent_clothing

/datum/memory/smithing/cowboy_holster
	smithed_item_type = /obj/item/storage/belt/hip_holster/cowboy

/datum/memory/smithing/charging_holster
	smithed_item_type = /obj/item/storage/belt/hip_holster/charging

/datum/memory/smithing/crusader_belt
	smithed_item_type = /obj/item/storage/belt/crusader

/datum/memory/smithing/multi_scabbard
	smithed_item_type = /obj/item/storage/belt/sheath/multi

/datum/memory/smithing/repairing_scabbard
	smithed_item_type = /obj/item/storage/belt/sheath/repairing

/datum/memory/smithing/knifethrower
	smithed_item_type = /obj/item/storage/belt/knifethrowers_belt

/datum/memory/smithing/bluespace_plants
	smithed_item_type = /obj/item/storage/bag/plants/bluespace
