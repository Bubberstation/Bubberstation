/obj/item/clothing/gloves/misc/diver //Donor item for patriot210
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	name = "black divers gloves"
	desc = "An old pair of gloves used by a now-defunct mining coalition."
	icon_state = "diver"
	worn_icon_state = "diver"

/obj/item/clothing/gloves/latex/allamerican
	name = "all-american diner latex gloves"
	desc = "A sterile pair of gloves for preparing food without the risk of contamination! The old fashion american style."
	icon_state = "latex_black"
	worn_icon_state = "latex_black"

//Cat Gloves seemingly by Taomayo of MonkeStation

/obj/item/clothing/gloves/cat
	desc = "hewwo everynyaan!!"
	name = "cat gloves"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/cat"
	post_init_icon_state = "catglove"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors =  "#ffffff#FFC0CB"
	greyscale_config_worn = /datum/greyscale_config/catgloves/worn
	greyscale_config = /datum/greyscale_config/catgloves
