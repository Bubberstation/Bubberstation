/obj/item/clothing/head/hats/warden/drill/blueshield
	name = "blueshield's campaign hat"
	desc = "A variant of the warden's campaign hat recolored to match the Blueshield. Made with durathread to protect their squishy braincase. It's padded with nano-kevlar, making it more protective than standard berets."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "bluedrill"
	armor_type = /datum/armor/suit_armor/blueshield //same as the Blueshield's default beret.

/obj/item/clothing/head/hats/warden/drill/captain
	name = "captain's campaign hat"
	desc = "A variant of the warden's campaign hat for your more militaristic captains."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "capdrill"
	armor_type = /datum/armor/hats_caphat

/obj/item/clothing/head/hats/warden/drill/hos
	name = "head of security's campaign hat"
	desc = "A variant of the warden's campaign hat for the Head of Security. End the blood-feud and team up."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hosdrill"
	armor_type = /datum/armor/hats_hos

/obj/item/clothing/head/hats/warden/drill/nanotrasen
	name = "representative's campaign hat"
	desc = "A variant of the warden's campaign hat for your more militaristic representatives."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "repdrill"
	armor_type = /datum/armor/head_nanotrasen_consultant

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

/obj/item/clothing/head/utility/surgerycap
	flags_inv = null

/datum/armor/beanie_sec
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50
	wound = 4
