// SynTech ring
/obj/item/clothing/gloves/ring/syntech
	name = "normalizer ring"
	desc = "An expensive, shimmering ring gilded with golden markings. It will 'normalize' the size of the user to a specified height approved for work-conditions, as long as it is equipped. The artificial violet gem inside twinkles ominously."
	icon = 'modular_zubbers/icons/obj/clothing/gloves/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/gloves/gloves.dmi'
	worn_icon_state = "sring"
	icon_state = "ring" // No use in a unique sprite since it's just one pixel
	w_class = WEIGHT_CLASS_TINY
	body_parts_covered = 0
	strip_delay = 40

/obj/item/clothing/gloves/ring/syntech/equipped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_target = user
		if(slot == ITEM_SLOT_GLOVES)

			if(human_target?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) >= RESIZE_DEFAULT_SIZE)
				normalize_mob_size(human_target)

/obj/item/clothing/gloves/ring/syntech/dropped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_target = user

		if(human_target.normalized)
			denormalize_mob_size(human_target)

// SynTech Wristband
/obj/item/clothing/gloves/ring/syntech/band
	name = "normalizer wristband"
	desc = "An expensive technological wristband cast in purples with shimmering golds. It will 'normalize' the size of the user to a specified height for approved work-conditions, as long as it is equipped. There is a small screen buzzing with information."
	worn_icon_state = "syntechband"
	icon_state = "wristband"
