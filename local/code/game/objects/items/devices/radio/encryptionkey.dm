/obj/item/encryptionkey/headset_bro
	name = "broadcast radio encryption key"
	icon_state = "cypherkey_service"
	channels = list(RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_BROADCAST = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_service
	greyscale_colors = "#858585#3bca5a"

/obj/item/encryptionkey/broadcast_only
	name = "broadcast-only radio encryption key"
	icon_state = "cypherkey_service"
	channels = list(RADIO_CHANNEL_BROADCAST = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_service
