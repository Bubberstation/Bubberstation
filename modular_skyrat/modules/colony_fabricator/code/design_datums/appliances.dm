// Machine categories

#define FABRICATOR_CATEGORY_APPLIANCES "/Appliances"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"
#define FABRICATOR_SUBCATEGORY_ATMOS "/Atmospherics"
#define FABRICATOR_SUBCATEGORY_FLUIDS "/Liquids"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/Materials"
#define FABRICATOR_SUBCATEGORY_SUSTENANCE "/Sustenance"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_appliances
	display_name = "Colony Fabricator Appliance Designs"
	description = "Contains all of the colony fabricator's appliance machine designs."
	unlocked_designs = list(
		/datum/design/wall_mounted_multi_charger,
		/datum/design/portable_gas_pump,
		/datum/design/portable_gas_scrubber,
		/datum/design/survival_knife, // I just don't want to make a whole new node for this one sorry
		/datum/design/water_synthesizer,
		/datum/design/hydro_synthesizer,
		/datum/design/frontier_sustenance_dispenser,
		/datum/design/co2_cracker,
		/datum/design/portable_recycler,
		/datum/design/foodricator,
		/datum/design/wall_mounted_space_heater,
		/datum/design/macrowave,
		/datum/design/frontier_range,
		/datum/design/tabletop_griddle,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY) // God save you

/// Wall mountable multi cell charger
/datum/design/wall_mounted_multi_charger
	name = "Mounted Multi-Cell Charging Rack"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/wallframe/cell_charger_multi
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 15 SECONDS

/// Portable scrubber and pumps for all your construction atmospherics needs
/datum/design/portable_gas_pump
	name = "Portable Air Pump"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/machinery/portable_atmospherics/pump
	inherit_materials = DESIGN_INHERIT_MATS_SPECIAL //these machines have their own hand-craft recipes
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 30 SECONDS

/datum/design/portable_gas_scrubber
	name = "Portable Air Scrubber"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/machinery/portable_atmospherics/scrubber
	inherit_materials = DESIGN_INHERIT_MATS_SPECIAL //these machines have their own hand-craft recipes
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 30 SECONDS

/// Space heater, but it mounts on walls
/datum/design/wall_mounted_space_heater
	name = "Mounted Heater"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/wallframe/wall_heater
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 15 SECONDS

/// Plumbable chem machine that makes nothing but water
/datum/design/water_synthesizer
	name = "Water Synthesizer"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/water_synth
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_FLUIDS,
	)
	construction_time = 30 SECONDS

/// Plumbable chem machine that makes nothing but water
/datum/design/hydro_synthesizer
	name = "Hydroponics Chemical Synthesizer"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/hydro_synth
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_FLUIDS,
	)
	construction_time = 30 SECONDS

/// Chem dispenser that dispenses various flavored beverages and nutrislop, yum!
/datum/design/frontier_sustenance_dispenser
	name = "Sustenance Dispenser"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/sustenance_machine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_SUSTENANCE,
	)
	construction_time = 30 SECONDS

/// CO2 cracker, portable machines that takes CO2 and turns it into oxygen
/datum/design/co2_cracker
	name = "Portable Carbon Dioxide Cracker"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, // We're gonna pretend plasma is the catalyst for co2 cracking
	)
	build_path = /obj/item/flatpacked_machine/co2_cracker
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 30 SECONDS

/// A portable recycling machine, use item with materials on it to recycle
/datum/design/portable_recycler
	name = "Portable Recycler"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT, // Titan for the crushing element
	)
	build_path = /obj/item/flatpacked_machine/recycler
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 30 SECONDS

/// Rations printer, turns biomass into seeds, some synthesized foods, ingredients, so on
/datum/design/foodricator
	name = "Organic Rations Printer"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/organics_ration_printer
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_SUSTENANCE,
	)
	construction_time = 30 SECONDS

/// Really, its just a microwave
/datum/design/macrowave
	name = "Microwave Oven"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/macrowave
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_SUSTENANCE,
	)
	construction_time = 30 SECONDS

/// A range, but it looks cool af
/datum/design/frontier_range
	name = "Frontier Range"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/frontier_range
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_SUSTENANCE,
	)
	construction_time = 1 MINUTES

/// Griddles that fit on top of any regular table
/datum/design/tabletop_griddle
	name = "Tabletop Griddle"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/frontier_griddle
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_SUSTENANCE,
	)
	construction_time = 1 MINUTES

#undef FABRICATOR_CATEGORY_APPLIANCES
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_ATMOS
#undef FABRICATOR_SUBCATEGORY_FLUIDS
#undef FABRICATOR_SUBCATEGORY_MATERIALS
#undef FABRICATOR_SUBCATEGORY_SUSTENANCE
