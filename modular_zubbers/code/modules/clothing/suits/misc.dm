/obj/item/clothing/suit/misc/holographic //Donator item for Blovy. Sprited by Casey/Keila.
	icon = 'modular_zubbers/icons/obj/clothing/suits/misc.dmi'
	icon_state = "holographic"
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/misc.dmi' //Works like a gear harness but keeps private parts hidden for the suit slot.
	worn_icon_state = "holographic"
	name = "Holographic Suit V4000"
	desc = "The Holographic Suit V4000 has multiple layers designed specifically to refract and bend light waves around the user, effectively making them transparent to the naked eye. The suit comes equipped with advanced sensors that constantly scan its surroundings, adjusting its holographic projection accordingly. As soon as you put on the suit it calibrates itself based on your unique body shape and size."
	attachment_slot_override = CHEST
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/misc/suit_harness
	name = "suit harness"
	desc = "A near-concealed harness meant for going over uniforms. Or lack thereof."
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	icon_state = "suit_harness"
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	worn_icon_state = "suit_harness"
	inhand_icon_state = null
	body_parts_covered = 0x0
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	attachment_slot_override = CHEST

	//Allowed is same as jackets.
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		/obj/item/storage/belt/holster,
	)

/obj/item/clothing/suit/misc/allamerican
	name = "all-american diner manager's vest"
	desc = "A soft fabric vest, with a nametag of the employee on it. It says, MANAGER on the back, making you obvious for the Karens who just NEED your attention."
	icon = 'modular_zubbers/icons/obj/clothing/suits/misc.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/misc.dmi'
	icon_state = "allamerican"
	worn_icon_state = "allamerican"
	attachment_slot_override = CHEST
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		/obj/item/storage/belt/holster,
	)

// Skyrat wet floor sign from code\modules\clothing\suits\wetfloor.dm
/obj/item/clothing/suit/caution
	worn_icon_digi = 'icons/mob/clothing/suits/utility.dmi' // Fixed, GMode purple placeholder appeared for digi dolls without it

// Ablative trenchcoat
/obj/item/clothing/suit/hooded/ablative
	// digi sprites (ironically, from skyrat), purple missing coat otherwise
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor_digi.dmi'
	// new teshari sprites
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

// bulletproof armor
/obj/item/clothing/suit/armor/bulletproof
	// "new" digi sprites, purple missing coat otherwise
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	// new teshari sprites
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/toggle/rainbowcoat
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/recruiter_jacket
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/jacket/straight_jacket
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/blutigen_kimono
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/peacoat
	greyscale_config_worn_digi = /datum/greyscale_config/peacoat/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/peacoat/worn/teshari
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/space/syndicate/black/red
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/spacesuit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/razurathcoat
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/mothcoat
	greyscale_config_worn_digi = /datum/greyscale_config/mothcoat/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/mothcoat/worn/teshari
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/scraparmour
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/mikujacket
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/hos/elofy
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/wizrobe/santa
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/misc_teshari.dmi'

/obj/item/clothing/suit/space/santa
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/wizard_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/misc_teshari.dmi'

// "well-worn" shirts
/obj/item/clothing/suit/costume/wellworn_shirt
	greyscale_config_worn_digi = /datum/greyscale_config/wellworn_shirt/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/wellworn_shirt/worn/teshari
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/costume/wellworn_shirt/skub
	greyscale_config_worn_digi = /datum/greyscale_config/wellworn_shirt_skub/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/wellworn_shirt_skub/worn/teshari

/obj/item/clothing/suit/costume/wellworn_shirt/graphic
	greyscale_config_worn_digi = /datum/greyscale_config/wellworn_shirt_graphic/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/wellworn_shirt_graphic/worn/teshari

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic
	greyscale_config_worn_digi = /datum/greyscale_config/wornout_shirt_graphic/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/wornout_shirt_graphic/worn/teshari

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic
	greyscale_config_worn_digi = /datum/greyscale_config/messyworn_shirt_graphic/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/messyworn_shirt_graphic/worn/teshari
