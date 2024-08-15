/obj/item/clothing/underwear/briefs
	name = "briefs"
	desc = "Not going commando."
	icon_state = "briefs"
	body_parts_covered = GROIN
	extra_slot_flags = ITEM_SLOT_UNDERWEAR

/obj/item/clothing/underwear/briefs/equipped(mob/living/user, slot)
	. = ..()
	if(!istype(user, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/human = user
	if(slot == ITEM_SLOT_UNDERWEAR)
		human.underwear = name
	else
		human.underwear = "Nude"

/**
 * Do not declare new briefs objects directly through typepaths, use BRIEFS_OBJECT(class) instead
 * Example:
 *
BRIEFS_OBJECT(test)
	name = "test boxers"
	icon_state = "test"
	flags_1 = IS_PLAYER_COLORABLE_1
	gender = MALE
	body_parts_covered = GROIN
	...
 */
