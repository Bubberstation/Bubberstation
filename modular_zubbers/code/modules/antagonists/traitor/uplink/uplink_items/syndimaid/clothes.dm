// Same as a armor deployed redsuit
/datum/armor/clothing_under/syndimaid
	acid = 90
	bio = 100
	bomb = 40
	bullet = 50
	energy = 40
	fire = 50
	laser = 30
	melee = 40
	wound = 25

/obj/item/clothing/under/syndicate/skyrat/maid/armored
	desc = "A 'tactical' skirtleneck fashioned to the likeness of a maid outfit.\
	 The armor on this one is bulky and blocks the user from wearing any chest armor."
	armor_type = /datum/armor/clothing_under/syndimaid
	body_parts_covered = CHEST|GROIN|LEGS
	resistance_flags = parent_type::resistance_flags | FIRE_PROOF

	var/is_worn = FALSE // This is to avoid any jank with the equip chain that I know exists

/obj/item/clothing/under/syndicate/skyrat/maid/armored/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_POST_EQUIPPED, PROC_REF(check_equip))

/obj/item/clothing/under/syndicate/skyrat/maid/armored/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ITEM_POST_EQUIPPED)

/obj/item/clothing/under/syndicate/skyrat/maid/armored/mob_can_equip(mob/living/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(slot == ITEM_SLOT_ICLOTHING)
		var/mob/living/carbon/human/human_wearer = user
		if(human_wearer.wear_suit)
			return FALSE
	. = ..()

/obj/item/clothing/under/syndicate/skyrat/maid/armored/proc/check_equip(datum/source, mob/user, slot, initial)
	SIGNAL_HANDLER
	if(slot == ITEM_SLOT_ICLOTHING)
		RegisterSignal(user, COMSIG_HUMAN_EQUIPPING_ITEM, PROC_REF(block_equips))
		RegisterSignal(user, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(remove_block))
		is_worn = TRUE
	else if(is_worn)
		UnregisterSignal(user, list(COMSIG_HUMAN_EQUIPPING_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM))
		is_worn = FALSE

/obj/item/clothing/under/syndicate/skyrat/maid/armored/proc/remove_block(datum/source, obj/item, force, newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER
	if(is_worn)
		UnregisterSignal(source, list(COMSIG_HUMAN_EQUIPPING_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM))
		is_worn = FALSE

/obj/item/clothing/under/syndicate/skyrat/maid/armored/proc/block_equips(datum/source, mob/target, slot)
	SIGNAL_HANDLER
	if(slot == ITEM_SLOT_OCLOTHING)
		return COMPONENT_BLOCK_EQUIP

/obj/item/clothing/head/costume/maidheadband/syndicate/armored
	armor_type = /datum/armor/clothing_under/syndimaid
	body_parts_covered = HEAD
	resistance_flags = parent_type::resistance_flags | FIRE_PROOF

/obj/item/clothing/gloves/combat/maid/armored
	armor_type = /datum/armor/clothing_under/syndimaid
	body_parts_covered = HANDS | ARMS
	resistance_flags = parent_type::resistance_flags | FIRE_PROOF

/obj/item/clothing/shoes/jackboots/heel/tactical
	name = "tactical high-heeled jackboots"
	clothing_traits = list(TRAIT_NO_SLIP_WATER)
