/obj/item/turret_assembly/cerberus
	name = "cerberus plate assembly"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one is for a \"Cerberus\" model turret type."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus

/obj/item/turret_assembly/hoplite
	name = "hoplite plate assembly"
	icon = 'modular_skyrat/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "hoplite_assembly"
	desc = "A set of assembly parts for a magazine-fed turret, requiring a receiver, servo and sensor along with construction. This one is for a \"Hoplite\" model turret type."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		)
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
