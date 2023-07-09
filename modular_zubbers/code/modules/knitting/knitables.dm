//PUT ALL ITEMS THAT NEED TO BE CHANGED FOR A KNITABLE SPRITE HERE

/obj/item/clothing/accessory/armband/knitted
	name = "Armband"
	desc = "A fancy knitted armband!"
	icon_state = "medband"
	attachment_slot = null
/obj/item/clothing/neck/scarf/knitted
	name = "scarf"
	icon_state = "scarf"
	icon_preview = 'scarf_cloth'
	icon_state_preview = "scarf"
	desc = "A stylish knitted scarf. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their necks."
	w_class = WEIGHT_CLASS_TINY
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#EEEEEE#EEEEEE"
	greyscale_config = /datum/greyscale_config/scarf
	greyscale_config_worn = /datum/greyscale_config/scarf_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/large_scarf/knitted
	name = "large scarf"
	icon_state = "large_scarf"
	icon_state_preview = 'scarf'
	w_class = WEIGHT_CLASS_TINY
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#C6C6C6#EEEEEE"
	greyscale_config = /datum/greyscale_config/large_scarf
	greyscale_config_worn = /datum/greyscale_config/large_scarf_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/beanie/knitted
	name = "beanie"
	desc = "A stylish beanie. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their heads."
	icon = 'icons/obj/clothing/head/beanie.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "beanie"
	icon_preview = 'beanie'
	icon_state_preview = "beanie"
	custom_price = PAYCHECK_CREW * 1.2
	greyscale_colors = "#EEEEEE#EEEEEE"
	greyscale_config = /datum/greyscale_config/beanie
	greyscale_config_worn = /datum/greyscale_config/beanie_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/beret/knitted
	name = "beret"
	desc = "A knitted beret."
	icon_state = "beret"
	icon_state_preview = 'beret'
	dog_fashion = /datum/dog_fashion/head/beret
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_colors = "#fefdfd"
	flags_1 = IS_PLAYER_COLORABLE_1
