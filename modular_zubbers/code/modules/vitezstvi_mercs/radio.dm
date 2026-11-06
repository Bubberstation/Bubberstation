/obj/item/encryptionkey/vitezstvi
	name = "Vítězství Arms radio encryption key"
	channels = list(RADIO_CHANNEL_FACTION = 1)
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/radio/headset/vitezstvi
	name = "contractor bowman headset"
	desc = "A Vítězství Arms contractor bowman headset credited with being the only reason anyone who works for this company can still hear anything at all."
	icon = 'modular_zubbers/icons/obj/devices/guard_bowman.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/guard_bowman_worn.dmi'
	icon_state = "guard_bowman"
	worn_icon_state = "guard_bowman"
	post_init_icon_state = "guard_bowman"
	greyscale_config = /datum/greyscale_config/guard_bowman
	greyscale_config_worn = /datum/greyscale_config/guard_bowman/worn
	greyscale_colors = COLOR_OLIVE + COLOR_GOLD
	keyslot = /obj/item/encryptionkey/vitezstvi

/obj/item/radio/headset/vitezstvi/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
	update_icon(UPDATE_OVERLAYS)
