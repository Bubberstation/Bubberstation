/obj/item/circuitboard/machine/plantgenes
	name = "Plant DNA Manipulator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/plantgenes
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/scanning_module = 1)

/obj/item/circuitboard/machine/megacell_charger
	name = "Megacell charger (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/cell_charger/mega
	req_components = list(/datum/stock_part/capacitor = 3)
	needs_anchored = FALSE

//Port Tarkon Exclusive Machines

/obj/item/circuitboard/machine/rdserver/tarkon
	name = "Tarkon Industries R&D Server"
	build_path = /obj/machinery/rnd/server/tarkon

/obj/item/circuitboard/machine/protolathe/tarkon
	name = "Tarkon Industries Protolathe"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/rnd/production/protolathe/tarkon
