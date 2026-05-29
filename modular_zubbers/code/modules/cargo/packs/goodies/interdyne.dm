/datum/supply_pack/goody/interdyne_chameleon
	name = "Advanced Chameleon ID Card Single-Pack"
	desc = "Contains one advanced chameleon ID card. Exclusive to Interdyne Express."
	cost = PAYCHECK_COMMAND * 15
	order_flags = parent_type::order_flags | ORDER_INTERDYNE_ONLY
	contains = list(/obj/item/card/id/advanced/chameleon)
