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

/// The iron and glass a high-capacity cell costs to build on its own, per the cell's own design
#define CELL_MATERIAL_COST list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.6)

// Screw-Wrench-Wirecutter combo machine

/datum/design/colony_power_driver
	name = "Powered Driver"
	id = "colony_power_drive"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/screwdriver/omni_drill
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/datum/design/colony_power_driver/New()
	. = ..()
	materials[/datum/material/iron] += CELL_MATERIAL_COST[/datum/material/iron]
	materials[/datum/material/glass] = CELL_MATERIAL_COST[/datum/material/glass]
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

/datum/design/colony_power_driver/create_result(atom/drop_loc, list/custom_materials, amount)
	var/obj/item/screwdriver/omni_drill/driver = ..()
	give_charged_cell(driver)
	return driver

// Slow prybar that swings hard when wielded in both hands

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

/// Loads a charged cell straight into a tool's cell component. The cell's own build cost is already
/// folded into the design's materials, so this isn't free, it's just built into the one print
/datum/design/proc/give_charged_cell(obj/item/tool)
	var/datum/component/cell/cell_component = tool.GetComponent(/datum/component/cell)
	if(isnull(cell_component) || cell_component.inserted_cell)
		return
	var/obj/item/stock_parts/power_store/cell/high/fresh_cell = new(tool)
	cell_component.inserted_cell = fresh_cell
	cell_component.handle_cell_overlays(TRUE)

// Welder that takes no fuel or power to run but is quite slow, at least it sounds cool as hell

/datum/design/colony_arc_welder
	name = "Arc Welder"
	id = "colony_arc_welder"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/weldingtool/electric/arc_welder
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

/datum/design/colony_arc_welder/create_result(atom/drop_loc, list/custom_materials, amount)
	var/obj/item/weldingtool/electric/arc_welder/welder = ..()
	give_charged_cell(welder)
	return welder

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

// Plain mining satchel, until the station has researched the bluespace one

/datum/design/colony_mining_satchel
	name = "Mining Satchel"
	id = "colony_mining_satchel"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/storage/bag/ore
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING,
	)

#undef CELL_MATERIAL_COST
