/obj/item/organ/cyberimp/arm/rope
	name = "climbing hook implant"
	desc = "An implanted grappling hook."
	items_to_create = list(/obj/item/climbing_hook/implanted)

/obj/item/organ/cyberimp/arm/rope/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You disable the safeties on [src]!"))
	items_list += WEAKREF(new /obj/item/melee/implant_whip(src))
	obj_flags |= EMAGGED
	return TRUE

/obj/item/organ/cyberimp/arm/rope/left_arm
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_LEFT_ARM_AUG

/obj/item/organ/cyberimp/arm/rope/right_arm
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_RIGHT_ARM_AUG