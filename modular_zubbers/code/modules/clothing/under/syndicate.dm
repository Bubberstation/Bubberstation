/obj/item/clothing/under/misc/maid/tactical //Donor item for skyefree
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	name = "Tactical maid outfit"
	desc = "A 'tactical' skirtleneck fashioned to the likeness of a maid outfit."
	icon_state = "syndimaid"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	has_sensor = 1

/obj/item/clothing/under/misc/maid/tactical/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/maidcorset/tactical/A = new (src)
	attach_accessory(A)

/obj/item/clothing/accessory/maidcorset/tactical
	name = "Tactical maid apron"
	desc = "Practical? No. Tactical? Also no. Cute? Most definitely yes."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "syndimaid_corset"
	minimize_when_attached = FALSE
	attachment_slot = null
