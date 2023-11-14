/datum/supply_pack/science/secure_tech
	name = "Secure Tech Replacement"
	desc = "Lost your secure tech storage? Here's some replacements!"
	cost = CARGO_CRATE_VALUE * 15 //3000
	access = ACCESS_RD
	contains = list(
		/obj/item/circuitboard/computer/aiupload,
		/obj/item/circuitboard/computer/borgupload,
		/obj/item/circuitboard/computer/communications,
		/obj/item/circuitboard/computer/apc_control,
		/obj/item/circuitboard/computer/mecha_control,
		/obj/item/circuitboard/computer/robotics
	)

