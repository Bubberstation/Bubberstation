/obj/item/clothing/glasses/hud/civilian
	name = "Civilian HUD Glasses"
	desc = "A heads-up display that scans the humanoids around you and displays their ID status."
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

/datum/design/civilian_hud
	name = "Civilian HUD"
	desc = "A heads-up display that scans the humanoids around you and displays their ID status."
	id = "civ_hud"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/hud/civilian
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE
