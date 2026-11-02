/datum/techweb_node/colony_fabricator_special_tools
	display_name = "Colony Fabricator Tool Designs"
	description = "Contains all of the colony fabricator's tool designs."
	unlocked_designs = list(
		/datum/design/colony_power_driver,
		/datum/design/colony_door_crowbar,
		/datum/design/colony_arc_welder,
		/datum/design/colony_compact_drill,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY) // God save you
	node_flags = TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

// Screw-Wrench-Wirecutter combo machine
/datum/design/colony_power_driver
	name = "Powered Driver"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/screwdriver/omni_drill
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Crowbar that is completely normal except it can force doors

/datum/design/colony_door_crowbar
	name = "Prybar"
	// build_type = COLONY_FABRICATOR // Zubber Edit: Takes it out of the all-too-easy to acquire RCF
	build_path = /obj/item/crowbar/large/doorforcer
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

// Slightly slower drill that fits in backpacks

/datum/design/colony_compact_drill
	name = "Compact Mining Drill"
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
