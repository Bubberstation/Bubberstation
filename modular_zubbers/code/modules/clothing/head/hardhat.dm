/obj/item/clothing/head/utility/hardhat/bluespace
	name = "bluespace tech's hard hat"
	desc = "A robust and elite hard hat, worn by Nanotrasen's theoretical bluespace technicians. You probably shouldn't have this."

	icon = 'modular_zubbers/icons/obj/clothing/head/utility.dmi'
	icon_state = "hardhat0_bst"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/utility.dmi'
	worn_icon_state = "hardhat0_bst"
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/utility_teshari.dmi'
	hat_type = "bst"
	inhand_icon_state = null
	dog_fashion = null
	w_class = WEIGHT_CLASS_SMALL

	flash_protect = FLASH_PROTECTION_WELDER_HYPER_SENSITIVE + 2
	flags_cover = PEPPERPROOF
	clothing_flags = STOPSPRESSUREDAMAGE|THICKMATERIAL|SNUG_FIT|STACKABLE_HELMET_EXEMPT|HEADINTERNALS|BLOCK_GAS_SMOKE_EFFECT
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	custom_materials = null
	armor_type = /datum/armor/mod_theme_administrative

	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	strip_delay = 60 SECONDS

	light_range = 8
	light_power = 1.6
	light_color = "#ffcc99"

/obj/item/clothing/head/utility/hardhat/bluespace/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/earhealing)
	AddComponent(/datum/component/wearertargeting/earprotection, protection_amount = EAR_PROTECTION_FULL)
