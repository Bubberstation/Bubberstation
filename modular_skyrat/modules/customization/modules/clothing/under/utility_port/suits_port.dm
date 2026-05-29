//Base Jacket - same stats as /obj/item/clothing/suit/jacket, just toggleable and serving as the base for all the departmental jackets and flannels
/obj/item/clothing/suit/toggle/jacket
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "bomber jacket"
	desc = "A warm bomber jacket, with synthetic-wool lining to keep you nice and warm in the depths of space. Aviators not included."
	icon_state = "bomberalt"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/radio)
	body_parts_covered = CHEST|ARMS|GROIN
	cold_protection = CHEST|ARMS|GROIN
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	toggle_noun = "zipper"

//Job Jackets

// do not have the new sprites for these
/obj/item/clothing/suit/toggle/jacket/det_trench
	icon = 'icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/jacket/supply/head
	name = "quartermaster's jacket"
	desc = "Even if people refuse to recognize you as a head, they can recognize you as a badass."
	icon_state = "qmjacket"

//Flannels
/obj/item/clothing/suit/toggle/jacket/flannel
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "flannel jacket"
	desc = "A cozy and warm plaid flannel jacket. Praised by Lumberjacks and Truckers alike."
	icon_state = "flannel"
	body_parts_covered = CHEST|ARMS //Being a bit shorter, flannels dont cover quite as much as the rest of the woolen jackets (- GROIN)
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS	//As a plus side, they're more insulating, protecting a bit from the heat as well

/obj/item/clothing/suit/toggle/jacket/flannel/red
	name = "red flannel jacket"
	icon_state = "flannel_red"

/obj/item/clothing/suit/toggle/jacket/flannel/aqua
	name = "aqua flannel jacket"
	icon_state = "flannel_aqua"

/obj/item/clothing/suit/toggle/jacket/flannel/brown
	name = "brown flannel jacket"
	icon_state = "flannel_brown"

/obj/item/clothing/suit/toggle/jacket/flannel/gags
	name = "flannel shirt"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/flannel/gags"
	post_init_icon_state = "flannelgags"
	greyscale_config = /datum/greyscale_config/flannelgags
	greyscale_config_worn = /datum/greyscale_config/flannelgags/worn
	greyscale_colors = "#a61e1f"
	flags_1 = IS_PLAYER_COLORABLE_1
