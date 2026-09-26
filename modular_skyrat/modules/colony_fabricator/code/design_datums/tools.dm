/datum/techweb_node/colony_fabricator_special_tools
	id = TECHWEB_NODE_COLONY_TOOLS
	display_name = "Colony Fabricator Tool Designs"
	description = "Contains all of the colony fabricator's tool designs."
	design_ids = list(
		"colony_power_drive",
		"colony_prybar",
		"colony_arc_welder",
		"colony_compact_drill",
		"colony_multitool",
		"colony_mining_satchel",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Screw-Wrench-Wirecutter combo machine

/datum/design/colony_power_driver
	name = "Powered Driver"
	id = "colony_power_drive"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/screwdriver/omni_drill
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.45,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.6,
	)
	transfered_materials = list(
		/obj/item/screwdriver/omni_drill = /obj/item/screwdriver/omni_drill::custom_materials,
		/obj/item/stock_parts/power_store/cell/high = /obj/item/stock_parts/power_store/cell/high::custom_materials,
	)
	research_icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	research_icon_state = "drill_charged"
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Prybar

/datum/design/colony_door_crowbar
	name = "Prybar"
	id = "colony_prybar"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/crowbar/large/colony_prybar
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Welder that takes no fuel or power to run but is quite slow, at least it sounds cool as hell

/datum/design/colony_arc_welder
	name = "Arc Welder"
	id = "colony_arc_welder"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/weldingtool/electric/arc_welder
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT + SHEET_MATERIAL_AMOUNT * 0.7,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT + SMALL_MATERIAL_AMOUNT * 0.6,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	transfered_materials = list(
		/obj/item/weldingtool/electric/arc_welder = /obj/item/weldingtool/electric/arc_welder::custom_materials,
		/obj/item/stock_parts/power_store/cell/high = /obj/item/stock_parts/power_store/cell/high::custom_materials,
	)
	research_icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	research_icon_state = "arc_welder_charged"
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Slightly slower drill that fits in backpacks

/datum/design/colony_compact_drill
	name = "Compact Mining Drill"
	id = "colony_compact_drill"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/pickaxe/drill/compact
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING,
	)

/datum/design/colony_multitool
	name = "Field Multitool"
	id = "colony_multitool"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/multitool/colony
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.2,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Plain mining satchel

/datum/design/colony_mining_satchel
	name = "Mining Satchel"
	id = "colony_mining_satchel"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/storage/bag/ore
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING,
	)
