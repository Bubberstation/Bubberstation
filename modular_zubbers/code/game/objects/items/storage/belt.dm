/obj/item/storage/belt/sabre/centcom
	name = "CentCom sabre sheath"
	desc = "A luxury, and expensive-looking sheath designed with pure gold, and soft fibers to keep a blade clean, while also proving to hold a commander's blade."
	icon = 'modular_zubbers/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_righthand.dmi'
	icon_state = "cc_sheathe"
	inhand_icon_state = "cc_sheathe"
	worn_icon_state = "cc_sheathe"

/obj/item/storage/belt/sabre/centcom/PopulateContents()
	new /obj/item/melee/sabre/centcom(src)
	update_appearance()
