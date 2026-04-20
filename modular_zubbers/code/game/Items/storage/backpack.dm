/obj/item/storage/backpack/duffelbag/med/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/medical_duffelbag)

/datum/atom_skin/medical_duffelbag
	abstract_type = /datum/atom_skin/medical_duffelbag

/datum/atom_skin/medical_duffelbag/korve
	preview_name = "korve"
	new_icon_state = "duffel-med"
	new_worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	new_icon = 'modular_zubbers/icons/obj/storage/backpack.dmi'
	new_left_inhand = 'modular_zubbers/icons/mob/inhands/equipment/backpack_lefthand.dmi'
	new_right_inhand = 'modular_zubbers/icons/mob/inhands/equipment/backpack_righthand.dmi'

/datum/atom_skin/medical_duffelbag/default
	preview_name = "default"
	new_icon_state = "duffel-medical"
	new_worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	new_icon = 'icons/obj/storage/backpack.dmi'
	new_left_inhand = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	new_right_inhand = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	new_inhand_icon_state = "duffel-med"
