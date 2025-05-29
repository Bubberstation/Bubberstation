/mob/living/carbon/can_buckle()
	if(HAS_TRAIT(src, TRAIT_NO_BUCKLE))
		return FALSE

	return ..()

/datum/species/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self)
	if(!istype(I, /obj/item/mod) && HAS_TRAIT(H, TRAIT_NO_BACKPACK) && slot ==ITEM_SLOT_BACK)
		to_chat(H, "<span class='warning'>You are too fat to wear anything on your back.</span>")
		return FALSE

	if(I.modular_icon_location == null && HAS_TRAIT(H, TRAIT_NO_JUMPSUIT) && slot == ITEM_SLOT_ICLOTHING)
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE

	if(!mod_check(I) && HAS_TRAIT(H, TRAIT_NO_MISC) && (slot == ITEM_SLOT_FEET || slot ==ITEM_SLOT_GLOVES || slot == ITEM_SLOT_OCLOTHING))
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE
	
	if(HAS_TRAIT(H, TRAIT_NO_BELT) && slot == ITEM_SLOT_BELT)
		if(istype(I, /obj/item/bluespace_belt/primitive) && H?.client?.prefs.helplessness_belts*2 > H.fatness)
			return ..()

		if(istype(I, /obj/item/bluespace_belt) && !istype(I, /obj/item/bluespace_belt/primitive))
			return ..()
		
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE


	return ..()

/datum/species/proc/mod_check(I)
	if(istype(I, /obj/item/mod) || istype(I, /obj/item/clothing/head/mod) || istype(I, /obj/item/clothing/gloves/mod) || istype(I, /obj/item/clothing/shoes/mod) || istype(I, /obj/item/clothing/suit/mod) )
		return TRUE
	return FALSE
