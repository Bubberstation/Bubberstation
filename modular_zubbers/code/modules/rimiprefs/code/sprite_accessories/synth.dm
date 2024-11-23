/datum/sprite_accessory/synth_chassis
	crop_area = list(8, 8, 24, 24) // We want just the body.

/datum/sprite_accessory/synth_chassis/get_base_preview_icon()
	return

/datum/sprite_accessory/synth_head
	crop_area = list(8, 18, 23, 32) // We want just the head.

/datum/sprite_accessory/synth_head/get_base_preview_icon()
	return

/datum/sprite_accessory/antenna
	crop_area = list(8, 18, 23, 32) // We want just the head.

/datum/sprite_accessory/antenna/get_base_preview_icon()
	return icon('modular_skyrat/modules/bodyparts/icons/ipc_parts.dmi', "synth_head", SOUTH, 1)

/datum/sprite_accessory/screen
	crop_area = list(8, 18, 23, 32) // We want just the head.

/datum/sprite_accessory/screen/get_base_preview_icon()
	return
