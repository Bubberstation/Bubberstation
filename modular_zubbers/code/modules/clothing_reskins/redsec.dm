//Adds Red Security outfit variants to the security equipment reskin menu.


/obj/item/storage/backpack/security/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
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

/obj/item/clothing/under/rank/security/officer/Initialize(mapload)
	if (!unique_reskin)
		. = ..()
	else
		unique_reskin["RedSec Variant"] = list(
				RESKIN_ICON_STATE = "rsecurity",
				RESKIN_WORN_ICON_STATE = "rsecurity"
			)
		. = ..()

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/clothing/shoes.dmi',
			RESKIN_ICON_STATE = "jackboots_sec",
		)
	. = ..()

/obj/item/clothing/suit/armor/vest/alt/sec/Initialize(mapload)
	unique_reskin["RedSec Variant"] = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "armor_sec",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
		)
	. = ..()

/obj/item/storage/belt/security/Initialize(mapload)
	if (!unique_reskin)
		. = ..()
	else
		unique_reskin["RedSec Variant"] = list(
				RESKIN_ICON = 'icons/obj/clothing/belts.dmi',
				RESKIN_ICON_STATE = "security",
				RESKIN_WORN_ICON = 'icons/mob/clothing/belt.dmi',
				RESKIN_WORN_ICON_STATE = "security",
			)
		. = ..()

/obj/item/clothing/glasses/hud/security/sunglasses/Initialize(mapload)
	if (!unique_reskin)
		. = ..()
	else
		unique_reskin["RedSec Variant"] = list(
				RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
				RESKIN_ICON_STATE = "sunhudsec",
				RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			)
		. = ..()
