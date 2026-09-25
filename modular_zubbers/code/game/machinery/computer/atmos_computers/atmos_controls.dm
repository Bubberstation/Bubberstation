// Port Tarkon Atmos Control

/obj/machinery/computer/atmos_control/tarkon
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon
	reconnecting = FALSE // this is hardwired to main station chambers

/obj/machinery/computer/atmos_control/tarkon/oxygen_tank
	name = "Tarkon Oxygen Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/oxygen_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_O2 = "Oxygen Supply")

/obj/machinery/computer/atmos_control/tarkon/plasma_tank
	name = "Tarkon Plasma Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/plasma_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_PLAS = "Plasma Supply")

/obj/machinery/computer/atmos_control/tarkon/mix_tank
	name = "Tarkon Mix Chamber Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/mix_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_MIX = "Mix Chamber")

/obj/machinery/computer/atmos_control/tarkon/nitrogen_tank
	name = "Tarkon Nitrogen Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/nitrogen_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_N2 = "Nitrogen Supply")

/obj/machinery/computer/atmos_control/tarkon/nitrous_tank
	name = "Tarkon Nitrous Oxide Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/nitrous_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_N2O = "Nitrous Oxide Supply")

/obj/machinery/computer/atmos_control/tarkon/carbon_tank
	name = "Tarkon Carbon Dioxide Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/carbon_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_CO2 = "Carbon Dioxide Supply")

/obj/machinery/computer/atmos_control/tarkon/incinerator
	name = "Tarkon Incinerator Chamber Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/incinerator
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_INCINERATOR = "Incinerator Chamber")
