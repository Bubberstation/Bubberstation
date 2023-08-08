//PUT ALL ITEMS THAT NEED TO BE CHANGED FOR A KNITTABLE SPRITE HERE

/obj/item/clothing/accessory/armband/knitted
	name = "Armband"
	desc = "A fancy knitted armband!"
	icon_state = "medband"
	worn_icon = 'icons/mob/clothing/accessories.dmi'
	worn_icon_state = "medband"
	attachment_slot = null

/obj/item/clothing/suit/costume/ghost_sheet/knitted
	name = "Ghost Costume"
	desc = "A totally spooky ghost costume! It appears to have been knitted."
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	worn_icon_state = "ghost_sheet"

/obj/item/clothing/neck/scarf/knitted
	name = "Knitted Scarf"
	desc = "Did your grandmother make this?"
	icon = 'knittables.dmi'
	icon_state = "scarf_cloth"
	worn_icon = 'icons/mob/clothing/neck.dmi'
	worn_icon_state = "scarf_base"
	greyscale_colors = "#EEEEEE#EEEEEE"
	greyscale_config = /datum/greyscale_config/scarf
	greyscale_config_worn = /datum/greyscale_config/scarf/worn
	cold_protection = NECK
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/beanie/knitted
	name = "Knitted Beanie"
	desc = "A stylish knitted beanie. The perfect winter accessory!."
	icon = 'knittables.dmi'
	icon_state = "beanie_cloth"
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	worn_icon_state = "beanie_base"
	greyscale_config = /datum/greyscale_config/beanie
	greyscale_config_worn = /datum/greyscale_config/beanie/worn
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/neck/mantle/recolorable/knitted
	name = "Knitted Mantle"
	desc = "A decorative drape over the shoulders. This one looks simple, but is quite soft to the touch."
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/mantle
	greyscale_config_worn = /datum/greyscale_config/mantle/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/mantle/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/mantle/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/mantle/worn/oldvox
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	worn_icon_state = "mantle"

/obj/item/clothing/suit/hooded/wintercoat/knitted
	name = "Knitted Winter Coat"
	desc = "A knitted coat, made of yarn. It's soft to the touch, and quite warm!"
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatwinter"
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	worn_icon_state = "coatwinter"
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/hooded_wintercoat
	hood_down_overlay_suffix = "_hood"
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/hooded/winterhood/knitted
	name = "winter hood"
	desc = "A cozy winter hood attached to a heavy winter coat."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	icon_state = "hood_winter"
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	worn_icon_state = "coatwinter_hood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor_type = /datum/armor/hooded_winterhood

/obj/item/clothing/gloves/color/grey/protects_cold/knitted
	name = "Knitted Gloves"
	desc = "A pair of thick grey gloves, lined to protect the wearer from freezing cold."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	icon_state = "thief"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	worn_icon_state = "wgloves"
	w_class = WEIGHT_CLASS_NORMAL
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/under/misc/pj/red/knitted
	name = "Knitted Pajamas"
	desc = "Warm and cozy looking pjs. They're soft and warm to the touch!"
	worn_icon = 'icons/mob/clothing/under/misc.dmi'
	worn_icon_state = "red_pyjamas"
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/under/sweater/knitted
	name = "Knitted Sweater"
	desc = "A warm looking sweater. It'll keep your top warm...But there's nothing to say for your legs with this cozy bit of clothing."
	icon = 'knittables.dmi'
	icon_state = "cableknit_top"
	greyscale_config = /datum/greyscale_config/cableknit_sweater
	greyscale_config_worn = /datum/greyscale_config/cableknit_sweater/worn
	greyscale_colors = "#b2a484"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses.dmi'
	worn_icon_state = "cableknit_top"

/obj/item/clothing/suit/sweater/knitted_top
	name = "Knitted Shirt"
	desc = "A knitted top. Seems cozy!"
	icon = 'knittables.dmi'
	icon_state = "turtleskirt_top"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses.dmi'
	worn_icon_state = "turtleskirt_top"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/neck/cloak/skill_reward/knit
	name = "Legendary Knitting Cloak"
	desc = "A cloak only those truly devoted to knitting can aquire."
	icon = 'knittables.dmi'
	icon_state = "knitting_cloak"
	worn_icon = 'knittables_worn.dmi'
	worn_icon_state = "cloak_knitting"
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE

/obj/item/clothing/neck/cloak/knittable
	name = "Knittable Cloak"
	desc = "A hand-knit cloak."
	icon = 'knittables.dmi'
	icon_state = "cloak_colorable"
	worn_icon = 'knittables_worn.dmi'
	worn_icon_state = "cloak_colorable_sheet"
