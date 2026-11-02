/obj/item/clothing/suit/apron/overalls
	greyscale_config_worn_teshari = /datum/greyscale_config/overalls/worn/teshari

/obj/item/clothing/suit/toggle/cargo_tech
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/hazardvest
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

/obj/item/clothing/suit/hazardvest/press
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

/obj/item/clothing/suit/caution
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

/obj/item/clothing/suit/atmos_overalls
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/utility/fire/firefighter
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

/obj/item/clothing/suit/toggle/lawyer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/toggle/chef
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/obj/item/clothing/suit/toggle/lawyer/greyscale
	greyscale_config_worn_teshari = /datum/greyscale_config/jacket_lawyer/worn/teshari

/obj/item/clothing/suit/hazardvest/bluespace
	name = "bluespace tech's hazard vest"
	desc = "The slick, black and blue hazard vest of a bluespace technician. Protects from most things, including the vaccuum of space. You probably shouldn't have this."

	icon = 'modular_zubbers/icons/obj/clothing/suits/utility.dmi'
	icon_state = "bst_vest"
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/utility.dmi'
	worn_icon_state = "bst_vest"
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/utility.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'
	inhand_icon_state = null

	clothing_flags = STOPSPRESSUREDAMAGE|THICKMATERIAL|SNUG_FIT
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED,TRAIT_NO_STAGGER,TRAIT_NO_THROW_HITPUSH)
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	custom_materials = null
	w_class = WEIGHT_CLASS_SMALL

	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/mod_theme_administrative

	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	strip_delay = 60 SECONDS

	siemens_coefficient = 0
	allowed = list(
		/obj/item/gun,
		/obj/item/tank/internals,
	)
