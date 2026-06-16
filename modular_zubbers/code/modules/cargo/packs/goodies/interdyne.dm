/datum/supply_pack/goody/interdyne_chameleon
	name = "Advanced Chameleon ID Card Single-Pack"
	desc = "Contains one advanced chameleon ID card. Exclusive to Interdyne Express."
	cost = PAYCHECK_COMMAND * 15
	order_flags = parent_type::order_flags | ORDER_INTERDYNE_ONLY
	contains = list(/obj/item/card/id/advanced/chameleon)

/datum/supply_pack/goody/interdyne_condor
	name = "Regal Condor weapon parts kit"
	desc = "Contains one set of gun parts to assemble a Regal Condor. Due to the inclusion of several specially cut telecrystals within the suitcase, \
			and the fact that this shit is expensive to fabricate, we're charging you a bit extra."
	cost = PAYCHECK_COMMAND * 2500
	allow_non_private_purchase = TRUE
	order_flags = parent_type::order_flags | ORDER_INTERDYNE_ONLY
	contains = list(/obj/item/weaponcrafting/gunkit/regal_condor)
