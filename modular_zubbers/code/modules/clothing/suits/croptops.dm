//Basetype

/obj/item/clothing/suit/crop_jacket
	name = "crop-top jacket"
	desc = "A jacket that, some time long past, probably made quite the effective outdoors wear. Now, \
		some barbarian has cut the entire bottom half out."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/crop_jacket"
	post_init_icon_state = "crop_jacket"
	greyscale_config = /datum/greyscale_config/crop_jacket
	greyscale_config_worn = /datum/greyscale_config/crop_jacket/worn
	greyscale_colors = "#ebebeb#a52f29#292929"
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/crop_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/crop_jacket/shortsleeve
	name = "short-sleeved crop-top jacket"
	desc = "A jacket that, some time long past, probably made quite the effective outdoors wear. Now, \
		some barbarian has cut the entire bottom half out, as well as half the sleeves."
	icon_state = "/obj/item/clothing/suit/crop_jacket/shortsleeve"
	post_init_icon_state = "crop_jacket_short"
	greyscale_config = /datum/greyscale_config/shortsleeve_crop_jacket
	greyscale_config_worn = /datum/greyscale_config/shortsleeve_crop_jacket/worn

/obj/item/clothing/suit/crop_jacket/sleeveless
	name = "sleeveless crop-top jacket"
	desc = "A jacket that, some time long past, probably made quite the effective outdoors wear. Now, \
		some barbarian has cut the entire bottom half out, as well as the sleeves."
	icon_state = "/obj/item/clothing/suit/crop_jacket/sleeveless"
	post_init_icon_state = "crop_jacket_sleeveless"
	greyscale_config = /datum/greyscale_config/sleeveless_crop_jacket
	greyscale_config_worn = /datum/greyscale_config/sleeveless_crop_jacket/worn
	greyscale_colors = "#ebebeb#a52f29"
	body_parts_covered = CHEST

/obj/item/clothing/suit/crop_jacket/long
	name = "sports jacket"
	desc = "A jacket that probably makes quite the effective outdoors wear."
	icon_state = "/obj/item/clothing/suit/crop_jacket/long"
	post_init_icon_state = "jacket"

/obj/item/clothing/suit/crop_jacket/shortsleeve/long
	name = "short-sleeved sports jacket"
	desc = "A jacket that probably makes quite the effective outdoors wear. However, \
		some barbarian has cut the sleeves in half."
	icon_state = "/obj/item/clothing/suit/crop_jacket/shortsleeve/long"
	post_init_icon_state = "jacket_short"

/obj/item/clothing/suit/crop_jacket/sleeveless/long
	name = "sleeveless sports jacket"
	desc = "A jacket that probably makes quite the effective outdoors wear. However, \
		some barbarian has cut the sleeves off."
	icon_state = "/obj/item/clothing/suit/crop_jacket/sleeveless/long"
	post_init_icon_state = "jacket_sleeveless"
