/obj/item/clothing/head/hats/blueshield/drill
	name = "Blueshield's campaign hat"
	desc = "A variant of the warden's campaign hat recolored to match the Blueshield. Made with durathread to protect their squishy braincase. It's padded with nano-kevlar, making it more protective than standard berets."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "bluedrill"
	armor_type = /datum/armor/suit_armor/blueshield //same as the Blueshield's default beret.

/obj/item/clothing/head/hats/caphat/drill
	name = "Captain's campaign hat"
	desc = "A variant of the warden's campaign hat for your more militaristic captains."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "capdrill"

/obj/item/clothing/head/hats/hos/drill
	name = "Head of Security's campaign hat"
	desc = "A variant of the warden's campaign hat for the Head of Security. End the blood-feud and team up."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "hosdrill"

/obj/item/clothing/head/nanotasen_consultant/drill
	name = "Representative's campaign hat"
	desc = "A variant of the warden's campaign hat for your more militaristic representatives."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	icon_state = "repdrill"

/obj/item/clothing/head/beret/medical/coroner				//Donator request by Gavla
	name = "coroner beret"
	desc = "For harvesting organs in style!"
	icon_state = "beret_badge_med"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3E3E48#FFFFFF"

/obj/item/clothing/head/beaniesec
	name = "security beanie"
	desc = "A robust beanie with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "beanie_sec"
	armor_type = /datum/armor/beanie_sec

/datum/armor/beanie_sec
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50
	wound = 4
