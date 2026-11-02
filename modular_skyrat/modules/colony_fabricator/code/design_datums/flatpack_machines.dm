// Machine categories

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/Flatpacked Machines"
#define FABRICATOR_SUBCATEGORY_MANUFACTURING "/Manufacturing"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/Materials"
#define FABRICATOR_SUBCATEGORY_ATMOS "/Atmospherics"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_flatpacks
	display_name = "Colony Fabricator Flatpack Designs"
	description = "Contains all of the colony fabricator's flatpack machine designs."
	unlocked_designs = list(
		/datum/design/flatpack_solar_panel,
		/datum/design/flatpack_solar_tracker,
		/datum/design/flatpack_arc_furnace,
		/datum/design/flatpack_colony_fabricator,
		/datum/design/flatpack_power_storage,
		/datum/design/flatpack_power_storage_large,
		/datum/design/flatpack_solids_generator,
		/datum/design/flatpack_rtg,
		/datum/design/flatpack_thermomachine,
		/datum/design/flatpack_ore_silo,
		/datum/design/flatpack_turbine_team_fortress_two,
		/datum/design/flatpack_bootleg_teg,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY) // God save you
	node_flags = TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

// Lets the colony lathe make more colony lathes but at very hihg cost, for fun

/datum/design/flatpack_colony_fabricator
	name = "Flat-Packed Colony Fabricator"
	desc = "A deployable fabricator capable of producing other flat-packed machines and other special equipment tailored for \
		rapidly constructing functional structures given resources and power. While it cannot be upgraded, it can be repacked \
		and moved to any location you see fit."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/flatpacked_machine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MANUFACTURING,
	)
	construction_time = 2 MINUTES

// Solar panels and trackers

/datum/design/flatpack_solar_panel
	name = "Flat-Packed Solar Panel"
	desc = "A deployable solar panel, able to be repacked after placement for relocation or recycling."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/flatpacked_machine/solar
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 5 SECONDS

/datum/design/flatpack_solar_tracker
	name = "Flat-Packed Solar Tracker"
	desc = "A deployable solar tracker, able to be repacked after placement for relocation or recycling."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5,
	)
	build_path = /obj/item/flatpacked_machine/solar_tracker
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 7 SECONDS

// Arc furance

/datum/design/flatpack_arc_furnace
	name = "Flat-Packed Arc Furnace"
	desc = "A deployable furnace for refining ores. While slower and less safe than conventional refining methods, \
		it multiplies the output of refined materials enough to still outperform simply recycling ore."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/flatpacked_machine/arc_furnace
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 15 SECONDS

// Power storage structures

/datum/design/flatpack_power_storage
	name = "Flat-Packed Stationary Battery"
	desc = "A deployable station-scale power cell with an overall low capacity, but high input and output rate."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/station_battery
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 20 SECONDS

/datum/design/flatpack_power_storage_large
	name = "Flat-Packed Large Stationary Battery"
	desc = "A deployable station-scale power cell with an overall extremely high capacity, but low input and output rate."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/large_station_battery
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 40 SECONDS

// PACMAN generator but epic!!

/datum/design/flatpack_solids_generator
	name = "Flat-Packed S.O.F.I.E. Generator"
	desc = "A deployable plasma-burning generator capable of outperforming even upgraded P.A.C.M.A.N. type generators, \
		at expense of creating hot carbon dioxide exhaust."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/fuel_generator
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Buildable RTG that is quite radioactive

/datum/design/flatpack_rtg
	name = "Flat-Packed Radioisotope Thermoelectric Generator"
	desc = "A deployable radioisotope generator capable of producing a practically free trickle of power. \
		Free if you can tolerate the radiation that the machine makes while deployed, that is."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/rtg
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Thermomachine with decent temperature change rate, but a limited max/min temperature

/datum/design/flatpack_thermomachine
	name = "Flat-Packed Atmospheric Temperature Regulator"
	desc = "A deployable temperature control device for use with atmospherics pipe systems. \
		Limited in its temperature range, however comes with a higher than normal heat capacity."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/thermomachine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 20 SECONDS

// Ore silo except it beeps

/datum/design/flatpack_ore_silo
	name = "Flat-Packed Ore Silo"
	desc = "An all-in-one materials management solution. Connects resource-using machines \
		through a network of distrobution systems."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/flatpacked_machine/ore_silo
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 1 MINUTES

// Wind turbine, produces tiny amounts of power when placed outdoors in an atmosphere, but makes significantly more if there's a storm in that area

/datum/design/flatpack_turbine_team_fortress_two
	name = "Flat-Packed Miniature Wind Turbine"
	desc = "A deployable fabricator capable of producing other flat-packed machines and other special equipment tailored for \
		rapidly constructing functional structures given resources and power. While it cannot be upgraded, it can be repacked \
		and moved to any location you see fit. This one makes specialized engineering designs and tools."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/wind_turbine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Stirling generator, kinda like a TEG but on a smaller scale and producing less insane amounts of power

/datum/design/flatpack_bootleg_teg
	name = "Flat-Packed Stirling Generator"
	desc = "An industrial scale stirling generator. Stirling generators operate by intaking \
		hot gasses through their inlet pipes, and being cooled by the ambient air around them. \
		The cycling compression and expansion that this creates creates power, and this one is made \
		to make power on the scale of small stations and outposts."
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/flatpacked_machine/stirling_generator
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 2 MINUTES

#undef FABRICATOR_CATEGORY_FLATPACK_MACHINES
#undef FABRICATOR_SUBCATEGORY_MANUFACTURING
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_MATERIALS
#undef FABRICATOR_SUBCATEGORY_ATMOS
