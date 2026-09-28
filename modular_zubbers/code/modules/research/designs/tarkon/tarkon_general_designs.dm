/datum/design/hoplite_assembly
	name = "Hoplite Turret Assembly"
	desc = "A deployable turret kit designed for basic construct defense. This one makes the \"Hoplite\" model."
	id = "hoplite_assembly"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		)
	build_path = /obj/item/turret_assembly/hoplite
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_WEAPONS_KITS
	)

/datum/design/cerberus_assembly
	name = "Cerberus Turret Assembly"
	desc = "A deployable turret kit designed for basic construct defense. This one makes the \"Cerberus\" model."
	id = "cerberus_assembly"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/turret_assembly/cerberus
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_WEAPONS_KITS,
	)

/datum/design/target_designator
	name = "Turret Target Designator"
	desc = "A basic target designator designed to control magazine-fed turrets."
	id = "target_designator"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/target_designator
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_WEAPONS_KITS,
	)

/datum/design/mod_plating/tarkon
	name = "MOD Tarkon Plating"
	id = "mod_plating_tarkon"
	build_path = /obj/item/mod/construction/plating/tarkon
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	research_icon_state = "tarkon-plating"
	research_icon = 'modular_skyrat/modules/tarkon/icons/obj/mod_construct.dmi'

/datum/design/arcs
	name = "A.R.C.S Resonator"
	id = "arcs"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/gun/energy/recharge/resonant_system
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/tarkonrcd
	name = "Tarkon R.C.D"
	desc = "A Rapid Construction Device made by Tarkon Industries. Capable of ranged construction."
	id = "rcd_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3
		)
	transfered_materials = list(
		/obj/item/construction/rcd/arcd/tarkon/loaded = /obj/item/construction/rcd/arcd/tarkon::custom_materials
	)
	build_path = /obj/item/construction/rcd/arcd/tarkon/loaded
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tarkonhackc
	name = "Tarkon Hack-C Signaller"
	desc = "A small device that signals a 'Hack-C' drone to repair specialized machinery."
	id = "hackc"
	build_path = /obj/item/hackc
	category = list(
		RND_CATEGORY_TOOLS
	)
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
