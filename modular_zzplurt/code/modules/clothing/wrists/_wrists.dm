/obj/item/clothing/wrists
	name = "slap bracelet"
	desc = "oh no."
	gender = PLURAL //change this if it is for a single wrist
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'
	siemens_coefficient = 0.5
	body_parts_covered = HANDS
	slot_flags = ITEM_SLOT_WRISTS
	attack_verb_simple = list("slapped on the wrist")
	strip_delay = 20
	equip_delay_other = 40

/obj/item/clothing/wrists/armwarmer
	name = "Arm Warmers"
	desc = "A pair of arm warmers."
	icon = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'
	icon_state = "armwarmer"
	body_parts_covered = ARMS

/obj/item/clothing/wrists/armwarmer/long
	name = "Long Arm Warmers"
	desc = "A pair of long arm warmers."
	icon = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'
	icon_state = "armwarmer_long"
	body_parts_covered = ARMS

//Striped Arm Warmers
/obj/item/clothing/wrists/armwarmer_striped
	name = "Striped Arm Warmers"
	desc = "A pair of striped arm warmers."
	icon = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'
	icon_state = "armwarmer_striped"
	body_parts_covered = ARMS
	greyscale_colors = "#FFFFFF#FFFFFF"
	greyscale_config = /datum/greyscale_config/armwarmer_striped
	greyscale_config_worn = /datum/greyscale_config/armwarmer_striped/worn

/datum/greyscale_config/armwarmer_striped
	name = "Striped Arm Warmers"
	icon_file = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	json_config = 'modular_zzplurt/code/datums/greyscale/json_configs/armwarmer_striped.json'

/datum/greyscale_config/armwarmer_striped/worn
	name = "Striped Arm Warmers (Worn)"
	icon_file = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'

//Long Arm Warmers
/obj/item/clothing/wrists/armwarmer_striped/long
	name = "Long Striped Arm Warmers"
	desc = "A pair of long striped arm warmers."
	icon = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'
	icon_state = "armwarmer_striped_long"
	body_parts_covered = ARMS
	greyscale_config = /datum/greyscale_config/armwarmer_striped_long
	greyscale_config_worn = /datum/greyscale_config/armwarmer_striped_long/worn

/datum/greyscale_config/armwarmer_striped_long
	name = "Long Striped Arm Warmers"
	icon_file = 'modular_zzplurt/icons/obj/clothing/wrist.dmi'
	json_config = 'modular_zzplurt/code/datums/greyscale/json_configs/armwarmer_striped_long.json'

/datum/greyscale_config/armwarmer_striped_long/worn
	name = "Long Striped Arm Warmers (Worn)"
	icon_file = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'
