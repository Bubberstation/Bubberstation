/obj/item/reagent_containers/cup/soup_pot
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	slot_flags = ITEM_SLOT_HEAD
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE

/obj/item/reagent_containers/cup/soup_pot/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		if(istype(user))
			user.become_blind(EYES_COVERED)


/obj/item/reagent_containers/cup/soup_pot/dropped(mob/living/carbon/user)
	. = ..()
	if(istype(user))
		user.update_tint()
