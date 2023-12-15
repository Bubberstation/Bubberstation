//Adds Red Security outfit variants to the security equipment reskin menu.


/obj/item/storage/backpack/security/Initialize(mapload)
	unique_reskin["Red Variant"] = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "backpack-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_INHAND_L = 'icons/mob/inhands/equipment/backpack_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/equipment/backpack_righthand.dmi',
			RESKIN_INHAND_STATE = "securitypack"
		)
	. = ..()

/obj/item/storage/backpack/satchel/sec/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "satchel-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_INHAND_L = 'icons/mob/inhands/equipment/backpack_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/equipment/backpack_righthand.dmi',
			RESKIN_INHAND_STATE = "satchel-sec"
		)
	. = ..()

/obj/item/storage/backpack/duffelbag/sec/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "duffel-security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_INHAND_L = 'icons/mob/inhands/equipment/backpack_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/equipment/backpack_righthand.dmi',
			RESKIN_INHAND_STATE = "duffel-sec"
		)
	. = ..()

/obj/item/clothing/head/security_cap/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/clothing/head/hats.dmi',
			RESKIN_ICON_STATE = "secsoft",
			RESKIN_WORN_ICON = 'icons/mob/clothing/head/hats.dmi'
		)
	. = ..()

/obj/item/clothing/gloves/color/black/security/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "black",
			RESKIN_WORN_ICON = 'icons/mob/clothing/hands.dmi'
		)
	. = ..()

/obj/item/clothing/under/rank/security/officer/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON_STATE = "rsecurity",
			RESKIN_WORN_ICON_STATE = "rsecurity"
		)
	. = ..()

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/clothing/shoes.dmi',
			RESKIN_ICON_STATE = "jackboots",
		)
	. = ..()
