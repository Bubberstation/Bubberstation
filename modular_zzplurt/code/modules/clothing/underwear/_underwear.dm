//Fuck it we making underwear actual items
/obj/item/clothing/underwear
	name = "Underwear"
	desc = "If you're reading this, something went wrong."
	icon = 'modular_zzplurt/icons/mob/clothing/underwear.dmi' //if someone is willing to make proper inventory sprites that'd be very cash money
	worn_icon = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
	worn_icon_digi = 'modular_zzplurt/icons/mob/clothing/underwear_digi.dmi'
	body_parts_covered = GROIN
	slot_flags = null //These should use the extra slots
	extra_slot_flags = NONE

	w_class = WEIGHT_CLASS_SMALL

	// Adding support for female sprites
	var/female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/underwear/mob_can_equip(mob/living/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_NO_UNDERWEAR))
		return FALSE

/obj/item/clothing/underwear/Move()
	..()
	setDir(SOUTH) //should prevent underwear from facing any direction but south while on the floor, uses same code as pipes, PLEASE, THIS IS A BAD SOLUTION, SOMEONE MAKE ME UNDERWEAR SPRITES ASAP

///Proc to check if undershirt is hidden.
/mob/living/carbon/human/proc/undershirt_hidden()
	for(var/obj/item/I in list(w_uniform, wear_suit))
		if(istype(I) && ((I.body_parts_covered & CHEST) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

///Proc to check if bra is hidden.
/mob/living/carbon/human/proc/bra_hidden()
	for(var/obj/item/I in list(w_uniform, wear_suit))
		if(istype(I) && ((I.body_parts_covered & CHEST) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

///Proc to check if underwear is hidden.
/mob/living/carbon/human/proc/underwear_hidden()
	for(var/obj/item/I in list(w_uniform, wear_suit))
		if(istype(I) && ((I.body_parts_covered & GROIN) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

///Proc to check if socks are hidden.
/mob/living/carbon/human/proc/socks_hidden()
	for(var/obj/item/I in list(shoes, wear_suit))
		if(istype(I) && ((I.body_parts_covered & FEET) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE
