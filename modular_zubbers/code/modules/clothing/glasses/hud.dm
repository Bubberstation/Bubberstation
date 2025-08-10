/obj/item/clothing/glasses/hud/civilian
	name = "Civilian HUD Glasses"
	desc = "A heads-up display that scans the humanoids around you and displays their ID status. Experts say this has well over 9000 uses."
	icon = 'modular_zubbers/icons/obj/clothing/head/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'
	icon_state = "civhud"
	clothing_traits = list(TRAIT_BASIC_SECURITY_HUD) //thanks honkbots for having that


/obj/item/clothing/glasses/hud/civilian/sunglasses
	name = "Civilian HUDSunglasses"
	desc = "Sunglasses with a civilian HUD."
	icon = 'modular_zubbers/icons/obj/clothing/head/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudciv"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
