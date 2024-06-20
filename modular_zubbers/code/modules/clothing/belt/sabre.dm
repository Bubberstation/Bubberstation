/obj/item/melee/sabre/centcom
	name = "commander's sabre"
	desc = "An superior and deadly, the blade and hilt is made with gold, yet alloyed with plasteel, reinforcing it's strength, and making a monomolecular edge that is more than capable of cutting through flesh and bone with ease."
	icon_state = "cc-sabre"
	inhand_icon_state = "cc-sabre"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/storage/belt/sabre/centcom
	name = "commander's sabre sheath"
	desc = "An extremely ornate, and soft sheath designed to hold a esteemed CentCom commander's blade."
	icon = 'modular_zubbers/icons/obj/weapons/sword.dmi'
	icon_state = "cc-sheath"
	inhand_icon_state = "cc-sheath"
	worn_icon_state = "cc-sheath"
	icon = 'modular_zubbers/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/sabre/centcom/PopulateContents()
	new /obj/item/melee/sabre/centcom(src)
	update_appearance()
