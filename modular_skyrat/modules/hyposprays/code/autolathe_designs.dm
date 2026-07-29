// Hypovials
/datum/design/hypovial
	name = "Hypovial"
	id = "hypovial"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/reagent_containers/cup/vial/small
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/hypovial/large
	name = "Large Hypovial"
	id = "large_hypovial"
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/reagent_containers/cup/vial/large

// Hypospray cases
/datum/design/hypokit
	name = "Hypospray Case"
	id = "hypokit"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/storage/hypospraykit/empty
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/hypokit/deluxe
	name = "Hypospray Case Deluxe"
	id = "hypokit_deluxe"
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/storage/hypospraykit/cmo/empty

// Hyposprays
/datum/design/hypomkii
	name = "Hypospray Mk. II"
	id = "hypomkii"
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
	id = "hypomkii_deluxe"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/device/custom_kit/deluxe_hypo2
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)

// Hypospray Research
/datum/techweb_node/chem_synthesis/New()
	design_ids += list(
		"hypovial",
		"large_hypovial",
		"hypokit",
		"hypomkii",
	)
	return ..()

/datum/techweb_node/medbay_equip_adv/New()
	design_ids += list(
		"hypokit_deluxe",
	)
	return ..()

/datum/techweb_node/alien_surgery/New()
	design_ids += list(
		"hypomkii_deluxe",
	)
	return ..()
