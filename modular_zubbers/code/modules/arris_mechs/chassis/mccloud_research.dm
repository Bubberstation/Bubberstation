#define TECHWEB_NODE_MECH_AGILE "mech_agile"
#define RND_CATEGORY_MECHFAB_MCCLOUD "/McCloud"
#define RND_SUBCATEGORY_EXOSUIT_BOARDS_MCCLOUD "/McCloud"

/datum/techweb_node/mech_agile
	id = TECHWEB_NODE_MECH_AGILE
	display_name = "Agile Exosuits"
	description = "Advanced exosuit with built-in zero-gravity flight capabilities. Ideal for combatting spaceborne threats."
	prereq_ids = list(TECHWEB_NODE_MECH_LIGHT)
	design_ids = list(
		"mccloud_armor",
		"mccloud_chassis",
		"mccloud_torso",
		"mccloud_left_arm",
		"mccloud_right_arm",
		"mccloud_left_leg",
		"mccloud_right_leg",
		"mccloud_main",
		"mccloud_peri",
		"mccloud_targ",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/design/board/mccloud_main
	name = "\"McCloud\" Central Control module"
	desc = "Allows for the construction of a \"McCloud\" Central Control module."
	id = "mccloud_main"
	build_path = /obj/item/circuitboard/mecha/mccloud/main
	category = list(
		RND_CATEGORY_EXOSUIT_BOARDS + RND_SUBCATEGORY_EXOSUIT_BOARDS_MCCLOUD
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mccloud_peri
	name = "\"McCloud\" Peripherals Control module"
	desc = "Allows for the construction of a \"McCloud\" Peripheral Control module."
	id = "mccloud_peri"
	build_path = /obj/item/circuitboard/mecha/mccloud/peripherals
	category = list(
		RND_CATEGORY_EXOSUIT_BOARDS + RND_SUBCATEGORY_EXOSUIT_BOARDS_MCCLOUD
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mccloud_targ
	name = "\"McCloud\" Weapons & Targeting Control module"
	desc = "Allows for the construction of a \"McCloud\" Weapons & Targeting Control module."
	id = "mccloud_targ"
	build_path = /obj/item/circuitboard/mecha/mccloud/targeting
	category = list(
		RND_CATEGORY_EXOSUIT_BOARDS + RND_SUBCATEGORY_EXOSUIT_BOARDS_MCCLOUD
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mccloud_armor
	name = "Exosuit Armor (\"McCloud\")"
	id = "mccloud_armor"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/mccloud_armor
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10, /datum/material/glass=SHEET_MATERIAL_AMOUNT * 5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/mccloud_chassis
	name = "Exosuit Chassis (\"McCloud\")"
	id = "mccloud_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/mccloud
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/mccloud_torso
	name = "Exosuit Torso (\"McCloud\")"
	id = "mccloud_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/mccloud_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3.75,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/mccloud_left_arm
	name = "Exosuit Left Arm (\"McCloud\")"
	id = "mccloud_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/mccloud_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/mccloud_right_arm
	name = "Exosuit Right Arm (\"McCloud\")"
	id = "mccloud_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/mccloud_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/mccloud_left_leg
	name = "Exosuit Left Leg (\"McCloud\")"
	id = "mccloud_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/mccloud_left_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/mccloud_right_leg
	name = "Exosuit Right Leg (\"McCloud\")"
	id = "mccloud_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/mccloud_right_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_MCCLOUD + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)
