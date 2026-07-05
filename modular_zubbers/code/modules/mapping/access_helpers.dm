/obj/effect/mapping_helpers/airlock/access/any/service/barber/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BARBER
	return access_list

/obj/effect/mapping_helpers/airlock/access/all/service/barber/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BARBER
	return access_list

/obj/effect/mapping_helpers/airlock/access/any/supply/blacksmith/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BLACKSMITH
	return access_list

/obj/effect/mapping_helpers/airlock/access/all/supply/blacksmith/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BLACKSMITH
	return access_list
