/obj/effect/mapping_helpers/airlock/access/any/supply/blacksmith/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BLACKSMITH
	return access_list

// Lizard Gas access helper
/obj/effect/mapping_helpers/airlock/access/all/lizard_gas
	layer = DOOR_ACCESS_HELPER_LAYER
	icon_state = "access_helper"

/obj/effect/mapping_helpers/airlock/access/all/lizard_gas/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_LZGAS
	return access_list
