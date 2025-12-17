/obj/item/clothing/under/misc/maid/tactical //Donor item for skyefree
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	name = "Tactical maid outfit"
	desc = "A 'tactical' skirtleneck fashioned to the likeness of a maid outfit."
	icon_state = "syndimaid"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	has_sensor = HAS_SENSORS

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

/obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured
	name = "utility overalls turtleneck"
	desc = "A pair of spiffy overalls with a turtleneck underneath, useful for both engineering and botanical work."
	icon_state = "syndicate_overalls"
	armor_type = /datum/armor/clothing_under
	has_sensor = HAS_SENSORS
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured/skirt
	name = "utility overalls skirtleneck"
	desc = "A pair of spiffy overalls with a turtleneck underneath, this one is a skirt instead, breezy."
	icon_state = "syndicate_overallskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/under/syndicate/boss
	name = "patriot's stealth suit"
	desc = "Let's make this the greatest 10 minutes of our lives, Jack."
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "boss"
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/rank/civilian/bubber/boss
	name = "mercury woman's sneaking suit"
	desc = "Let's make this the greatest 10 minutes of our lives, Jack."
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "boss"
