/obj/item/circuitboard/machine/powerator/interdyne
	name = "Ancient Powerator"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/powerator/interdyne

/obj/machinery/powerator/interdyne
	name = "ancient powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources! It appears to be an earlier variant before environmental regulation reduced its efficiency."
	circuit = /obj/item/circuitboard/machine/powerator/interdyne

	/// how much the current_power is divided by to determine the profit
	divide_ratio = 0.00001
	/// the account credits will be sent towards
	credits_account = ACCOUNT_INT

/obj/machinery/powerator/interdyne/RefreshParts()
	. = ..()
	max_power = clamp(max_power, 0, 1000000) //limit to 1MW so ghost roles cannot start a war with station using OP gear
