// Boots

/obj/item/clothing/shoes/jackboots/frontier_colonist_dearmored
	name = "frontier boots"
	desc = "A poorly built pair of replica tall boots usually seen on the feet of explorers, first wave colonists, \
		Should've gotten the original from the botanical printer."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "boots"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "boots"
	resistance_flags = NONE

/obj/item/clothing/shoes/jackboots/frontier_colonist_dearmored/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Jackets

/obj/item/clothing/suit/jacket/frontier_colonist_dearmored
	name = "frontier trenchcoat"
	desc = "A knee length coat with a water-resistant exterior and relatively comfortable interior. \
		This one is clearly a replica as the material are not as protective as the original."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "jacket"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "jacket"
	slot_flags = ITEM_SLOT_OCLOTHING
	resistance_flags = NONE
	allowed = null

/obj/item/clothing/suit/jacket/frontier_colonist_dearmored/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/clothing/suit/jacket/frontier_colonist_dearmored/short
	name = "frontier jacket"
	desc = "A short coat with a water-resistant exterior and relatively comfortable interior. \
		In between? This one is clearly a replica as the material are not as protective as the original."
	icon_state = "jacket_short"
	worn_icon_state = "jacket_short"

// Gloves

/obj/item/clothing/gloves/frontier_colonist_dearmored
	name = "frontier gloves"
	desc = "A pair of black gloves that'll keep your precious fingers protected from the outside world. \
		They go a bit higher up the arm than most gloves should, and you aren't quite sure why."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "gloves"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gloves"
	greyscale_colors = "#3a373e"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/frontier_colonist_dearmored/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Special mask

/obj/item/clothing/mask/gas/frontier_colonist_dearmored
	name = "frontier gas mask"
	desc = "An standard gas mask commonly seen in places where the atmosphere is less than breathable, \
		but otherwise more or less habitable. Its certified to protect against most biological hazards \
		to boot."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "mask"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gas_frontier"
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gas/atmos/frontier_colonist_dearmored/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
