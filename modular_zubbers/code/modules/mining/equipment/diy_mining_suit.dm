/obj/item/miningsuitupgradekit
	name = "DIY explorer suit kit"
	desc = "A kit containing necessary parts to turn your hat and jacket of your choice into a mining suit. Note: Uncovered limbs will remain unprotected"
	icon = 'icons/obj/mining.dmi'
	icon_state = "retool_kit"
	var/helmet_uses = 1
	var/exosuit_uses = 1
	var/seva_kit = FALSE

/obj/item/miningsuitupgradekit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/clothing/upgraded_item = interacting_with

	if(!istype(upgraded_item))
		return ITEM_INTERACT_BLOCKING
	if(!istype(upgraded_item, /obj/item/clothing/suit) && !istype(upgraded_item, /obj/item/clothing/head))
		to_chat(user, span_warning("This kit will only work for head and suit slot clothing!"))
		return ITEM_INTERACT_BLOCKING
	if(istype(upgraded_item, /obj/item/clothing/suit) && exosuit_uses <= 0)
		to_chat(user, span_warning("Suit part already used!"))
		return ITEM_INTERACT_BLOCKING
	if(istype(upgraded_item, /obj/item/clothing/head) && helmet_uses <= 0)
		to_chat(user, span_warning("Helmet part already used!"))
		return ITEM_INTERACT_BLOCKING
	if(upgraded_item.get_armor_rating(MELEE) > 0)
		to_chat(user, span_warning("This clothing is already armored and can't be modified!"))
		return ITEM_INTERACT_BLOCKING

	if(istype(upgraded_item, /obj/item/clothing/suit))
		var/obj/item/clothing/suit/upgraded_suit = upgraded_item
		upgraded_suit.allowed = GLOB.mining_suit_allowed
		upgraded_suit.flags_inv = NONE
		exosuit_uses--

	if(istype(upgraded_item, /obj/item/clothing/head))
		helmet_uses--

	if(!seva_kit)
		upgraded_item.AddComponent(/datum/component/armor_plate)

	if(seva_kit)
		upgraded_item.clothing_traits = list(TRAIT_ASHSTORM_IMMUNE)

	upgraded_item.set_armor(seva_kit ? /datum/armor/hooded_seva : /datum/armor/hooded_explorer)
	upgraded_item.min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	upgraded_item.max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	upgraded_item.resistance_flags |= FIRE_PROOF

	upgraded_item.name = "[seva_kit ? "SEVA" : "reinforced"] [upgraded_item.name]"

	balloon_alert(user, "[initial(upgraded_item.name)] upgraded!")

	if(helmet_uses <= 0 && exosuit_uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/miningsuitupgradekit/click_alt(mob/user)
	if(!exosuit_uses || !helmet_uses)
		return CLICK_ACTION_BLOCKING
	seva_kit = !seva_kit
	name = "DIY [seva_kit ? "SEVA" : "explorer"] suit kit"
	balloon_alert(user, "mode changed!")
	return CLICK_ACTION_SUCCESS

/obj/item/miningsuitupgradekit/examine(mob/user)
	. = ..()
	if(helmet_uses)
		. += "It can be used to upgrade [helmet_uses] more hat[(helmet_uses > 1) ? "s" : ""]"
	if(exosuit_uses)
		. += "It can be used to upgrade [exosuit_uses] more suit[(exosuit_uses > 1) ? "s" : ""]"
	if(exosuit_uses && helmet_uses)
		. += "You can alt-click this kit to change it into [(seva_kit) ? "explorer suit" : "SEVA"] kit"
