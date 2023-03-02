/obj/effect/mapping_helpers/airlock/access/any/supply/blacksmith/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BLACKSMITH
	return access_list
