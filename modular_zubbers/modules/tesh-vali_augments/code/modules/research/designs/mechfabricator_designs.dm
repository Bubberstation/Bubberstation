//adding raptoral silicon stuff to the mechfabricator

/datum/design/raptoral_cyber_chest
	name = "Raptoral Cybernetic Torso"
	id = "raptoral_cyber_chest"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/chest/robot/raptoral
	materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 6)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_cyber_head
	name = "Raptoral Cybernetic Head"
	id = "raptoral_cyber_head"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/head/robot/raptoral
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 0.75)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_cyber_l_arm
	name = "Raptoral Cybernetic Left Forelimb"
	id = "raptoral_cyber_l_arm"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/left/robot/raptoral
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_cyber_r_arm
	name = "Raptoral Cybernetic Right Forelimb"
	id = "raptoral_cyber_r_arm"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/right/robot/raptoral
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_cyber_l_leg
	name = "Raptoral Cybernetic Left Hindlimb"
	id = "raptoral_cyber_l_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot/raptoral
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_cyber_r_leg
	name = "Raptoral Cybernetic Right Hindlimb"
	id = "raptoral_cyber_r_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot/raptoral
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

//advanced augmentations since those were added in the recent upstream

/datum/design/raptoral_advanced_l_arm
	name = "Advanced Raptoral Cybernetic Left Forelimb"
	id = "raptoral_advanced_l_arm"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/left/robot/advanced/raptoral
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_advanced_r_arm
	name = "Advanced Raptoral Cybernetic Right Forelimb"
	id = "raptoral_advanced_r_arm"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/right/robot/advanced/raptoral
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_advanced_l_leg
	name = "Advanced Raptoral Cybernetic Left Hindlimb"
	id = "raptoral_advanced_l_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot/advanced/raptoral
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)

/datum/design/raptoral_advanced_r_leg
	name = "Advanced Raptoral Cybernetic Right Hindlimb"
	id = "raptoral_advanced_r_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot/advanced/raptoral
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_RAPTORAL
	)
