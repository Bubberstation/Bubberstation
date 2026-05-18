/obj/item/storage/belt/webbing
	name = "webbing"
	desc = "A sturdy mess of synthetic belts and buckles, ready to share your burden."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "webbing"
	worn_icon_state = "webbing"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing/colonial_webbing
	name = "colonial webbing vest"
	desc = "A versatile individual carrying equipment, cherished by colonists and hoarders alike."
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	icon_state = "accessory_webbing"
	worn_icon_state = "accessory_webbing"


/datum/storage/belt/webbing
	max_slots = 3
	max_specific_storage = WEIGHT_CLASS_SMALL
	silent = TRUE

//vest
/obj/item/storage/belt/webbing_vest
	name = "webbing vest"
	desc = "A robust vest with lots of pockets to hold whatever you need, ready to share your burdens."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "vest_brown"
	worn_icon_state = "vest_brown"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing_vest/black
	icon_state = "vest_black"
	worn_icon_state = "vest_black"

/obj/item/storage/belt/webbing_vest/white
	icon_state = "vest_white"
	worn_icon_state = "vest_white"

//drop pouches
/obj/item/storage/belt/webbing_pouch
	name = "drop pouches"
	desc = "A robust pair of drop pouches with good capacity, ready to share your burdens."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "thigh_brown"
	worn_icon_state = "thigh_brown"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing_pouch/black
	icon_state = "thigh_black"
	worn_icon_state = "thigh_black"

/obj/item/storage/belt/webbing_pouch/white
	icon_state = "thigh_white"
	worn_icon_state = "thigh_white"

//rigging
/obj/item/storage/belt/webbing_pilot
	name = "full rigging"
	desc = "A sturdy mess of synthetic belts and buckles, ready to share your burden."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "pilot_webbing1"
	worn_icon_state = "pilot_webbing1"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing_pilot/low
	name = "low slung rigging"
	icon_state = "pilot_webbing2"
	worn_icon_state = "pilot_webbing2"
