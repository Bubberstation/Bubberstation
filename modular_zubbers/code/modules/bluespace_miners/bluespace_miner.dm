//Initial Machine setup
/obj/machinery/bluespace_miner/ore
	name = "bluespace ore miner"
	desc = "Through the power of bluespace, it is capable of producing raw materials."
	circuit = /obj/item/circuitboard/machine/bluespace_miner/ore

	ore_chance = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/glass/basalt = 20,
		/obj/item/stack/ore/plasma = 14,
		/obj/item/stack/ore/silver = 8,
		/obj/item/stack/ore/titanium= 8,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/xenoarch/strange_rock = 3,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/diamond = 1,
	)

//Circuit Board
/obj/item/circuitboard/machine/bluespace_miner/ore
	name = "Raw Ore Bluespace Miner"
	desc = "An older model of bluespace miner that, when provided the correct temperature and pressure, will produce raw materials."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/bluespace_miner/ore
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)
	needs_anchored = TRUE

//design
/datum/design/board/bluespace_miner/ore
	name = "Machine Design (Bluespace Raw Ore Miner)"
	desc = "Allows for the construction of circuit boards used to build a bluespace miner."
	id = "bluespace_miner_ore"
	build_type = AWAY_IMPRINTER //set to away so that NT stations by default cannot build it.
	build_path = /obj/item/circuitboard/machine/bluespace_miner/ore
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

//techweb node
/datum/techweb_node/bluespace_miner_ore
	id = "bluespace_miner_ore"
	display_name = "Bluespace Ore Miner"
	description = "An older version of bluespace miners, used to mine raw ores from the great bluespace sea."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
