/obj/item/clothing/glasses/hud/civilian
	name = "Civilian HUD Glasses"
	desc = "A heads-up display that scans the humanoids around you and displays their ID status. Experts say this has well over 9000 uses."
	icon = 'modular_zubbers/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'
	icon_state = "civhud"
	clothing_traits = list(TRAIT_SECURITY_HUD_ID_ONLY) //thanks honkbots for having that


/obj/item/clothing/glasses/hud/civilian/sunglasses
	name = "Civilian HUDSunglasses"
	desc = "Sunglasses with a civilian HUD."
	icon = 'modular_zubbers/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudciv"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/clothing/glasses/hud/security/red
	name = "security HUD"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records."
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhud"
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/red/sunglasses
	gender = PLURAL
	name = "security HUDSunglasses"
	desc = "Sunglasses with a security HUD."
	icon_state = "sunhudsec"
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/darkred
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT / 2)
