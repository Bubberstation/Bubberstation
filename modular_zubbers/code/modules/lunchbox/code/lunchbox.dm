/obj/item/storage/lunchbox
	name = "lunchbox"
	icon = 'modular_zubbers/code/modules/lunchbox/icons/lunchbox.dmi'
	icon_state = "lunchbox"
	desc = "It's fucked, yell at coders."
	inhand_icon_state = "lunchbox"
	lefthand_file = 'modular_zubbers/code/modules/lunchbox/icons/lunchbox_lefthand.dmi'
	righthand_file = 'modular_zubbers/code/modules/lunchbox/icons/lunchbox_righthand.dmi'
	drop_sound = 'sound/items/handling/cardboard_box/cardboardbox_drop.ogg'
	pickup_sound =  'sound/items/handling/cardboard_box/cardboardbox_pickup.ogg'
	throw_speed = 3
	throw_range = 7

/obj/item/storage/lunchbox/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.set_holdable(list(
		/obj/item/food,
		/obj/item/reagent_containers/cup,
		))

/obj/item/storage/lunchbox/nanotrasen
	name = "nanotrasen lunchbox"
	icon_state = "lunchbox_nanotrasen"
	inhand_icon_state = "lunchbox_nanotrasen"
	desc = "A refined blue lunchbox to show your support for everyone's favourite megacorporation."

/obj/item/storage/lunchbox/medical
	name = "medical lunchbox"
	icon_state = "lunchbox_medical"
	inhand_icon_state = "lunchbox_medical"
	desc = "A green lunchbox, designed for hungry doctors."

/obj/item/storage/lunchbox/bunny
	name = "rabbit lunchbox"
	icon_state = "lunchbox_bunny"
	inhand_icon_state = "lunchbox"
	desc = "An adorable lunchbox with a rabbit printed on it."

/obj/item/storage/lunchbox/corgi
	name = "corgi lunchbox"
	icon_state = "lunchbox_corgi"
	inhand_icon_state = "lunchbox"
	desc = "An adorable lunchbox with a corgi printed on it."

/obj/item/storage/lunchbox/heart
	name = "heart lunchbox"
	icon_state = "lunchbox_heart"
	inhand_icon_state = "lunchbox_heart"
	desc = "A pink lunchbox with a heart pattern printed on it."

/obj/item/storage/lunchbox/safetymoth
	name = "safety moth lunchbox"
	icon_state = "lunchbox_safetymoth"
	inhand_icon_state = "lunchbox_safetymoth"
	desc = "An orange, lead lined lunchbox with everyone's favourite moth printed on it."

/obj/item/storage/lunchbox/amongus
	name = "suspicious lunchbox"
	icon_state = "lunchbox_suspicious"
	inhand_icon_state = "lunchbox_suspicious"
	desc = "A plain red lunchbox... right?"
