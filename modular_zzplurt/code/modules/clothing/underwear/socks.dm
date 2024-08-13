/obj/item/clothing/underwear/socks
	name = "socks"
	desc = "A pair of socks."
	icon_state = "socks"
	body_parts_covered = FEET
	extra_slot_flags = ITEM_SLOT_SOCKS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/underwear/socks/equipped(mob/living/user, slot)
	. = ..()
	if(!istype(user, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/human = user
	if(slot == ITEM_SLOT_SOCKS)
		human.socks = name
	else
		human.socks = "Nude"

/**
 * Do not declare new shirt or bra objects directly through typepaths, use SHIRT_OBJECT(class)/BRA_OBJECT(class) instead
 * Example:
 *
SOCKS_OBJECT(test)
	name = "test socks"
	icon_state = "test"
	flags_1 = IS_PLAYER_COLORABLE_1
	gender = MALE
	...
*/
