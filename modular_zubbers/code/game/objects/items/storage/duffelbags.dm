/obj/item/storage/backpack/hydro_duffel //No zipping or slowdown on this one, it's a duffelbag in name only
	name = "Elder Atmosian Duffel Bag"
	desc = "Extra large duffel bag reinforced with metal hydrogen for robust, yet lightweight combination. State of the art zipper never jams and lets the wearer access contents of the bag with no delay."
	icon = 'modular_zubbers/icons/obj/clothing/back/backpack.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-hydro"
	inhand_icon_state = "duffel-hydro"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/backpack_righthand.dmi'
	storage_type = /datum/storage/hydro_duffel
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 2)

/datum/storage/hydro_duffel
	max_total_storage = 35
	max_slots = 25
