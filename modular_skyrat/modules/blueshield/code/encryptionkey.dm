/obj/item/encryptionkey/heads/blueshield
	name = "\proper the blueshield's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/heads/blueshield"
	post_init_icon_state = "cypherkey_centcom"
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_centcom
	greyscale_colors = "#1d2657#dca01b"
