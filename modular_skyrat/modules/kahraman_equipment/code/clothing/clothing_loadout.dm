// Jumpsuit

/obj/item/clothing/under/frontier_colonist_dearmored
	name = "frontier jumpsuit"
	desc = "A heavy grey jumpsuit with padding around the joints removed. Two massive pockets included. \
		No matter what you do to adjust it, its always just slightly too large."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "jumpsuit"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "jumpsuit"

/obj/item/clothing/under/frontier_colonist_dearmored/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Boots

/obj/item/clothing/shoes/jackboots/frontier_colonist_dearmored
	name = "frontier boots"
	desc = "A well built pair of tall boots usually seen on the feet of explorers, first wave colonists, \
		and LARPers across the galaxy."
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
		In between? Just enough protective material to stop the odd sharp thing getting through, \
		though don't expect miracles."
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
		In between? Just enough protective material to stop the odd sharp thing getting through, \
		though don't expect miracles."
	icon_state = "jacket_short"
	worn_icon_state = "jacket_short"

// Various softcaps

/obj/item/clothing/head/soft/frontier_colonist_dearmored
	name = "frontier cap"
	desc = "It's a robust baseball hat in a rugged green color."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "cap"
	soft_type = "cap"
	soft_suffix = null
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "cap"

/obj/item/clothing/head/soft/frontier_colonist_dearmored/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

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

/obj/item/clothing/mask/gas/atmos/frontier_colonist_dearmored
	name = "frontier gas mask"
	desc = "An improved gas mask commonly seen in places where the atmosphere is less than breathable, \
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
