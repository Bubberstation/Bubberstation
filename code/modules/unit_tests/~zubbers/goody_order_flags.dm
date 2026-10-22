// order_flags = ORDER_CONTRABAND on a goody wipes ORDER_GOODY and ships it in an error crate. use parent_type::order_flags | ORDER_CONTRABAND
/datum/unit_test/goody_order_flags/Run()
	for(var/datum/supply_pack/pack_type as anything in subtypesof(/datum/supply_pack/goody) + subtypesof(/datum/supply_pack/company_import))
		if(!(initial(pack_type.order_flags) & ORDER_GOODY))
			TEST_FAIL("[pack_type] lost ORDER_GOODY. Add flags with order_flags = parent_type::order_flags | NEW_FLAG instead of replacing them.")

	// pod only packs are exempt, the empty supplypod is meant to arrive empty
	for(var/datum/supply_pack/pack_type as anything in subtypesof(/datum/supply_pack))
		if(initial(pack_type.crate_type) || initial(pack_type.test_ignored))
			continue
		if(initial(pack_type.order_flags) & (ORDER_GOODY | ORDER_POD_ONLY))
			continue
		TEST_FAIL("[pack_type] has no crate_type and is not a goody, so it would ship in an ERROR crate.")
