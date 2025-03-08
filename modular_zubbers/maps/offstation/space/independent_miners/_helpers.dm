/obj/effect/mapping_helpers/airlock/access/any/independent_miner/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_INDMINER
	return access_list


/obj/effect/mapping_helpers/airlock/access/any/independent_miner/cap/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_INDMINER_CAPTAIN
	return access_list
