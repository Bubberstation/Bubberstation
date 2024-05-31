/obj/item/circuitboard/machine/powerator/interdyne
	name = "Ancient Powerator"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/powerator/interdyne

/obj/machinery/powerator/interdyne
	name = "ancient powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources! It appears to be an earlier variant before environmental regulation reduced its efficiency."
	circuit = /obj/item/circuitboard/machine/powerator/interdyne

	/// the account credits will be sent towards
	credits_account = ACCOUNT_INT

/obj/machinery/powerator/interdyne/RefreshParts()
	. = ..()
	divide_ratio *= 2 //Make it easier for the folks down at Interdyne to make some CASH MONEY
