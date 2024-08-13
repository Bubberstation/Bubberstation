/obj/item/clothing/underwear/shirt
	name = "shirt"
	desc = "A shirt."
	icon_state = "undershirt"
	body_parts_covered = CHEST | ARMS
	extra_slot_flags = ITEM_SLOT_SHIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/underwear/shirt/equipped(mob/living/user, slot)
	. = ..()
	if(!istype(user, /mob/living/carbon/human) || istype(src, /obj/item/clothing/underwear/shirt/bra))
		return
	var/mob/living/carbon/human/human = user
	if(slot == ITEM_SLOT_SHIRT)
		human.undershirt = name
	else
		human.undershirt = "Nude"

/obj/item/clothing/underwear/shirt/bra
	name = "bra"
	desc = "A bra."
	icon_state = "bra"
	body_parts_covered = CHEST
	extra_slot_flags = ITEM_SLOT_BRA
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/underwear/shirt/bra/equipped(mob/living/user, slot)
	. = ..()
	if(!istype(user, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/human = user
	if(slot == ITEM_SLOT_BRA)
		human.bra = name
	else
		human.bra = "Nude"

/**
 * Do not declare new shirt or bra objects directly through typepaths, use SHIRT_OBJECT(class)/BRA_OBJECT(class) instead
 * Example:
 *
SHIRT_OBJECT(test)
	name = "test shirt"
	icon_state = "test"
	flags_1 = IS_PLAYER_COLORABLE_1
	gender = MALE
	body_parts_covered = CHEST | ARMS
	...

BRA_OBJECT(test)
	name = "test bra"
	icon_state = "test"
	flags_1 = IS_PLAYER_COLORABLE_1
	gender = FEMALE
	...
 */
