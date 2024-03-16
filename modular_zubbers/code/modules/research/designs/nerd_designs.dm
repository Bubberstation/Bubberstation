//Nerd
/datum/design/nerd_suit
	name = "D.O.T.A. Suit"
	id = "nerd_suit"
	build_type = PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	build_path = /obj/item/clothing/suit/armor/nerd
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*20,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT
	)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	construction_time = 100

/datum/design/nerd_glases
	name = "Ultra Nerd Glasses"
	id = "nerd_glases"
	build_type = PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	build_path = /obj/item/clothing/glasses/regular/hipster/nerd
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*2
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	construction_time = 50

//Advanced Nerd
/datum/design/fast_crowbar
	name = "Physicist's Crowbar"
	id = "fast_crowbar"
	build_type = PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	build_path = /obj/item/crowbar/large/heavy/science
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*2 //Bluespace makes it go faster :^)
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	construction_time = 50


/datum/design/physgun
	name = "Physics Manipulation Tool"
	id = "physgun"
	build_type = PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	build_path = /obj/item/physic_manipulation_tool
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*10,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*5
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	construction_time = 100


