/obj/item/radio/headset/headset_galfed
	name = "\improper GalFed headset"
	desc = "A headset used by the government employees of the Galactic Federation."
	icon = 'modular_zubbers/icons/obj/clothing/headsets.dmi'
	icon_state = "galfed_headset"
	worn_icon_state = "galfed_headset"
	keyslot = /obj/item/encryptionkey/headset_galfed

/obj/item/radio/headset/headset_galfed/empty
	keyslot = null

/obj/item/radio/headset/headset_galfed/command
	command = TRUE

/obj/item/radio/headset/headset_galfed/alt
	name = "\improper GalFed bowman headset"
	desc = "A headset used mostly by higher personnel within the Galactic Federation, but mostly the law enforcement. Protects ears from flashbangs."
	icon_state = "galfed_headset_alt"
	worn_icon_state = "galfed_headset_alt"

/obj/item/radio/headset/headset_galfed/alt/chief
	command = TRUE

/obj/item/radio/headset/headset_galfed/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/encryptionkey/headset_galfed
	name = "\improper GalFed radio encryption key"
	icon_state = "cypherkey_centcom"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_GALFED = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_centcom
	greyscale_colors = "#1f2f5b#dca01b"
