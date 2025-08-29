/obj/item/circuitboard/machine/atmos_shield_gen/tier_two
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier2,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier2,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/tier_three
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier3,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier3,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/tier_four
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier4,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier4,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/tier_five
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier5,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier5,
	)

/obj/item/circuitboard/machine/scrap_beacon
	name = "Scrap Beacon"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/scrap_beacon
	req_components = list(/datum/stock_part/capacitor = 1)

/obj/item/circuitboard/machine/scrap_compactor
	name = "Scrap Compactor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/scrap_compactor
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		)
