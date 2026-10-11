// Hypovials
/datum/design/hypovial
	name = "Hypovial"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/reagent_containers/cup/vial/small
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/hypovial/large
	name = "Large Hypovial"
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/reagent_containers/cup/vial/large

// Hypospray cases
/datum/design/hypokit
	name = "Hypospray Case"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/storage/hypospraykit/empty
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/hypokit/deluxe
	name = "Hypospray Case Deluxe"
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/storage/hypospraykit/cmo/empty

// Hyposprays
/datum/design/hypomkii
	name = "Hypospray Mk. II"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/hypospray/mkii
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

// Hypospray upgrade
/datum/design/hypomkii/deluxe
	name = "Hypospray Mk. II Deluxe Upgrade"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	transfered_materials = list(/obj/item/custom_kit/deluxe_hypo2 = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 8))
	build_path = /obj/item/custom_kit/deluxe_hypo2
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)

// Hypospray Research
/datum/techweb_node/chem_synthesis/New()
	unlocked_designs += list(
		/datum/design/hypovial,
		/datum/design/hypovial/large,
		/datum/design/hypokit,
		/datum/design/hypomkii,
	)
	return ..()

/datum/techweb_node/medbay_equip_adv/New()
	unlocked_designs += list(
		/datum/design/hypokit/deluxe,
	)
	return ..()

/datum/techweb_node/alien_surgery/New()
	unlocked_designs += list(
		/datum/design/hypomkii/deluxe,
	)
	return ..()
