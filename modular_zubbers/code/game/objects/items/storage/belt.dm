/obj/item/storage/belt/sabre/centcom
	name = "commander's sabre sheath"
	desc = "An incredibly ornate sabre sheath, meant to hold a commander's sabre. The cloth it's made of is soft to the touch, whilst the gold is also of incredibly purity while also alloyed with plasteel."
	icon = 'modular_zubbers/icons/obj/clothing/belts.dmi'
	icon_state = "cc_sheath"
	inhand_icon_state = "cc_sheath"
	worn_icon_state = "cc_sheath"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/belt_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/sabre/centcom/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

	atom_storage.max_slots = 1
	atom_storage.rustle_sound = FALSE
	atom_storage.max_specific_storage = WEIGHT_CLASS_BULKY
	atom_storage.set_holdable(/obj/item/melee/sabre/centcom)
