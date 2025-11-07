/obj/item/encryptionkey/headset_medsec
	name = "medical-security encryption key"
	icon_state = "sec_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/radio/headset/headset_medsec
	name = "security medic's bowman headset"
	desc = "Used to hear how many security officers need to be stitched back together."
	icon = 'modular_zubbers/icons/obj/secmed_equipment.dmi'
	icon_state = "headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/headset_medsec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/clothing/glasses/hud/medsechud
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "security_hud"
	inhand_icon_state = "trayson-t-ray"
	glass_colour_type = /datum/client_colour/glass_colour/blue

/obj/item/clothing/glasses/hud/medsechud/sunglasses
	name = "health scanner security HUD sunglasses"
	icon = 'modular_zubbers/icons/obj/secmed_equipment.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hud_protected"
	worn_icon_state = "security_hud_black"
	inhand_icon_state = "sunhudmed"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1

/obj/item/storage/bag/garment/secmed
	name = "Security medic's garment bag"
	desc = "A bag containing extra clothing for the security medic"

/obj/item/storage/bag/garment/secmed/PopulateContents()
	. = ..()
	new /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic(src)
	new /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue(src)
	new /obj/item/clothing/suit/hazardvest/security_medic(src)
	new /obj/item/clothing/suit/hazardvest/security_medic/blue(src)
	new /obj/item/clothing/head/helmet/sec/peacekeeper/security_medic(src)
	new /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt(src)

/obj/structure/closet/secure_closet/security_medic
	name = "security medic's locker"
	req_access = list(ACCESS_BRIG)
	icon = 'modular_zubbers/icons/obj/closets/secmed_closet.dmi'
	icon_state = "secmed"

/obj/structure/closet/secure_closet/security_medic/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_medsec(src)
	new /obj/item/clothing/glasses/hud/medsechud/sunglasses(src)
	new /obj/item/storage/medkit/emergency(src)
	new /obj/item/clothing/suit/jacket/straight_jacket(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/storage/belt/security/medic/full(src)
	new /obj/item/storage/bag/garment/secmed(src)

