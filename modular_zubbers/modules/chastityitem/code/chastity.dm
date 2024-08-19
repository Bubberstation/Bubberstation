/obj/item/clothing/sextoy/chastity
	name = "DEBUG ITEM"
	desc = "call an admin probably"
	icon = 'modular_zubbers/modules/chastityitem/obj/lewd_chastity.dmi'
	lefthand_file = 'modular_zubbers/modules/chastityitem/mob/chastity_inhands/lewd_chastity_inhand_left.dmi'
	righthand_file = 'modular_zubbers/modules/chastityitem/mob/chastity_inhands/lewd_chastity_inhand_right.dmi'
	worn_icon = 'modular_zubbers/modules/chastityitem/mob/lewd_chastity.dmi'
	clothing_flags = INEDIBLE_CLOTHING
	alternate_worn_layer = UNDER_SUIT_LAYER
	var/locked = FALSE
	var/devicetype = null

/obj/item/clothing/sextoy/chastity/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_lock))

/obj/item/clothing/sextoy/chastity/proc/try_lock(atom/source, mob/user, obj/item/attacking_item, params)
	if(istype(attacking_item, /obj/item/key/chastity))
		to_chat(user, span_warning("With a click, the [devicetype] [locked ? "unlocks" : "locks"]!"))
		locked = !locked
	return TRUE

/obj/item/clothing/sextoy/chastity/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(LEWD_SLOT_PENIS | LEWD_SLOT_VAGINA) && locked)
		to_chat(user, span_warning("The [devicetype] is locked! You'll need unlock it before you can take it off!"))
		return
	..()
	
/obj/item/clothing/sextoy/chastity/examine(mob/user)
	. = ..()
	. += "It seems to be [locked ? "locked" : "unlocked"]."	
	
/obj/item/clothing/sextoy/chastity/equipped(mob/user, slot)
	var/mob/living/carbon/human/chasted = user
	if(ishuman(user)
		lockee.add_overlay(chasted.overlays_standing[BODY_ADJ_LAYER])
		lockee.regenerate_icons()
	. = ..()

/obj/item/clothing/sextoy/chastity/dropped(mob/user)
	var/mob/living/carbon/human/chasted = user
	if(ishuman(user)
		lockee.cut_overlay(chasted.overlays_standing[BODY_ADJ_LAYER])
	. = ..()

/obj/item/key/chastity
	name = "chastity key"
	desc = "A hex key meant for the bolt on a chastity device. Don't lose this. Or do."
	
/obj/item/clothing/sextoy/chastity/belt
	name = "chastity belt"
	desc = "They say codpieces are back in vogue, after all."
	devicetype = "belt"
	icon_state = "chastitybelt"
	inhand_icon_state = "chastitybelt"
	worn_icon_state = "chastitybelt"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_PENIS | LEWD_SLOT_VAGINA

/obj/item/clothing/sextoy/chastity/cage
	name = "chastity cage"
	desc = "They say codpieces are back in vogue, after all."
	devicetype = "cage"
	icon_state = "chastitycage"
	inhand_icon_state = "chastitycage"
	worn_icon_state = "chastitycage"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_PENIS
