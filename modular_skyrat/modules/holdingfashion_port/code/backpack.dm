/obj/item/satchel_of_holding_inert
	name = "inert satchel of holding"
	desc = "What is currently a just an unwieldly block of metal with a slot ready to accept a bluespace anomaly core."
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "inertsatchel"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/backpack/holding/satchel
	custom_materials = null
	name = "satchel of holding"
	desc = "A satchel that opens into a localized pocket of bluespace."
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "holdingsatchel"
	worn_icon = 'modular_skyrat/modules/holdingfashion_port/icons/back.dmi'
	worn_icon_state = "holdingsatchel"
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/duffel_of_holding_inert
	name = "inert duffel bag of holding"
	desc = "What is currently a just an unwieldly block of metal with a slot ready to accept a bluespace anomaly core."
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "inertduffel"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/backpack/holding/duffel
	custom_materials = null
	name = "duffel bag of holding"
	desc = "A duffel bag that opens into a localized pocket of bluespace."
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "holdingduffel"
	worn_icon = 'modular_skyrat/modules/holdingfashion_port/icons/back.dmi'
	worn_icon_state = "holdingduffel"
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)
