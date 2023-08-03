//PUT ALL ITEMS THAT NEED TO BE CHANGED FOR A KNITABLE SPRITE HERE

/obj/item/clothing/accessory/armband/knitted
	name = "Armband"
	desc = "A fancy knitted armband!"
	icon_state = "medband"
	attachment_slot = null

/obj/item/clothing/suit/costume/ghost_sheet/knitted
	name = "Ghost Costume"
	desc = "A totally spooky ghost costume! It appears to have been knitted."

/obj/item/clothing/neck/scarf/knitted
	name = "Knitted scarf"
	desc = "Did your grandmother make this?"
	icon = 'previews.dmi'
	icon_state = "scarf_cloth"
	greyscale_colors = "#4A4A4B#4A4A4B"
	cold_protection = NECK
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/beanie/knitted
	name = "Knitted Beanie"
	desc = "A stylish knitted beanie. The perfect winter accessory!."
	icon = 'previews.dmi'
	icon_state = "beanie_cloth"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
/obj/item/clothing/head/beret/knitted
	name = "Knitted Beret"
	desc = "A knitted beret. How fancy!"
	icon = 'previews.dmi'
	icon_state = "beret_flat"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/neck/mantle/recolorable/knitted
	name = "Knitted Mantle"
	desc = "A decorative drape over the shoulders. This one looks simple, but is quite soft to the touch."

/obj/item/clothing/suit/hooded/wintercoat/knitted
	name = "Knitted Winter Coat"
	desc = "A knitted coat, made of yarn. It's soft to the touch, and quite warm!"
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatwinter"
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/hooded_wintercoat
	hood_down_overlay_suffix = "_hood"
	var/zipped = FALSE
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/hooded/winterhood/knitted
	name = "winter hood"
	desc = "A cozy winter hood attached to a heavy winter coat."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	icon_state = "hood_winter"
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor_type = /datum/armor/hooded_winterhood

/obj/item/clothing/gloves/color/grey/protects_cold/knitted
	name = "Knitted Gloves"
	desc = "A pair of thick grey gloves, lined to protect the wearer from freezing cold."
	w_class = WEIGHT_CLASS_NORMAL
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/under/misc/pj/red/knitted
	name = "Knitted Pajamas"
	desc = "Warm and cozy looking pjs. They're soft and warm to the touch!"
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/under/sweater/knitted
	name = "Knitted Sweater"
	desc = "A warm looking sweater. It'll keep your top warm...But there's nothing to say for your legs with this cozy bit of clothing."
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/under/sweater/keyhole/knitted
	name = "Knitted Keyhole Sweater"
	desc = "Someone's gone through the trouble of knitting a hole in this cozy little sweater...It doesn't seem like it'd be too insulating."

