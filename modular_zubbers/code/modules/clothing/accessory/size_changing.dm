/obj/item/clothing/accessory/syntech
	name = "normalizer safety pin"
	desc = "A surprisingly weighty pin cast in a silvery-gold metal, with a small, embedded gemstone. When attached to a piece of clothing, it will 'normalize' the size of the wearer to a specified height for approved work conditions, hitting you with the realization that it's meant for the safety of whoever is around you... and the furniture."
	icon = 'modular_zubbers/icons/obj/clothing/accessories.dmi'
	icon_state = "normalizer"
	worn_icon = "modular_zubbers/icons/mob/clothing/accessories.dmi"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	attachment_slot = NONE

/obj/item/clothing/accessory/syntech/accessory_equipped(obj/item/clothing/under/clothes, mob/living/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_target = user
	if(human_target.client?.prefs?.read_preference(/datum/preference/numeric/body_size) >= RESIZE_DEFAULT_SIZE)
		normalize_mob_size(human_target)

/obj/item/clothing/accessory/syntech/accessory_dropped(obj/item/clothing/under/clothes, mob/living/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_target = user
	if(human_target.normalized)
		denormalize_mob_size(human_target)
