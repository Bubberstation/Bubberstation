/obj/item/storage/belt/fannypack/webbing
	name = "webbing"
	desc = "A sturdy mess of synthetic belts and buckles, ready to share your burden."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "webbing"


/datum/atom_skin/webbing_vest
	abstract_type = /datum/atom_skin/webbing_vest

/datum/atom_skin/webbing_vest/brown
	preview_name = "Brown"
	new_icon_state = "vest_brown"

/datum/atom_skin/webbing_vest/black
	preview_name = "Black"
	new_icon_state = "vest_black"

/datum/atom_skin/webbing_vest/white
	preview_name = "Medical White"
	new_icon_state = "vest_white"

/obj/item/storage/belt/fannypack/webbing/vest
	name = "webbing vest"
	desc = "A robust vest with lots of pockets to hold whatever you need, ready to share your burdens."
	icon_state = "vest_brown"

/obj/item/storage/belt/fannypack/webbing/vest/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/webbing_vest)

/datum/atom_skin/drop_pouches
	abstract_type = /datum/atom_skin/drop_pouches

/datum/atom_skin/drop_pouches/brown
	preview_name = "Brown"
	new_icon_state = "thigh_brown"

/datum/atom_skin/drop_pouches/black
	preview_name = "Black"
	new_icon_state = "thigh_black"

/datum/atom_skin/drop_pouches/white
	preview_name = "White"
	new_icon_state = "thigh_white"

/obj/item/storage/belt/fannypack/webbing/pouch
	name = "drop pouches"
	desc = "A robust pair of drop pouches with good capacity, ready to share your burdens."
	icon_state = "thigh_brown"

/obj/item/storage/belt/fannypack/webbing/pouch/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/drop_pouches)

/obj/item/storage/belt/fannypack/webbing/pouch/black
	icon_state = "thigh_black"

/datum/atom_skin/storage_rigging
	abstract_type = /datum/atom_skin/storage_rigging

/datum/atom_skin/storage_rigging/full
	preview_name = "Full Rigging"
	new_icon_state = "pilot_webbing1"

/datum/atom_skin/storage_rigging/low_slung
	preview_name = "Low Slung"
	new_icon_state = "pilot_webbing2"

/obj/item/storage/belt/fannypack/webbing/pilot
	name = "storage rigging"
	icon_state = "pilot_webbing1"

/obj/item/storage/belt/fannypack/webbing/pilot/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/storage_rigging)

/obj/item/storage/belt/fannypack/colonial_webbing
	name = "colonial webbing vest"
	desc = "A versatile individual carrying equipment, cherished by colonists and hoarders alike."
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	icon_state = "accessory_webbing"
