/datum/supply_pack/materials/glass50 // Introduced with the GMM disable. Delete this file when the GMM gets fixed.
	name = "50 Glass Sheets"
	desc = "Let some nice light in with fifty glass sheets!"
	cost = CARGO_CRATE_VALUE * 3.25
	contains = list(/obj/item/stack/sheet/glass/fifty)
	order_flags = ORDER_CONTRABAND
	crate_name = "glass sheets crate"
	test_ignored = TRUE

/datum/supply_pack/materials/iron50
	name = "50 Iron Sheets"
	desc = "Any construction project begins with a good stack of fifty iron sheets!"
	cost = CARGO_CRATE_VALUE * 3.25
	contains = list(/obj/item/stack/sheet/iron/fifty)
	order_flags = ORDER_CONTRABAND
	crate_name = "iron sheets crate"
	test_ignored = TRUE

/datum/supply_pack/materials/plasteel20
	name = "20 Plasteel Sheets"
	desc = "Reinforce the station's integrity with twenty plasteel sheets!"
	cost = CARGO_CRATE_VALUE * 3.4
	contains = list(/obj/item/stack/sheet/plasteel/twenty)
	order_flags = ORDER_CONTRABAND
	crate_name = "plasteel sheets crate"

/datum/supply_pack/materials/plasteel50
	name = "50 Plasteel Sheets"
	desc = "For when you REALLY have to reinforce something."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/stack/sheet/plasteel/fifty)
	order_flags = ORDER_CONTRABAND
	crate_name = "plasteel sheets crate"
