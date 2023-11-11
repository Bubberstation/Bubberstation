/obj/item/storage/belt/sabre/centcom
	name = "Commander's sabre sheath"
	desc = "A expensive sheath made of pure gold, and exotic fabric to house an even more expensive sword, this one has CENTRAL COMMAND etched into the gold stripe, and a nice white stripe."
	icon = 'modular_zubbers/icons/obj/clothing/belts.dmi'
	icon_state = "cent_sheath"
	inhand_icon_state = "cent_sheath"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts.dmi'
	worn_icon_state = "cent_sheath"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_righthand.dmi'

/obj/item/storage/belt/sabre/centcom/PopulateContents()
	new /obj/item/melee/sabre/centcom(src)
	update_appearance()